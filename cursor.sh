#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
    clear
    echo "                       !!! WARNING !!!"
    echo "              DO NOT run this script as root!"
    echo "              Press any key to exit..."
    read -s -n 1 -p " "
    exit
fi

# verifica se é uma distro baseada em debian
if [ -f /etc/debian_version ]; then
    echo "Debian-based distribution detected"
else
    echo "Non-Debian distribution detected"
    exit 1
fi

sudo apt update -y

if [ -f /usr/bin/pkcon ]; then
  sudo pkcon update -y
fi

sudo apt install libfuse2 fuse -y

CURSOR_API_URL="https://cursor.com/api/download?platform=linux-x64&releaseTrack=stable"
CURSOR_DOWNLOAD_INFO=$(curl -s "$CURSOR_API_URL")
CURSOR_DOWNLOAD_URL=$(echo "$CURSOR_DOWNLOAD_INFO" | grep -o '"downloadUrl":"[^"]*' | cut -d'"' -f4)

if [ -n "$CURSOR_DOWNLOAD_URL" ]; then
    echo "Downloading Cursor..."
    wget -O "$HOME/Downloads/Cursor.AppImage" "$CURSOR_DOWNLOAD_URL"
    chmod +x "$HOME/Downloads/Cursor.AppImage"
    
    # Ask user preference
    echo ""
    echo "How would you like to use Cursor?"
    echo "1) Extract and install to system (removes previous installations)"
    echo "2) Use as AppImage with GearLever"
    echo ""
    read -p "Enter your choice (1 or 2): " choice
    
    case $choice in
        1)
            echo "Extracting and installing Cursor to system..."
            
            # Remove previous installations
            if [ -d "$HOME/.local/share/cursor" ]; then
                echo "Removing previous Cursor installation..."
                rm -rf "$HOME/.local/share/cursor"
            fi
            
            if [ -f "$HOME/.local/share/applications/cursor.desktop" ]; then
                rm -f "$HOME/.local/share/applications/cursor.desktop"
            fi
            
            if [ -f "/usr/local/bin/cursor" ]; then
                sudo rm -f "/usr/local/bin/cursor"
            fi
            
            # Create temporary extraction directory
            TEMP_DIR=$(mktemp -d)
            cd "$TEMP_DIR"
            
            # Extract AppImage
            echo "Extracting AppImage..."
            "$HOME/Downloads/Cursor.AppImage" --appimage-extract
            
            # Create installation directory
            mkdir -p "$HOME/.local/share/cursor"
            
            # Copy all extracted content including hidden files
            echo "Installing Cursor files..."
            cp -r squashfs-root/usr/share/cursor/* "$HOME/.local/share/cursor/"
            
            # Copy icons to proper locations
            mkdir -p "$HOME/.local/share/icons/hicolor"
            if [ -d "squashfs-root/usr/share/icons/hicolor" ]; then
                cp -r squashfs-root/usr/share/icons/hicolor/* "$HOME/.local/share/icons/hicolor/"
            fi
            
            # Copy the main icon
            if [ -f "squashfs-root/co.anysphere.cursor.png" ]; then
                cp "squashfs-root/co.anysphere.cursor.png" "$HOME/.local/share/cursor/"
            fi
            
            # Create desktop entry
            cat > "$HOME/.local/share/applications/cursor.desktop" << EOF
[Desktop Entry]
Name=Cursor
Comment=The AI Code Editor
GenericName=Text Editor
Exec=$HOME/.local/share/cursor/cursor %F
Icon=$HOME/.local/share/cursor/co.anysphere.cursor.png
Type=Application
StartupNotify=false
StartupWMClass=Cursor
Categories=TextEditor;Development;IDE;
MimeType=application/x-cursor-workspace;text/plain;inode/directory;
Actions=new-empty-window;
Keywords=cursor;

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=$HOME/.local/share/cursor/cursor --new-window %F
Icon=$HOME/.local/share/cursor/co.anysphere.cursor.png
EOF
            
            # Create wrapper script for command line access (detached from terminal)
            echo "Creating terminal wrapper script..."
            sudo tee /usr/local/bin/cursor > /dev/null << 'EOF'
#!/usr/bin/env bash
# Cursor wrapper script - launches detached from terminal
exec setsid "$HOME/.local/share/cursor/cursor" "$@" >/dev/null 2>&1 &
EOF
            
            # Make wrapper executable
            sudo chmod +x /usr/local/bin/cursor
            
            # Update desktop database and icon cache
            update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null
            gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor/" 2>/dev/null
            
            # Clean up
            cd "$HOME"
            rm -rf "$TEMP_DIR"
            rm -f "$HOME/Downloads/Cursor.AppImage"
    
            echo "Cursor successfully installed to system!"
            echo "Installation directory: $HOME/.local/share/cursor"
            echo "Terminal wrapper: /usr/local/bin/cursor (detached execution)"
            echo "You can now launch it from applications menu or run 'cursor' in terminal."
            echo "The terminal will be freed when using the 'cursor' command."
            ;;
        2)
            # Open with GearLever
            echo "Installing GearLever..."
            sudo apt install flatpak -y
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y
            flatpak install flathub it.mijorus.gearlever -y

            flatpak run it.mijorus.gearlever "$HOME/Downloads/Cursor.AppImage"
            echo "Cursor downloaded and opened in GearLever!"
            ;;
        *)
            echo "Invalid choice. Opening with GearLever by default..."
            sudo apt install flatpak -y
            flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo -y
            flatpak install flathub it.mijorus.gearlever -y
            flatpak run it.mijorus.gearlever "$HOME/Downloads/Cursor.AppImage"
            echo "Cursor downloaded and opened in GearLever!"
            ;;
    esac
else
    echo "Error obtaining Cursor download URL"
fi