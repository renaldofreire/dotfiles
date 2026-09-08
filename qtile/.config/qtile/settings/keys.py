"""
Keybindings Configuration
"""

import os
from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()
rofi_command = "rofi -show {mode}"

keys = [
    # Window Management
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Resize windows
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.spawn(os.path.expanduser("~/dotfiles/scripts/quick-notes.sh")), desc="Quick notes in Neovim"),
    Key([mod, "shift"], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod, "control"], "n", lazy.window.toggle_floating().when(func=lambda w: w.floating), lazy.layout.normalize(), desc="Reset floating window to tiled size"),
    # System
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn("alacritty -e tmux new-session"), desc="Launch terminal with tmux session"),
    Key([mod], "Space", lazy.next_layout(), desc="Toggle between layouts"),
    Key(
        [mod],
        "Tab",
        lazy.spawn(rofi_command.format(mode="window")),
        desc="Switch between windows",
    ),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Audio - PipeWire/PulseAudio
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
    ),
    # Launchers
    Key(
        [mod],
        "d",
        lazy.spawn(rofi_command.format(mode="drun")),
        desc="Run rofi apps",
    ),
    Key(
        [mod],
        "p",
        lazy.spawn(rofi_command.format(mode="run")),
        desc="Run rofi commands",
    ),
    # Window controls
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "shift"], "Space", lazy.window.toggle_floating(), desc="Toggle floating"),
    
    # Custom apps migrating from sxhkd
    Key(["control", mod], "w", lazy.spawn("zen-browser"), desc="Launch Zen Browser"),
    Key(["control", mod], "f", lazy.spawn("alacritty -e nnn"), desc="Launch nnn file manager"),
    Key([], "Print", lazy.spawn("ksnip -r"), desc="Launch ksnip"),
    Key(["shift"], "F11", lazy.spawn("alacritty -e redshift -O 4400"), desc="Redshift on"),
    Key(["shift"], "F12", lazy.spawn("alacritty -e redshift -x"), desc="Redshift off"),

    # Power management (i3lock com cor do tema monochrome_slate)
    Key([mod, "control"], "s", lazy.spawn("sh -c 'i3lock -c 0f111a && sleep 1 && systemctl suspend'"), desc="Lock screen and suspend"),
    Key([mod, "control"], "l", lazy.spawn("i3lock -c 0f111a"), desc="Lock screen"),
]
