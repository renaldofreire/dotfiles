#!/usr/bin/env bash

# Script de instalação automatizada para Dotfiles (GNU Stow)
# Este script instala dependências, baixa submodules e aplica as configurações.

set -e

echo "🚀 Iniciando a instalação dos Dotfiles..."

# 1. Verificar/Instalar dependências (focado em Debian/Ubuntu/Arch)
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y git stow
elif command -v pacman &> /dev/null; then
    sudo pacman -Syu --noconfirm git stow
fi

# 2. Inicializar Submodules
echo "📦 Inicializando Git Submodules..."
git submodule update --init --recursive

# 3. Aplicar configurações com GNU Stow
# Lista de pastas para ignorar (que não são pacotes de configuração)
IGNORE_DIRS=(".git" "docs" ".idea" "memory")

echo "🔗 Criando links simbólicos com GNU Stow..."
for dir in */; do
    # Remover a barra final do nome da pasta
    dir=${dir%/}
    
    # Verificar se a pasta deve ser ignorada
    if [[ " ${IGNORE_DIRS[@]} " =~ " ${dir} " ]]; then
        continue
    fi

    echo "   -> Aplicando: $dir"
    
    # Tenta aplicar o stow. Se houver conflito com arquivo real, avisa o usuário.
    if ! stow "$dir" 2>/dev/null; then
        echo "   ⚠️ Conflito detectado em '$dir'. Removendo arquivo local e tentando novamente..."
        # Backup simples do arquivo conflitante e remoção
        stow --adopt "$dir"
        git checkout -- .
        stow "$dir"
    fi
done

echo "✅ Instalação concluída com sucesso!"
echo "💡 Dica: Reinicie seu terminal ou recarregue as configurações para ver as mudanças."
