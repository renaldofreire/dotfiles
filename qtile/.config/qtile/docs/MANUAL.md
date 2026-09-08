# 🖥️ Qtile WM - Manual Completo de Configuração, Atalhos e Funcionalidades

Este documento detalha todas as funcionalidades, atalhos de teclado, regras de grupos, gerenciamento de temas e automações presentes na sua configuração modular do **Qtile**.

---

## 🗂️ Estrutura do Projeto

A configuração segue uma arquitetura modular dentro de `~/.config/qtile/settings/`:

- **`config.py`**: Ponto de entrada principal que conecta todos os módulos.
- **`settings/colors.py`**: Gerenciador de temas de cores (Monochrome Slate, Catppuccin, Everforest, etc.).
- **`settings/keys.py`**: Definição de todos os atalhos de teclado e mouse.
- **`settings/groups.py`**: Configuração dos 10 workspaces (grupos) e regras automáticas de janelas.
- **`settings/layouts.py`**: Estilos de exibição de janelas (`Columns`, `Max`, `Floating`).
- **`settings/widgets.py`**: Configuração da barra de status e integração com `qtile-extras`.
- **`settings/screens.py`**: Detecção automática de múltiplos monitores e posicionamento de barras.
- **`settings/hooks.py`**: Hooks de eventos (autostart, janelas flutuantes automáticas, ajuste de PATH).
- **`scripts/autostart.sh`**: Script Shell otimizado para inicialização de daemons e apps.

---

## ⌨️ Tabela Completa de Atalhos de Teclado

> **Nota:** `Super` refere-se à tecla Windows / Command (`mod4`).

### 🚀 Lançadores e Aplicativos

| Atalho | Comando / Ação | Descrição |
| :--- | :--- | :--- |
| **`Super + Return`** | `alacritty -e tmux new-session` | Abre o terminal Alacritty com sessão Tmux |
| **`Super + d`** | `rofi -show drun` | Menu de aplicativos (Rofi) |
| **`Super + p`** | `rofi -show run` | Menu de comandos do sistema (Rofi) |
| **`Super + Tab`** | `rofi -show window` | Alternador visual de janelas abertas |
| **`Super + n`** | `~/dotfiles/scripts/quick-notes.sh` | Abre o sistema de notas rápidas no Neovim |
| **`Super + Ctrl + w`** | `zen-browser` | Abre o navegador Zen Browser |
| **`Super + Ctrl + f`** | `alacritty -e nnn` | Abre o gerenciador de arquivos `nnn` no Alacritty |
| **`Print`** | `ksnip -r` | Captura de tela com seleção de área via Ksnip |
| **`Super + r`** | `spawncmd` | Prompt nativo de comandos do Qtile |

---

### 🪟 Gerenciamento e Navegação de Janelas

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| **`Super + h`** | Foco Esquerda | Mover o foco para a janela da esquerda |
| **`Super + l`** | Foco Direita | Mover o foco para a janela da direita |
| **`Super + j`** | Foco Baixo | Mover o foco para a janela de baixo |
| **`Super + k`** | Foco Cima | Mover o foco para a janela de cima |
| **`Super + Shift + h`** | Mover Esquerda | Trocar posição da janela para a esquerda |
| **`Super + Shift + l`** | Mover Direita | Trocar posição da janela para a direita |
| **`Super + Shift + j`** | Mover Baixo | Trocar posição da janela para baixo |
| **`Super + Shift + k`** | Mover Cima | Trocar posição da janela para cima |
| **`Super + q`** | Fechar Janela | Encerra a janela atual em foco (`kill`) |

---

### 📐 Redimensionamento, Modos e Layouts

| Atalho | Ação | Descrição |
| :--- | :--- | :--- |
| **`Super + Ctrl + h`** | Aumentar Esquerda | Expande a janela para a esquerda |
| **`Super + Ctrl + l`** | Aumentar Direita | Expande a janela para a direita |
| **`Super + Ctrl + j`** | Aumentar Baixo | Expande a janela para baixo |
| **`Super + Ctrl + k`** | Aumentar Cima | Expande a janela para cima |
| **`Super + Shift + n`** | Normalizar | Restaura a proporção padrão de janelas lado a lado |
| **`Super + Ctrl + n`** | Restaurar Flutuante | Remove o modo flutuante e restaura ao tamanho padrão do layout |
| **`Super + Space`** | Próximo Layout | Alterna entre layouts ativos (`Columns` e `Max`) |
| **`Super + f`** | Tela Cheia | Alterna o modo Fullscreen na janela ativa |
| **`Super + Shift + Space`** | Modo Flutuante | Alterna entre modo flutuante e tiling na janela |
| **`Super + Shift + Return`** | Toggle Split | Alterna entre modo dividido e empilhado no layout Stack |

---

### 🔢 Workspaces / Grupos (`0` a `9`)

| Atalho | Ação |
| :--- | :--- |
| **`Super + [0-9]`** | Alterna diretamente para o workspace correspondente |
| **`Super + Shift + [0-9]`** | Move a janela em foco para o workspace correspondente e muda para ele |

---

### 🔊 Controle de Áudio, Tela e Energia

| Atalho | Comando / Ação | Descrição |
| :--- | :--- | :--- |
| **`XF86AudioMute`** | `pactl set-sink-mute` | Alterna mudo/som no PipeWire/PulseAudio |
| **`XF86AudioLowerVolume`** | `pactl set-sink-volume -5%` | Diminui o volume do sistema em 5% |
| **`XF86AudioRaiseVolume`** | `pactl set-sink-volume +5%` | Aumenta o volume do sistema em 5% |
| **`Shift + F11`** | `redshift -O 4400` | Ativa o filtro de luz azul (temperatura 4400K) |
| **`Shift + F12`** | `redshift -x` | Desativa o filtro de luz azul |
| **`Super + Ctrl + l`** | `i3lock -c 0f111a` | Bloqueia a tela com a cor do tema atual |
| **`Super + Ctrl + s`** | `i3lock + systemctl suspend` | Bloqueia a tela e suspende o sistema |
| **`Super + Shift + r`** | `reload_config` | Recarrega as configurações do Qtile instantaneamente |
| **`Super + Shift + q`** | `shutdown` | Encerra a sessão do Qtile |

---

### 🖱️ Ações de Mouse

| Atalho | Ação |
| :--- | :--- |
| **`Super + Clique Esquerdo (Arrastar)`** | Move a janela livremente (ativa modo flutuante) |
| **`Super + Clique Direito (Arrastar)`** | Redimensiona a janela livremente |
| **`Super + Clique Botão do Meio`** | Traz a janela para a frente |

---

## 🏷️ Mapeamento dos Workspaces (Grupos)

Os aplicativos são direcionados automaticamente para grupos específicos:

| Grupo | Ícone / Tipo | Aplicações Automáticas |
| :---: | :--- | :--- |
| **`1`** | Navegador Web | `zen-browser`, `Navigator` (Firefox) |
| **`2`** | Desenvolvimento | `Alacritty`, `VSCodium` |
| **`3`** | Notas / Produtividade | `Joplin` |
| **`4` - `6`** | Livre | Uso geral |
| **`7`** | Comunicação | `Telegram`, `Signal`, `Discord`, `Ferdium` |
| **`8`** | Livre | Uso geral |
| **`9`** | Mídia & Áudio | `Strawberry`, `EasyEffects`, `Pocket Casts` |
| **`0`** | E-mail | `Thunderbird`, `Mail` |

---

## 🎨 Temas de Cores Disponíveis (`settings/colors.py`)

Sua configuração suporta troca dinâmica de temas. O tema padrão ativo é **`monochrome_slate`**.

Temas instalados:
1. **`monochrome_slate`** *(Ativo)*: Design sóbrio, cinza escuro e elegante.
2. **`catppuccin_mocha`**: Tons pastel modernos e suaves.
3. **`everforest`**: Tom verde-floresta relaxante.
4. **`dracula`**: O clássico tema escuro com tons roxos e verdes neon.
5. **`nord`**: Paleta ártica azul e fria.
6. **`raven_blue`**: Azul marinho e dourado.

### Funções Python de Temas
- `set_theme("nome_do_tema")`: Altera o tema atual.
- `cycle_theme()`: Alterna sequencialmente para o próximo tema.
- `get_available_themes()`: Retorna a lista de temas suportados.

---

## 🪟 Regras Especiais de Janelas Flutuantes

As seguintes janelas abrem **sempre em modo flutuante** automaticamente:
- **`ksnip`** (Janela de captura de tela)
- **`QuickNotes` / `quick-notes`** (Notas rápidas)
- **`galculator`** (Calculadora)
- **`zenity`** (Diálogos nativos de sistema)
- **`TelegramDesktop`** e **`session-messenger-desktop`**
- Popups de autenticação (`ssh-askpass`, `pinentry`)
- Diálogos de confirmação (`confirmreset`, `makebranch`, `maketag`, etc.)

---

## ⚙️ Barra de Status e Widgets

A barra superior possui altura de 22px com cantos arredondados (`qtile-extras`) e exibe:

1. **Workspaces (`GroupBox`)**: Destaca o grupo ativo e oculta os não utilizados.
2. **Layout Atual (`CurrentLayout`)**: Exibe o modo atual (`Columns`/`Max`) com separador em seta (`PowerLine`).
3. **Janela Ativa (`WindowName`)**: Nome da aplicação em foco (máximo de 50 caracteres).
4. **Uso de CPU (`CPU` + `CPUGraph`)**: Porcentagem e gráfico em tempo real.
5. **Memória RAM (`Memory`)**: Exibição em GB consumidos / total.
6. **Relógio (`Clock`)**: Data e hora no formato `Qua, 23/08 - 14:30`.
7. **Volume (`Volume`)**: Nível atual do áudio com integração PipeWire.
8. **Bandeja de Sistema (`StatusNotifier`)**: Ícones de aplicativos em segundo plano (`nm-applet`, etc.).

---

## 🔄 Fluxo de Autostart (`scripts/autostart.sh`)

Na inicialização do Qtile, o script realiza as seguintes etapas em ordem:

1. Ativa o `gnome-keyring-daemon` para gerenciamento de senhas e chaves SSH.
2. Finaliza processos antigos (`picom`, `nm-applet`, `light-locker`, `caffeine`).
3. Inicia compositor de transparência (`picom`), gerenciador de atalhos (`sxhkd`), bloqueador de tela (`light-locker`) e papéis de parede (`nitrogen`).
4. Ativa o portal XDG GTK e o `nm-applet` para a barra de status.
5. Configura a taxa de repetição do teclado (`xset r rate 300 50`).
6. Inicia os aplicativos do usuário de forma escalonada (`Alacritty`, `Zen Browser`, `Joplin`, `Strawberry`, `Dropbox`).
