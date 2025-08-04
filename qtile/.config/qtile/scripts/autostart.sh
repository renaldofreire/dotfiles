#!/bin/sh

# 1. Variáveis de Ambiente e Autenticação
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# 2. Configurações do Sistema e Serviços de Fundo (daemons)
killall -q picom light-locker nm-applet caffeine

# Inicia os serviços
picom &
sxhkd &
light-locker --lock-after-screensaver=10 --lock-on-suspend &
nitrogen --restore &
/usr/lib/xdg-desktop-portal-gtk &
nm-applet &
caffeine &
easyeffects --gapplication-service &

# Configurações instantâneas (não precisam de '&')
xset r rate 300 50
xset s 600

# 3. Aplicações do Usuário (com atrasos para não sobrecarregar)
(sleep 1 && alacritty) &
(sleep 2 && zen-browser) &
(sleep 3 && net.cozic.joplin_desktop) &
(sleep 3 && org.kde.CrowTranslate) &
(sleep 4 && strawberry) &
(sleep 5 && dbus-launch dropbox) &
