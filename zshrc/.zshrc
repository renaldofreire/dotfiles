# --- OH MY ZSH CONFIGURATION ---
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
# ZSH_THEME="bira"
# ZSH_THEME="af-magic"

# Plugins recomendados para seu setup
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

# Carrega o Oh My Zsh
source $ZSH/oh-my-zsh.sh

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
alias day1='$HOME/.config/alacritty/scripts/theme_switcher.sh day1'
alias night1='$HOME/.config/alacritty/scripts/theme_switcher.sh night1'
alias day2='$HOME/.config/alacritty/scripts/theme_switcher.sh day2'
alias night2='$HOME/.config/alacritty/scripts/theme_switcher.sh night2'

# Sincroniza o tema dinâmico ao abrir o terminal
if [ -f "$HOME/.config/alacritty/scripts/theme_switcher.sh" ]; then
    "$HOME/.config/alacritty/scripts/theme_switcher.sh" > /dev/null
fi

# --- ALIASES E FUNÇÕES PERSONALIZADOS ---
# Geral
alias feh='feh --scale-down --auto-zoom'
alias vim='nvim'
alias v='nvim'
alias vs='vscodium'
alias n='node'
alias pru='paru'
alias py='python3'
alias tk='task'
alias sudo='sudo '
alias notes='v /home/renaldo/Dropbox/Apps/Notes/notebook.md'
alias mux='tmuxinator'
alias fetch='fastfetch'
alias ports='sudo netstat -tulpn'

# Navegação (Goto)
alias cddown='cd ~/Downloads/'
alias cdqtile='cd ~/.config/qtile/'
alias cddoc='cd ~/Documents/'
alias cdproj='cd ~/projects/'
alias cddot='cd ~/dotfiles/'
alias cdconf='cd ~/.config/'
alias cdvim='cd ~/.config/nvim/'
alias cdmedia='/run/user/1000/gvfs/smb-share:server=10.1.0.129,share=nas-media'

# Git
alias g='git'
gcom() {
    git add .
    git commit -m "$1"
}
lazyg() {
    git add .
    git commit -m "$1"
    git push
}

# Utilitários de Sistema
alias ls='ls --color=auto' # Mantido simples por padrão, use eza se preferir
alias ll='ls -lah'
alias ..='cd ..'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias free="free -mt"
alias pru='paru'

# yt-dlp
alias yt-dlp-mp3-max='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias yt-dlp-video-max='yt-dlp -f "bestvideo+bestaudio/best"'
alias yt-dlp-subs-pt-en='yt-dlp --skip-download --write-subs --write-auto-subs --sub-langs en,pt --sub-format ttml --convert-subs srt --output "transcript.%(ext)s"'

# Manutenção (Arch Linux)
alias ua-drop-caches='sudo paccache -rk3; paru -Sc --aur --noconfirm'
alias ua-update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && ua-drop-caches \
      && paru -Syyu --noconfirm'

# Mindfulness (Zenta)
alias breath='zenta now --quick'
alias breathe='zenta now'
alias anchor='zenta anchor'
alias reflect='zenta reflect'

# Carrega perfil se existir
[ -f ~/.profile ] && source ~/.profile

# --- TMUX AUTOSTART ---
# Inicia ou anexa a uma sessão do tmux automaticamente em terminais interativos
if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_TTY" ]]; then
    # Tenta anexar à sessão 'default', se não existir, cria uma nova
    tmux attach-session -t default 2>/dev/null || tmux new-session -s default
fi

# Writer in Blog
write_blog() {
    if [ "$#" -ne 3 ]; then
        echo "Uso correto: write_blog arquivo_entrada.txt 'Seu Prompt Aqui' arquivo_saida.md"
        return 1
    fi

    local texto_contexto=$(cat "$1")
    local prompt_completo="$2. Texto de contexto: $texto_contexto"

    # Correção: alterado --bool para --argjson
    jq -n --arg model "blogger-pro" --arg prompt "$prompt_completo" --argjson stream false \
       '{model: $model, prompt: $prompt, stream: $stream}' | \
    curl -s -X POST http://localhost:11434/api/generate -H "Content-Type: application/json" -d @- | \
    jq -r '.response' > "$3"

    echo "✨ Texto gerado com sucesso e 100% limpo em $3!"
}
