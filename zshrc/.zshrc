# ==============================================================================
# ENVIRONMENT & PATH
# ==============================================================================
typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/bin" "/usr/local/bin" $path)
export EDITOR="nvim"

# 9router
[ -f ~/.config/secrets.env ] && source ~/.config/secrets.env

# Load generic profile if present
[ -f ~/.profile ] && source ~/.profile

# ==============================================================================
# HISTORY CONFIGURATION
# ==============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# ==============================================================================
# COMPLETION SYSTEM (Fast cache)
# ==============================================================================
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# ==============================================================================
# ALIASES
# ==============================================================================
# Theme management (recol)
alias rc='recol'
alias rcl='recol -L'
alias rcc='recol -j'

# General & Editors
alias vim='nvim'
alias v='nvim'
alias vs='vscodium'
alias feh='feh --scale-down --auto-zoom'
alias n='node'
alias py='python3'
alias tk='task'
alias sudo='sudo '
alias mux='tmuxinator'
alias fetch='fastfetch'
alias ports='sudo netstat -tulpn'
alias sync-calibre='rsync -av --delete "/home/ref/calibre-local/" "/mnt/calibre-library/"'

# Eza (modern replacement for ls/tree)
alias ls='eza --color=always --group-directories-first'
alias ll='eza -lh --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias lla='eza -lah --color=always --group-directories-first'
alias tree='eza --tree'

# Directory Navigation
alias ..='cd ..'
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

# System utilities & Maintenance
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias df='df -h'
alias free="free -mt"
alias pru='paru'
alias ua-drop-caches='sudo paccache -rk3; chmod -R u+w ~/.cache/paru 2>/dev/null; paru -Sc --aur --noconfirm'
alias ua-update-all='export TMPFILE="$(mktemp)"; \
    sudo true; \
    rate-mirrors --save=$TMPFILE arch --max-delay=21600 \
      && sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist-backup \
      && sudo mv $TMPFILE /etc/pacman.d/mirrorlist \
      && ua-drop-caches \
      && paru -Syyu --noconfirm'

# Media (yt-dlp)
alias yt-dlp-mp3-max='yt-dlp -x --audio-format mp3 --audio-quality 0'
alias yt-dlp-video-max='yt-dlp -f "bestvideo+bestaudio/best"'
alias yt-dlp-subs-pt-en='yt-dlp --skip-download --write-subs --write-auto-subs --sub-langs en,pt --sub-format ttml --convert-subs srt --output "transcript.%(ext)s"'

# Mindfulness (Zenta)
alias breath='zenta now --quick'
alias breathe='zenta now'
alias anchor='zenta anchor'
alias reflect='zenta reflect'

# ==============================================================================
# TMUX AUTOSTART
# ==============================================================================
if [[ -z "$TMUX" ]] && [[ -n "$PS1" ]] && [[ "$TERM" != "linux" ]] && [[ -z "$SSH_TTY" ]]; then
    tmux attach-session -t default 2>/dev/null || tmux new-session -s default
fi

# ==============================================================================
# PLUGINS & KEYBINDINGS
# ==============================================================================
# 1. Autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null

# 2. History substring search + keybindings
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey "$terminfo[kcuu1]" history-substring-search-up 2>/dev/null
bindkey "$terminfo[kcud1]" history-substring-search-down 2>/dev/null

# 3. Syntax highlighting (must always be loaded after other plugins and widgets)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# ==============================================================================
# PROMPT (Starship)
# ==============================================================================
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi
