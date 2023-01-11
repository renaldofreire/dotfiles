#!/bin/sh

picom &
nitrogen --restore
dropbox &
caffeine &
nm-applet &
sxhkd &
clementine &
crow &
firefox &
alacritty &
xset r rate 400 30
light-locker --lock-after-screensaver=600 --lock-on-suspend & #lighDM screen locker
#setxkbmap -layout us -variant intl

