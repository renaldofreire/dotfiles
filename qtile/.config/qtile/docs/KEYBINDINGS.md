# ⌨️ Atalhos de Teclado - Qtile

Esta é a lista completa e atualizada de atalhos de teclado da sua configuração do Qtile.

## 🚀 Lançadores e Janelas Principais

| Atalho | Comando | Descrição |
| :--- | :--- | :--- |
| **`Super + Return`** | `alacritty -e tmux new-session` | Abrir terminal com sessão Tmux |
| **`Super + d`** | `rofi -show drun` | Abrir lançador de aplicativos (**Rofi**) |
| **`Super + p`** | `rofi -show run` | Abrir lançador de comandos (**Rofi**) |
| **`Super + Tab`** | `rofi -show window` | Alternar entre janelas abertas (**Rofi**) |
| **`Super + n`** | `quick-notes.sh` | Abrir notas rápidas no Neovim |
| **`Super + Ctrl + w`** | `zen-browser` | Abrir o navegador Zen Browser |
| **`Super + Ctrl + f`** | `alacritty -e nnn` | Abrir gerenciador de arquivos `nnn` |
| **`Print`** | `ksnip -r` | Captura de tela com Ksnip |
| **`Super + q`** | `kill` | Fechar janela ativa |
| **`Super + r`** | `spawncmd` | Prompt de comando nativo |

## 🧩 Gerenciamento de Janelas e Layouts

| Atalho | Comando | Descrição |
| :--- | :--- | :--- |
| **`Super + Space`** | `next_layout` | Alternar entre os layouts (`Columns`, `Max`) |
| **`Super + Shift + Space`** | `toggle_floating` | Alternar entre modo flutuante e tiling |
| **`Super + f`** | `toggle_fullscreen` | Alternar modo tela cheia |
| **`Super + Shift + n`** | `normalize` | Resetar proporções de janelas emparelhadas |
| **`Super + Ctrl + n`** | `restore_floating` | Restaurar janela flutuante/redimensionada ao tamanho do layout |
| **`Super + h`** | `focus_left` | Mover o foco para a esquerda |
| **`Super + l`** | `focus_right` | Mover o foco para a direita |
| **`Super + j`** | `focus_down` | Mover o foco para baixo |
| **`Super + k`** | `focus_up` | Mover o foco para cima |

## ↕️ Mover e Redimensionar Janelas

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| **`Super + Shift + h/l/j/k`** | Mover Janela | Move a janela física para a direção correspondente |
| **`Super + Ctrl + h/l`** | Grow Left/Right | Expandir janela horizontalmente |
| **`Super + Ctrl + j/k`** | Grow Down/Up | Expandir janela verticalmente |

## ⚙️ Controle do Sistema, Áudio e Energia

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| **`Super + Shift + r`** | Reload Config | Recarrega a configuração do Qtile instantaneamente |
| **`Super + Shift + q`** | Shutdown Qtile | Encerra a sessão do Qtile |
| **`Super + Ctrl + l`** | Lock Screen | Bloqueia a tela (`i3lock`) |
| **`Super + Ctrl + s`** | Lock & Suspend | Bloqueia a tela e suspende o sistema |
| **`XF86AudioMute`** | Mute | Alterna o som mudo do sistema |
| **`XF86AudioLowerVolume`** | Vol - | Diminui volume em 5% |
| **`XF86AudioRaiseVolume`** | Vol + | Aumenta volume em 5% |
| **`Shift + F11`** | Redshift On | Ativa filtro de luz azul (4400K) |
| **`Shift + F12`** | Redshift Off | Desativa filtro de luz azul |

---
*Para um detalhamento completo de arquitetura, grupos e temas, consulte [`docs/MANUAL.md`](MANUAL.md).*
