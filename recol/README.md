# Recol Integration & Backup

Este diretório contém o backup e a documentação da integração do **Recol** com Alacritty, Neovim, Tmux e Qtile.

## Como funciona a integração

1. **Binário e Wrapper (`~/.local/bin/recol`)**
   - O binário compilado reside em `~/.cargo/bin/recol`.
   - O comando `recol` no terminal executa o wrapper em `~/.local/bin/recol` (versionado em `dotfiles/bin/.local/bin/recol`).
   - Após aplicar o tema, o wrapper orquestra a sincronização dos outros componentes.

2. **Alacritty**
   - Arquivo: `~/.config/alacritty/alacritty.toml`.
   - O Recol injeta a tabela `[colors]` diretamente no arquivo.
   - Com `live_config_reload = true`, as alterações entram em vigor imediatamente sem reiniciar o terminal.

3. **Neovim**
   - Módulo: `~/.config/nvim/lua/custom/recol.lua` (carregado via `init.lua`).
   - O Recol injeta a definição de syntax/highlighting entre os marcadores `-- recol:start` e `-- recol:end` no final de `init.lua`.
   - Disponibiliza os comandos `:Recol <tema>` e `:RecolOpen` (ou `:Recol -i`) para abrir o seletor flutuante interativo.
   - Instâncias ativas do Neovim são atualizadas em segundo plano via socket RPC (`/tmp/nvim.pipe`).

4. **Tmux**
   - Arquivo: `~/.tmux.conf`.
   - O Tmux opera em modo neutro/transparente (`bg=default`), herdando a paleta ANSI diretamente do Alacritty.
   - O wrapper executa `tmux refresh-client -S` para forçar o redesenho da barra de status instantaneamente.

5. **Qtile**
   - Arquivo: `~/.config/qtile/settings/colors.py`.
   - O wrapper extrai a paleta do Recol (`recol -j`) e gera `~/.config/qtile/recol_theme.json`.
   - `colors.py` carrega dinamicamente esse arquivo (com fallback para `monochrome_slate`) e o wrapper chama `qtile cmd-obj -o cmd -f reload_config`.

## Como Usar

```bash
# Modo interativo (TUI com busca fuzzy e preview live)
recol -i

# Aplicar tema específico diretamente
recol nord
recol dracula
recol catppuccin

# Filtrar e sortear temas escuros
recol -rd -c Gruvbox
```

No Neovim:
```vim
:RecolOpen          " Abre o picker interativo em janela flutuante
:Recol tokyo_night  " Aplica o tema diretamente
```

## Arquivos de Backup

- `backup/recol-wrapper.sh`: Cópia do wrapper de sincronização.
- `backup/recol.lua`: Cópia da integração Lua para Neovim.
- `backup/recol_theme.json`: Snapshot de tema gerado para o Qtile.
