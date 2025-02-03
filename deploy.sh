#!/bin/bash
set -e

git checkout main
git add .
git commit -m "Adicionando minha página na raiz"
git push origin main

# Gera os arquivos estáticos
hugo --minify

# Entra na pasta "public", que contém o site gerado
cd public

# Configura o branch gh-pages
#git init
#git remote add origin https://github.com/sampalu/guia-de-estudos.git
#git checkout -b gh-pages
git checkout gh-pages

# Adiciona e faz commit dos arquivos gerados
git add .
git commit -m "Atualizando site"

# Força o push para sobrescrever o branch gh-pages
git push --force origin gh-pages

# Volta para a pasta raiz
cd ..

