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

# Lê a versão atual
CURRENT_VERSION=$(grep 'version:' $FILE | awk '{print $2}')

echo "Versão atual: $CURRENT_VERSION"

# Separa a versão e o build number
VERSION=$(echo $CURRENT_VERSION | cut -d'+' -f1)
BUILD_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -f2)

# Incrementa o build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))

# Monta a nova versão
NEW_VERSION="$VERSION+$NEW_BUILD_NUMBER"

# Atualiza o arquivo pubspec.yaml com a nova versão usando sed
sed -i.bak "s/version: $CURRENT_VERSION/version: $NEW_VERSION/" $FILE && rm ${FILE}.bak

echo "Nova versão: $NEW_VERSION"

# Adiciona, comita e faz o push no Git
git add $FILE
git commit -m "chore: update version app to version $NEW_VERSION"
git push

# Solicita uma descrição da tag
echo "Digite a descrição da tag:"
read TAG_DESCRIPTION

# Cria uma tag anotada com a descrição e envia para o repositório remoto
git tag -a "v$NEW_VERSION" -m "$TAG_DESCRIPTION"
git push origin "v$NEW_VERSION"

echo "Tag v$NEW_VERSION criada com a descrição: \"$TAG_DESCRIPTION\" e enviada com sucesso!"
