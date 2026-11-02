#!/usr/bin/env bash
# Wrapper para o recol com sincronização de Tmux, Neovim e Qtile

RECOL_BIN="$HOME/.cargo/bin/recol"

if [ ! -x "$RECOL_BIN" ]; then
    echo "Erro: Binário recol não encontrado em $RECOL_BIN" >&2
    exit 1
fi

"$RECOL_BIN" "$@"
EXIT_CODE=$?

# Se o comando executou com sucesso
if [ $EXIT_CODE -eq 0 ]; then
    # Verifica se a chamada foi de consulta ou ajuda (para evitar sincronizações desnecessárias)
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

    # 3. Sincroniza tema no Qtile via JSON e recarrega a barra/bordas
    if command -v python3 >/dev/null 2>&1; then
        python3 -c '
import json, os, subprocess

try:
    proc = subprocess.run(["'$RECOL_BIN'", "-j"], capture_output=True, text=True, check=True)
    data = json.loads(proc.stdout)
    c = data.get("colors", {})
    bg = c.get("bg", ["#0f111a", "#0f111a", "#1a1c25", "#2a2d3d", "#374151"])
    fg = c.get("fg", ["#f8f8f2", "#d1d5db", "#9ca3af", "#717b88"])
    base = c.get("base", {})
    bright = c.get("bright", {})
    
    qtile_theme = {
        "background": bg[1] if len(bg) > 1 else bg[0],
        "foreground": fg[1] if len(fg) > 1 else fg[0],
        "primary": base.get("blue", "#374151"),
        "secondary": base.get("cyan", "#717b88"),
        "accent": base.get("magenta", "#9ca3af"),
        "urgent": base.get("red", "#ef4444"),
        "inactive": bright.get("black", "#585b70"),
        "selection": bg[2] if len(bg) > 2 else "#1f2937",
        "border_active": base.get("blue", "#9ca3af"),
        "border_inactive": bg[2] if len(bg) > 2 else "#1f2937",
        "success": base.get("green", "#a6e3a1"),
        "warning": base.get("yellow", "#f9e2af"),
        "error": base.get("red", "#ef4444"),
    }
    
    target_path = os.path.expanduser("~/.config/qtile/recol_theme.json")
    with open(target_path, "w") as f:
        json.dump(qtile_theme, f, indent=2)
except Exception:
    pass
' >/dev/null 2>&1 || true
    fi

    if command -v qtile >/dev/null 2>&1; then
        qtile cmd-obj -o cmd -f reload_config >/dev/null 2>&1 || true
    fi
fi

exit $EXIT_CODE
