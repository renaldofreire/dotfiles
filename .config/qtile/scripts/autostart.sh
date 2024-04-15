#!/bin/sh

picom &
nitrogen --restore
dropbox &
#megasync &
caffeine &
nm-applet &
sxhkd &
# strawberry &
crow &
# mullvad-vpn &
# librewolf &
firefox &
alacritty &
#qbittorrent &
xset r rate 401 30
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
sleep 100 && qtile cmd-obj -o cmd -f reload_config
#setxkbmap -layout us -variant intl

