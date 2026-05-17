#!/usr/bin/env bash

# Determina o diretório base do Alacritty a partir da localização do script
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$BASE_DIR"

THEME_DIR="themes/themes"
CURRENT_THEME="current-theme.toml"

# Temas preferidos
LIGHT_THEME="$THEME_DIR/gruvbox_light.toml"
DARK_THEME="$THEME_DIR/catppuccin_mocha.toml"

# Pega a hora atual (0-23)
HOUR=$(date +%-H)

# Define o tema claro entre 08:00 e 16:59
if [ "$HOUR" -ge 8 ] && [ "$HOUR" -lt 17 ]; then
    TARGET_THEME="$LIGHT_THEME"
else
    TARGET_THEME="$DARK_THEME"
fi

# Cria o link simbólico para o tema atual
if ln -sf "$TARGET_THEME" "$CURRENT_THEME"; then
    # "Toca" no arquivo principal para forçar o Alacritty a recarregar
    touch "$BASE_DIR/alacritty.toml"
    echo "Tema Alacritty alterado para: $(basename "$TARGET_THEME")"

    # Sincronização com TMUX
    if [ -n "$TMUX" ]; then
        if [ "$TARGET_THEME" = "$LIGHT_THEME" ]; then
            FLAVOR="latte"
        else
            FLAVOR="mocha"
        fi
        
        # Atualiza o flavor do plugin catppuccin no tmux em tempo real
        tmux set-option -g @catppuccin_flavor "$FLAVOR"
        
        # Procura o arquivo do plugin catppuccin em locais comuns
        # Procuramos especificamente o arquivo de entrada do plugin
        PLUGIN_PATH=$(find ~/.config/tmux/plugins ~/.tmux/plugins -name "catppuccin.tmux" 2>/dev/null | head -n 1)
        
        if [ -n "$PLUGIN_PATH" ]; then
            tmux run-shell "$PLUGIN_PATH"
            tmux refresh-client -S
            echo "Tmux sincronizado ($FLAVOR)."
        else
            echo "Aviso: Plugin catppuccin.tmux não encontrado."
        fi
    fi
else
    echo "Erro ao trocar o tema."
    exit 1
fi
