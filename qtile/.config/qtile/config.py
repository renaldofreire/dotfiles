"""
Qtile Configuration
Modular setup for better maintainability
"""

import os
import sys

# Adiciona o diretório de configuração ao PATH
config_dir = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, config_dir)

from settings.keys import keys, mod
from settings.groups import groups
from settings.layouts import layouts, floating_layout
from settings.widgets import widget_defaults, extension_defaults
from settings.screens import screens
from settings.hooks import *

# Configurações gerais
dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"

# Mouse
from libqtile.config import Drag, Click
from libqtile.lazy import lazy

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]
