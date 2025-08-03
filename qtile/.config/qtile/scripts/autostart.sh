#!/bin/sh

export XDG_DATA_DIRS="$HOME/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

picom &
sxhkd &
light-locker --lock-after-screensaver=10 --lock-on-suspend &
xset r rate 401 30
xset s 600 &
/usr/lib/xdg-desktop-portal-gtk &
nitrogen --restore

caffeine &
nm-applet &
zen-browser &
alacritty &
net.cozic.joplin_desktop &
org.kde.CrowTranslate &
#dbus-launch dropbox &
(sleep 3 && dropbox) &

#easyeffects &
#firefox &
#megasync &
# mullvad-vpn &
#qbittorrent &
#dropbox &

