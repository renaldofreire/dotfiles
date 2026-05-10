# 🚀 Guia de Migração e Instalação

Este guia explica como replicar estas configurações em uma nova máquina de forma rápida e segura.

## 📋 Pré-requisitos
O script de instalação suporta automaticamente distros baseadas em **Debian/Ubuntu** e **Arch Linux**. Para outras distros, instale `git` e `stow` manualmente antes de começar.

## ⚡ Instalação Rápida (Recomendado)

1. Clone o repositório:
   ```bash
   git clone --recursive https://github.com/renaldofreire/dotfiles.git ~/dotfiles
   ```

2. Entre na pasta e execute o script de instalação:
   ```bash
   cd ~/dotfiles
   chmod +x install.sh
   ./install.sh
   ```

O que o script faz:
- Instala `git` e `stow` se necessário.
- Baixa todos os plugins e temas (Submodules).
- Cria os links simbólicos para todas as pastas (usando `stow`).
- Resolve conflitos básicos (se houver um `.bashrc` padrão, ele o substitui pela sua versão).

---

## 🛠️ Instalação Manual (Passo a Passo)

Se preferir fazer manualmente ou precisar de mais controle:

### 1. Clonar e baixar plugins
```bash
git clone --recursive https://github.com/renaldofreire/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Aplicar módulos individuais
Use o `stow` para cada programa que deseja configurar:
```bash
stow bashrc
stow qtile
stow mpv
stow alacritty
```

### 3. Atualizar Plugins futuramente
Como usamos **Git Submodules**, para atualizar todos os temas e plugins externos de uma vez:
```bash
git submodule update --remote --merge
```

---

## ⚠️ Notas Importantes
- **Conflitos:** Se o Stow disser que um arquivo já existe, você deve remover o arquivo original da sua pasta Home (`~`) para que o link simbólico possa ser criado.
- **Software:** Este repositório sincroniza as **configurações**, mas não instala os programas. Lembre-se de instalar o `qtile`, `mpv`, `alacritty`, etc., pelo gerenciador de pacotes da sua distro.
