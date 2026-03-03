# My dotfiles 

Este repositório contém arquivos de configuração pessoal gerenciados com o GNU Stow.

## Estrutura

A organização segue o modelo modular, onde cada diretório na raiz representa um programa ou conjunto de configurações. Dentro de cada pasta, a hierarquia de arquivos replica o caminho relativo ao diretório home do usuário.

Exemplo de mapeamento:
- `bashrc/.bashrc` é vinculado a `~/.bashrc`
- `qtile/.config/qtile/` é vinculado a `~/.config/qtile/`

## Gerenciamento

O uso do GNU Stow permite criar links simbólicos de forma automatizada, mantendo os arquivos originais centralizados neste repositório para fácil versionamento e backup.

Para aplicar uma configuração:
`stow <nome-da-pasta>`

Para remover uma configuração:
`stow -D <nome-da-pasta>`

## Inspiração

Este modelo de organização foi inspirado no fluxo de trabalho apresentado no seguinte vídeo:
https://www.youtube.com/watch?v=uAKmZ4Cs1c8&t=8s
