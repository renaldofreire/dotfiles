#!/usr/bin/env bash
# Wrapper para o recol com sincronização de componentes de terminal (Alacritty, Neovim e Tmux)

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
fi

exit $EXIT_CODE
