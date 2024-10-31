#!/bin/bash

# Caminho do pubspec.yaml
FILE=../pubspec.yaml

# Lê a versão atual
CURRENT_VERSION=$(grep 'version:' $FILE | awk '{print $2}')

echo "Versão atual: $CURRENT_VERSION"

# Separa a versão e o build number
VERSION=$(echo $CURRENT_VERSION | cut -d'+' -f1)
BUILD_NUMBER=$(echo $CURRENT_VERSION | cut -d'+' -f2)

# Incrementa o build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 3))

# Monta a nova versão
NEW_VERSION="$VERSION+$NEW_BUILD_NUMBER"

# Atualiza o arquivo pubspec.yaml com a nova versão
sed -i.bak "s/version: $CURRENT_VERSION/version: $NEW_VERSION/" $FILE

echo "Nova versão: $NEW_VERSION"

# Adiciona e comita no Git
git add .
git commit -m "chore: update version app to version $NEW_VERSION"
git push --force

echo "Versão atualizada com sucesso!"