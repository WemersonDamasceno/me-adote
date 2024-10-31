#!/bin/bash

# Caminho do pubspec.yaml
FILE=../pubspec.yaml

# Lê a versão atual
CURRENT_VERSION=$(grep 'version:' $FILE | awk '{print $2}')

echo "Versão atual: $CURRENT_VERSION"

# Separa a versão e o build number
VERSION=$(echo $CURRENT_VERSION | cut -d'+' -f1)
VERSION_PARTS=(${VERSION//./ })
BUILD_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -f2)

# Incrementa o patch e reseta o build number
VERSION_PARTS[2]=$((VERSION_PARTS[2] + 1))
NEW_BUILD_NUMBER=1

# Junta a nova versão e o build number
NEW_VERSION="${VERSION_PARTS[0]}.${VERSION_PARTS[1]}.${VERSION_PARTS[2]}+$NEW_BUILD_NUMBER"

# Atualiza o arquivo pubspec.yaml com a nova versão
sed -i.bak "s/version: $CURRENT_VERSION/version: $NEW_VERSION/" $FILE

echo "Nova versão: $NEW_VERSION"

# Adiciona, comita e faz o push no Git
# git add .
# git commit -m "chore: update version app to version $NEW_VERSION"
# git push
