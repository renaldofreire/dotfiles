#!/usr/bin/env bash

# 1. DEFINIÇÕES DE CAMINHOS ABSOLUTOS
ALACRITTY_DIR="$HOME/.config/alacritty"
THEME_DIR="$ALACRITTY_DIR/themes/themes"
CURRENT_THEME_LINK="$ALACRITTY_DIR/current-theme.toml"
CONFIG_FILE="$ALACRITTY_DIR/alacritty.toml"

# 2. DETERMINAÇÃO DO MODO
MODE=$1

# Se não passar argumento, determina pelo horário
if [ -z "$MODE" ]; then
    HOUR=$(date +%-H)
    if [ "$HOUR" -ge 8 ] && [ "$HOUR" -lt 17 ]; then
        MODE="day1"
    else
        MODE="night1"
    fi
fi

case $MODE in
    "day1")
        ALACRITTY_THEME="$THEME_DIR/gruvbox_light.toml"
        NVIM_THEME="gruvbox_light"
        ;;
    "night1")
        ALACRITTY_THEME="$THEME_DIR/gruvbox_material_hard_dark.toml"
        NVIM_THEME="gruvbox_dark"
        ;;
    "day2")
        ALACRITTY_THEME="$THEME_DIR/catppuccin_latte.toml"
        NVIM_THEME="latte"
        ;;
    "night2")
        ALACRITTY_THEME="$THEME_DIR/catppuccin_mocha.toml"
        NVIM_THEME="mocha"
        ;;
    *)
        echo "Uso: theme_switcher.sh [day1|night1|day2|night2]"
        exit 1
        ;;
esac

echo "--- Sincronizando Sistema ($MODE) ---"

# 3. ATUALIZAR ALACRITTY
if [ -f "$ALACRITTY_THEME" ]; then
    rm -f "$CURRENT_THEME_LINK"
    ln -s "$ALACRITTY_THEME" "$CURRENT_THEME_LINK"
    touch "$CONFIG_FILE"
    echo "[✓] Alacritty: $(basename "$ALACRITTY_THEME")"
else
    echo "[!] Erro: Arquivo de tema não encontrado: $ALACRITTY_THEME"
fi

# 4. ATUALIZAR TMUX (Modo Neutro)
if [ -n "$TMUX" ]; then
    tmux refresh-client -S
    echo "[✓] Tmux: Sincronizado"
fi

# 5. ATUALIZAR NEOVIM
if command -v nvim > /dev/null; then
    # Envia comando via RPC pipe
    nvim --server /tmp/nvim.pipe --remote-send ":Theme $NVIM_THEME<CR>" 2>/dev/null
    echo "[✓] Neovim: Comando de troca enviado ($NVIM_THEME)"
fi
