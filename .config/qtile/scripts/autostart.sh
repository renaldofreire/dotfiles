#!/bin/sh

picom &
nitrogen --restore
dropbox &
caffeine &
nm-applet &
sxhkd &
crow &
zen-browser &
alacritty &
xset r rate 401 30
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
sleep 100 && qtile cmd-obj -o cmd -f reload_config
#firefox &
#megasync &
# strawberry &
# mullvad-vpn &
# librewolf &
#qbittorrent &
#setxkbmap -layout us -variant intl

