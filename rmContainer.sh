#!/bin/bash

# Verifica se foi fornecido o ID do container como argumento
if [ $# -eq 0 ]; then
  echo "Informe o ID do container como argumento."
  exit 1
fi

# Define o ID do container
container_id="$1"

# Obtém todos os volumes associados ao container
volumes=$(docker volume ls -q -f "label=com.docker.compose.project=$container_id")

# Obtém todas as imagens associadas ao container
imagens=$(docker ps --filter "id=$container_id" --format "{{.Image}}")

# Remove o container específico
docker rm "$container_id"

# Remove os volumes associados ao container
for volume in $volumes; do
  docker volume rm "$volume"
done

# Remove as imagens associadas ao container
for imagem in $imagens; do
  docker image rm "$imagem"
done

# Remove as redes associadas ao container
docker network rm $(docker network ls -q -f "label=com.docker.compose.project=$container_id")
