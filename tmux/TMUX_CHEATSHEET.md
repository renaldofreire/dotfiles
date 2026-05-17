# 🗂️ Guia de Comandos: Seu Setup tmux

Este guia resume os atalhos e funcionalidades da sua configuração personalizada do tmux, focada em produtividade e agilidade estilo Vim.

---

## ⌨️ Atalhos Principais (Prefix: `Ctrl + A`)

Seu prefixo foi alterado de `Ctrl + B` para **`Ctrl + A`** para facilitar o alcance.

| Comando | Ação |
| :--- | :--- |
| `Prefix + r` | Recarrega as configurações do tmux (sem fechar janelas). |
| `Prefix + |` | Divide o painel **verticalmente** (lado a lado). |
| `Prefix + -` | Divide o painel **horizontalmente** (em cima/embaixo). |
| `Prefix + 1-9`| Pula para a janela correspondente. |

---

## ⚡ Navegação Rápida (Sem Prefixo)

Você pode navegar entre painéis usando apenas a tecla **Alt**, sem precisar apertar o prefixo.

| Teclas | Ação |
| :--- | :--- |
| `Alt + h` | Move o foco para o painel da **esquerda**. |
| `Alt + l` | Move o foco para o painel da **direita**. |
| `Alt + k` | Move o foco para o painel de **cima**. |
| `Alt + j` | Move o foco para o painel de **baixo**. |

---

## 📝 Modo de Cópia e Seleção (Estilo Vim)

Aperte `Prefix + [` para entrar no modo de cópia.

| Comando | Ação |
| :--- | :--- |
| `v` | Inicia a seleção (como o `v` no Vim). |
| `y` | Copia o texto selecionado (yank) e sai do modo de cópia. |
| `Esc` | Sai do modo de cópia sem copiar. |
| `setas / hjkl`| Navega pelo histórico do terminal. |

---

## 🔌 Plugins e Persistência

Seu tmux está configurado para salvar sessões automaticamente e restaurá-las após o reboot.

*   **tmux-resurrect**: Salva o estado manual das suas janelas.
    *   `Prefix + Ctrl + S`: Salva manualmente.
    *   `Prefix + Ctrl + R`: Restaura manualmente.
*   **tmux-continuum**: Salva automaticamente a cada 15 minutos e restaura ao iniciar o tmux.
*   **tmux-yank**: Garante que o texto copiado no tmux vá para o clipboard do sistema.

---

## 🎨 Avaliação da Configuração

Sua configuração atual é considerada **de alto nível (Power User)** por três motivos:

1.  **Neutralidade Visual**: A barra de status é 100% transparente e utiliza cores padrão, adaptando-se instantaneamente a qualquer tema do Alacritty.
2.  **Eficiência de Entrada**: O uso do Prefix `Ctrl+A` e a redução do `escape-time` para `0` tornam o ambiente perfeito para quem usa Vim/Neovim.
3.  **Abstração de Fricção**: A navegação com `Alt` elimina milhares de toques extras no teclado ao longo do dia, permitindo focar apenas no código.

---
*Dica: Se instalar um novo plugin, use `Prefix + I` para instalá-lo via TPM.*
