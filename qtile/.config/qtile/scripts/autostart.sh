#!/bin/sh

picom &
nitrogen --restore
dropbox &
caffeine &
nm-applet &
sxhkd &
crow &
zen-browser &
joplin &
alacritty &
xset r rate 401 30
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
sleep 100 && qtile cmd-obj -o cmd -f reload_config
light-locker &
joplin &
# deepl-linux-electron &
# notesnook &
#mullvad-vpn &
#firefox &
#megasync &
# strawberry &
# mullvad-vpn &
# librewolf &
#qbittorrent &
#setxkbmap -layout us -variant intl

