#!/bin/sh

picom &
nitrogen --restore
dropbox &
caffeine &
nm-applet &
sxhkd &
clementine &
crow &
mullvad-vpn &
#firefox &
alacritty &
#qbittorrent &
xset r rate 401 30
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
#setxkbmap -layout us -variant intl

