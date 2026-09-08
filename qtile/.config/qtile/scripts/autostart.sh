#!/bin/sh
set -euo pipefail

# Theme switcher for Alacritty
~/.config/alacritty/scripts/theme_switcher.sh &

# 1. Environment Variables and Authentication
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# 2. System Services and Background Daemons
# Kill existing instances cleanly
for cmd in picom nm-applet caffeine; do
    pkill -x "$cmd" 2>/dev/null || true
done

# Wait for processes to terminate
sleep 1

# Start system services
pgrep -x lxpolkit > /dev/null || lxpolkit &
pgrep -x picom > /dev/null || picom &
nitrogen --restore &

# Start XDG desktop portal before StatusNotifier
pgrep -x xdg-desktop-portal-gtk > /dev/null || /usr/lib/xdg-desktop-portal-gtk &
sleep 1

# Network Manager with StatusNotifier support
pgrep -x nm-applet > /dev/null || /usr/bin/nm-applet --sm-disable --indicator &

# Other services
pgrep -x caffeine > /dev/null || caffeine &

# easyeffects &

# 3. Instant Settings (don't background)
xset r rate 300 50
xset s 600
xset dpms 600 600 900

# Wait for system services to be ready
sleep 2

# 4. User Applications (staggered startup)
(sleep 3 && alacritty) &
(sleep 4 && zen-browser) &
(sleep 5 && ~/.joplin/Joplin.AppImage) &
(sleep 6 && strawberry) &
(sleep 7 && dropbox start) &