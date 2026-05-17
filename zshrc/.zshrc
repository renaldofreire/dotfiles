# --- CONFIGURAÇÕES GERAIS ---
# Remove duplicatas do PATH e define caminhos essenciais
typeset -U path
path=("$HOME/.local/bin" "$HOME/bin" "/usr/local/bin" $path)
export EDITOR="nvim"

# Histórico robusto (compartilhado entre abas)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# --- SINCRONIZAÇÃO DE TEMAS UNIFICADA ---
# Seus atalhos originais mantidos
alias day1='$HOME/.config/alacritty/scripts/theme_switcher.sh day1'
alias night1='$HOME/.config/alacritty/scripts/theme_switcher.sh night1'
alias day2='$HOME/.config/alacritty/scripts/theme_switcher.sh day2'
alias night2='$HOME/.config/alacritty/scripts/theme_switcher.sh night2'

# Sincroniza o tema dinâmico ao abrir o terminal
if [ -f "$HOME/.config/alacritty/scripts/theme_switcher.sh" ]; then
    "$HOME/.config/alacritty/scripts/theme_switcher.sh" > /dev/null
fi

# --- ALIASES DE PRODUTIVIDADE ---
alias v='nvim'
alias ls='ls --color=auto'
alias ll='ls -lah'
alias ..='cd ..'
alias g='git'

# --- INTERFACE E COMPLETAMENTO ---
# Prompt minimalista: usuario@maquina pasta %
PROMPT='%F{blue}%n%f@%F{green}%m%f %F{cyan}%~%f %# '

# Habilita completamento inteligente
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Case-insensitive
