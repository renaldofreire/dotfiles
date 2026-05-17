
# --- SINCRONIZAÇÃO DE TEMAS UNIFICADA ---
# Atalhos para os 4 modos solicitados
alias day1='$HOME/.config/alacritty/scripts/theme_switcher.sh day1'
alias night1='$HOME/.config/alacritty/scripts/theme_switcher.sh night1'
alias day2='$HOME/.config/alacritty/scripts/theme_switcher.sh day2'
alias night2='$HOME/.config/alacritty/scripts/theme_switcher.sh night2'

# Sincroniza o tema dinâmico ao abrir o terminal (Padrão: Gruvbox Set 1)
if [ -f "$HOME/.config/alacritty/scripts/theme_switcher.sh" ]; then
    "$HOME/.config/alacritty/scripts/theme_switcher.sh" > /dev/null
fi
