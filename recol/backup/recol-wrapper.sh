#!/usr/bin/env bash
# Wrapper para o recol com sincronização de componentes de terminal (Alacritty, Neovim, Tmux e bat)

RECOL_BIN="$HOME/.cargo/bin/recol"

if [ ! -x "$RECOL_BIN" ]; then
    echo "Erro: Binário recol não encontrado em $RECOL_BIN" >&2
    exit 1
fi

"$RECOL_BIN" "$@"
EXIT_CODE=$?

# Se o comando executou com sucesso
if [ $EXIT_CODE -eq 0 ]; then
    # Evita sincronizações desnecessárias em chamadas de ajuda/consulta
    case "$1" in
        -h|--help|-V|--version|--logo|-L|--list)
            exit $EXIT_CODE
            ;;
    esac

    # 1. Sincroniza Tmux se houver sessão ativa
    if command -v tmux >/dev/null 2>&1 && tmux info >/dev/null 2>&1; then
        tmux refresh-client -S >/dev/null 2>&1 || true
    fi

    # 2. Sincroniza instâncias ativas do Neovim via RPC pipe
    if [ -S /tmp/nvim.pipe ] && command -v nvim >/dev/null 2>&1; then
        nvim --server /tmp/nvim.pipe --remote-send "<ESC>:source \$MYVIMRC<CR>" >/dev/null 2>&1 || true
    fi

    # 3. Sincroniza o tema do bat conforme a claridade do tema
    if command -v bat >/dev/null 2>&1 && command -v python3 >/dev/null 2>&1; then
        python3 -c '
import json, os, subprocess

try:
    proc = subprocess.run(["'$RECOL_BIN'", "-j"], capture_output=True, text=True, check=True)
    data = json.loads(proc.stdout)
    name = data.get("name", "").lower()
    is_light = data.get("is_light", False)

    if "gruvbox" in name:
        bat_theme = "gruvbox-light" if is_light else "gruvbox-dark"
    elif "catppuccin" in name:
        bat_theme = "Catppuccin Latte" if is_light else "Catppuccin Mocha"
    elif "nord" in name:
        bat_theme = "Nord"
    elif "dracula" in name:
        bat_theme = "Dracula"
    elif "solarized" in name:
        bat_theme = "Solarized (light)" if is_light else "Solarized (dark)"
    elif is_light:
        bat_theme = "gruvbox-light"
    else:
        bat_theme = "gruvbox-dark"

    bat_dir = os.path.expanduser("~/.config/bat")
    os.makedirs(bat_dir, exist_ok=True)
    with open(os.path.join(bat_dir, "config"), "w") as f:
        f.write(f"--theme=\"{bat_theme}\"\n")
except Exception:
    pass
' >/dev/null 2>&1 || true
    fi
fi

exit $EXIT_CODE
