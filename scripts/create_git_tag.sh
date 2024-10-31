#!/bin/bash

# Define o diretório do script
SCRIPT_DIR=$(dirname "$0")

# Caminho para o pubspec.yaml
FILE="$SCRIPT_DIR/../pubspec.yaml"

# Verifica se o arquivo existe
if [[ ! -f $FILE ]]; then
  echo "Erro: arquivo pubspec.yaml não encontrado em $FILE"
  exit 1
fi

# Lê a versão atual do pubspec.yaml
CURRENT_VERSION=$(grep 'version:' $FILE | awk '{print $2}')

# Separa a versão em número e build
VERSION=$(echo $CURRENT_VERSION | cut -d'+' -f1)

# Exibe a versão atual
echo "Versão atual do aplicativo: $VERSION"

# Solicita uma descrição da tag
echo "Digite a descrição da tag:"
read TAG_DESCRIPTION

# Cria uma tag anotada com a versão e a descrição
git tag -a "v$VERSION" -m "$TAG_DESCRIPTION"

# Faz o push da nova tag para o repositório remoto
git push origin "v$VERSION"

echo "Tag v$VERSION criada com a descrição: \"$TAG_DESCRIPTION\" e enviada com sucesso!"
