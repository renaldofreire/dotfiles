# --- STARSHIP E CONFIGURAÇÃO BÁSICA ZSH ---
# Substitui o Oh My Zsh pelo Starship (mais rápido e escrito em Rust)

# --- CONFIGURAÇÕES GERAIS ---
# Remove duplicatas do PATH e define caminhos essenciais
typeset -U path
path=("$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/bin" "/usr/local/bin" $path)
export EDITOR="nvim"

# Histórico robusto (compartilhado entre abas)
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_REDUCE_BLANKS

# Habilita auto-completion nativo do zsh (já que removemos o Oh My Zsh)
fpath=(/usr/share/zsh/site-functions $fpath)
autoload -Uz compinit
compinit

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
alias sync-calibre='rsync -av --delete "/home/ref/calibre-local/" "/mnt/calibre-library/"'

# EZA (substituto moderno do exa)
# ls -> eza
alias ls='eza --color=always --group-directories-first'
alias ll='eza -lh --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias lla='eza -lah --color=always --group-directories-first'

# tree using eza
alias tree='eza --tree'

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
# Mantido simples por padrão, use eza se preferir
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

# Claude in 9router
alias claude-nemotron='ANTHROPIC_BASE_URL="http://localhost:20128/v1" ANTHROPIC_API_KEY="sk-9router-local" ANTHROPIC_MODEL="nvidia-nemotro-3" claude'
alias claude-gemini='ANTHROPIC_BASE_URL="http://localhost:20128/v1" ANTHROPIC_API_KEY="sk-9router-local" ANTHROPIC_MODEL="claude-gemini-4free" claude'
alias claude-gemini36='ANTHROPIC_BASE_URL="http://localhost:20128/v1" ANTHROPIC_API_KEY="sk-9router-local" ANTHROPIC_MODEL="gemini-3-6flash" claude'

# Bypass do TMUX
alias opencode="env -u TMUX env -u TMUX_PANE opencode"

# export ANTHROPIC_BASE_URL="http://localhost:20128/v1"
# export ANTHROPIC_API_KEY="9router"

# Inicializa o Starship (mantenha isso no final do arquivo)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

# Carrega os plugins leves (Zsh-autosuggestions, Syntax-highlighting e Substring-search)
# Certifique-se de instalá-los: sudo pacman -S zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh 2>/dev/null

# Configura atalhos das setas para Cima/Baixo usarem a busca inteligente por histórico
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# Fallback para o modo de aplicação (comum no Tmux)
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
# Fallbacks originais com terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up 2>/dev/null
bindkey "$terminfo[kcud1]" history-substring-search-down 2>/dev/null


