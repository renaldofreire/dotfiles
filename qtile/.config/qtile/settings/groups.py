"""
Groups (Workspaces) Configuration
"""

import re
from libqtile.config import Group, Match, Key
from libqtile.lazy import lazy
from .keys import mod, keys

groups = [
    Group("1", matches=[Match(wm_class="Navigator")]),
    Group("2", matches=[Match(wm_class="Alacritty"), Match(wm_class="vscodium")]),
    Group("3", matches=[Match(wm_class="joplin")]),
    Group("4"),
    Group("5"),
    Group("6"),
    Group(
        "7",
        matches=[
            Match(
                wm_class=re.compile(
                    r"^(signal|Telegram|discord|FFPWA-01JWMJBS7S1ZP3J868TGA3AM0G)$"
                )
            )
        ],
    ),
    Group("8"),
    Group(
        "9",
        matches=[
            Match(wm_class=re.compile(r"^(pocket-casts-linux|strawberry|easyeffects)$"))
        ],
    ),
    Group("0", matches=[Match(wm_class=re.compile(r"^(Mail|thunderbird)$"))]),
]

# Adiciona keybindings para grupos
for i in groups:
    keys.extend(
        [
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )
