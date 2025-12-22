#!/bin/sh

# 1. Variáveis de Ambiente e Autenticação
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# 2. Configurações do Sistema e Serviços de Fundo (daemons)
killall -q picom light-locker nm-applet caffeine

# Aguarda um momento para garantir que os processos foram terminados
sleep 1

# Inicia os serviços de sistema primeiro
picom &
sxhkd &
light-locker --lock-after-screensaver=10 --lock-on-suspend &
nitrogen --restore &

# Inicia o portal XDG antes do StatusNotifier
/usr/lib/xdg-desktop-portal-gtk &
sleep 1

# Network Manager com configurações específicas para StatusNotifier
/usr/bin/nm-applet --sm-disable --indicator &
# nm-applet --indicator &

# Outros serviços
caffeine &
#easyeffects &

# Configurações instantâneas (não precisam de '&')
xset r rate 300 50
xset s 600

# Aguarda os serviços de sistema estarem prontos
sleep 2

# 3. Aplicações do Usuário (com atrasos para não sobrecarregar)
(sleep 3 && alacritty) &
(sleep 4 && zen-browser) &
(sleep 5 && net.cozic.joplin_desktop) &
#(sleep 5 && org.kde.CrowTranslate) &
(sleep 6 && org.strawberrymusicplayer.strawberry) &
(sleep 7 && dropbox start) &
