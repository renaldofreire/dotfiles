#!/usr/bin/env bash

THEME_DIR="$HOME/.config/alacritty/themes/themes"
CURRENT_THEME="$HOME/.config/alacritty/current-theme.toml"

LIGHT_THEME="$THEME_DIR/catppuccin_latte.toml"
DARK_THEME="$THEME_DIR/catppuccin_mocha.toml"

HOUR=$(date +%H)

if [ "$HOUR" -ge 08 ] && [ "$HOUR" -lt 17 ]; then
    ln -sf "$LIGHT_THEME" "$CURRENT_THEME"
else
    ln -sf "$DARK_THEME" "$CURRENT_THEME"
fi
