#!/usr/bin/env bash

# Entrar no diretório para fazer o link relativo
cd "$HOME/.config/alacritty/"

THEME_DIR="themes/themes"
CURRENT_THEME="current-theme.toml"

LIGHT_THEME="$THEME_DIR/catppuccin_latte.toml"
DARK_THEME="$THEME_DIR/catppuccin_mocha.toml"

HOUR=$(date +%H)

if [ "$HOUR" -ge 08 ] && [ "$HOUR" -lt 17 ]; then
    ln -sf "$LIGHT_THEME" "$CURRENT_THEME"
else
    ln -sf "$DARK_THEME" "$CURRENT_THEME"
fi
