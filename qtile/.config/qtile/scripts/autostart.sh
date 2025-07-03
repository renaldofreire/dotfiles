#!/bin/sh

picom &
sxhkd &
nitrogen --restore
dropbox &
caffeine &
nm-applet &
crow &
zen-browser &
alacritty &
net.cozic.joplin_desktop &
easyeffects &
strawberry &
light-locker --lock-after-screensaver=10 --lock-on-suspend &
xset r rate 401 30
xset s 600 &
/usr/lib/xdg-desktop-portal-gtk &
export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
# deepl-linux-electron &
#firefox &
#megasync &
# mullvad-vpn &
#qbittorrent &

