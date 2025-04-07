#!/bin/sh

picom &
sxhkd &
nitrogen --restore
xset r rate 401 30
dropbox &
caffeine &
nm-applet &
crow &
zen-browser &
alacritty &
light-locker &
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
joplin &
strawberry &
# deepl-linux-electron &
# notesnook &
#firefox &
#megasync &
# mullvad-vpn &
# librewolf &
#qbittorrent &
#setxkbmap -layout us -variant intl

