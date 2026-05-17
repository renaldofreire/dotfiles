#!/usr/bin/env bash

# 1. DEFINIÇÕES DE CAMINHOS ABSOLUTOS
ALACRITTY_DIR="$HOME/.config/alacritty"
THEME_DIR="$ALACRITTY_DIR/themes/themes"
CURRENT_THEME_LINK="$ALACRITTY_DIR/current-theme.toml"
CONFIG_FILE="$ALACRITTY_DIR/alacritty.toml"

# 2. DEFINIÇÕES DE CORES PARA SINCRONIZAÇÃO TMUX
# Gruvbox Colors
GRUV_LIGHT_FG="#3c3836"
GRUV_LIGHT_ACCENT="#af3a03"
GRUV_DARK_FG="#ebdbb2"
GRUV_DARK_ACCENT="#fabd2f"

# Catppuccin Colors
LATTE_FG="#4c4f69"
LATTE_ACCENT="#ea76cb"
MOCHA_FG="#cdd6f4"
MOCHA_ACCENT="#89b4fa"

# 3. DETERMINAÇÃO DO MODO
MODE=$1

# Se não passar argumento, tenta determinar pelo horário (Padrão Set 1 - Gruvbox)
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
        TMUX_FLAVOR="latte" # Usamos latte como base para temas claros no tmux
        NVIM_THEME="gruvbox_light"
        FG_COLOR=$GRUV_LIGHT_FG
        ACCENT=$GRUV_LIGHT_ACCENT
        ;;
    "night1")
        ALACRITTY_THEME="$THEME_DIR/gruvbox_material_hard_dark.toml"
        TMUX_FLAVOR="mocha" # Usamos mocha como base para temas escuros no tmux
        NVIM_THEME="gruvbox_dark"
        FG_COLOR=$GRUV_DARK_FG
        ACCENT=$GRUV_DARK_ACCENT
        ;;
    "day2")
        ALACRITTY_THEME="$THEME_DIR/catppuccin_latte.toml"
        TMUX_FLAVOR="latte"
        NVIM_THEME="latte"
        FG_COLOR=$LATTE_FG
        ACCENT=$LATTE_ACCENT
        ;;
    "night2")
        ALACRITTY_THEME="$THEME_DIR/catppuccin_mocha.toml"
        TMUX_FLAVOR="mocha"
        NVIM_THEME="mocha"
        FG_COLOR=$MOCHA_FG
        ACCENT=$MOCHA_ACCENT
        ;;
    *)
        echo "Uso: theme_switcher.sh [day1|night1|day2|night2]"
        exit 1
        ;;
esac

echo "--- Sincronizando Sistema ($MODE) ---"

# 4. ATUALIZAR ALACRITTY
if [ -f "$ALACRITTY_THEME" ]; then
    rm -f "$CURRENT_THEME_LINK"
    ln -s "$ALACRITTY_THEME" "$CURRENT_THEME_LINK"
    touch "$CONFIG_FILE"
    echo "[✓] Alacritty: $(basename "$ALACRITTY_THEME")"
else
    echo "[!] Erro: Arquivo de tema não encontrado: $ALACRITTY_THEME"
fi

# 5. ATUALIZAR TMUX
if [ -n "$TMUX" ]; then
    tmux set-option -g @catppuccin_flavor "$TMUX_FLAVOR"
    tmux set-option -g status-style "bg=default,fg=$FG_COLOR"
    
    # Diferenciação visual para modo claro/escuro
    if [[ "$MODE" == *"day"* ]]; then
        tmux set-window-option -g window-status-current-format "#[fg=$ACCENT,bold,reverse] #W #[default]"
    else
        tmux set-window-option -g window-status-current-format "#[fg=$ACCENT,bold,reverse] #W #[default]"
    fi
    tmux set-window-option -g window-status-format "#[fg=$FG_COLOR,dim] #W "
    
    PLUGIN_PATH=$(find ~/.config/tmux/plugins ~/.tmux/plugins -name "catppuccin.tmux" 2>/dev/null | head -n 1)
    if [ -n "$PLUGIN_PATH" ]; then tmux run-shell "$PLUGIN_PATH"; fi
    
    tmux refresh-client -S
    echo "[✓] Tmux: Sincronizado ($TMUX_FLAVOR)"
fi

# 6. ATUALIZAR NEOVIM
# Envia comando para instâncias ativas
if command -v nvim > /dev/null; then
    # Mapeamento para o comando interno do nvim (Day1 -> gruvbox_light, etc)
    nvim --server /tmp/nvim.pipe --remote-send ":Theme $NVIM_THEME<CR>" 2>/dev/null
    echo "[✓] Neovim: Comando de troca enviado ($NVIM_THEME)"
fi
