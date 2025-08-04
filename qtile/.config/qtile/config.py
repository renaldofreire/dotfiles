import os
import re
import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# qtile-extras import
try:
    import qtile_extras.widget as qe_widget
    from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration

    QTILE_EXTRAS_AVAILABLE = True
except ImportError:
    print("Qtile-extras não está disponível. Instale com: pip install qtile-extras")
    QTILE_EXTRAS_AVAILABLE = False

mod = "mod4"
terminal = guess_terminal()

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
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
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # Audio - amixer control
    Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
    # Dmenu_extended
    Key([mod], "m", lazy.spawn("dmenu_extended_run")),
    # Key([mod], "m", lazy.spawn("dmenu_run")),
    # Full Screen
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    # exit floating
    Key([mod], "Escape", lazy.window.toggle_floating()),
]

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
                    r"^(signal|telegram-desktop|discord|FFPWA-01JWMJBS7S1ZP3J868TGA3AM0G)$"
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

colors = {
    "background": "#090707",
    "foreground": "#f8f8f2",
    "comment": "#6272a4",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
    "border_columns_1": "#c99789",
    "border_columns_2": "#ffcc5c",
    "border_monadtall_1": "#68c4af",
    "border_monadtall_2": "#b8dbd3",
    # Cores adicionais para qtile-extras
    "blue": "#6272a4",
    "orange": "#ffb86c",
    "pink": "#ff79c6",
    "background_alt": "#44475a",
    "selection": "#44475a",
    "inactive": "#6272a4",
}

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus=[colors["border_columns_1"], colors["border_columns_2"]],
        border_width=1,
        margin=4,
    ),
    layout.Max(),
]

widget_defaults = dict(
    font="Ubuntu Nerd Font",
    fontsize=13,
    padding=3,
    background=colors["background"],
    foreground=colors["foreground"],
)
extension_defaults = widget_defaults.copy()

# qtile-extras decorations
if QTILE_EXTRAS_AVAILABLE:
    powerline = {"decorations": [PowerLineDecoration(path="arrow_right")]}

    rounded_rect = {
        "decorations": [
            RectDecoration(
                colour=colors["background_alt"],
                radius=9,
                filled=True,
                padding_y=2,
                group=True,
            )
        ]
    }
else:
    powerline = {}
    rounded_rect = {}

screens = [
    Screen(
        top=bar.Bar(
            [
                # initial icon
                widget.TextBox(
                    text="",
                    foreground=colors["cyan"],
                    fontsize=16,
                    padding=10,
                ),
                widget.GroupBox(
                    hide_unused=True,
                    highlight_method="block",
                    active=colors["cyan"],
                    inactive=colors["inactive"],
                    this_current_screen_border=colors["purple"],
                    urgent_border=colors["red"],
                    **rounded_rect if QTILE_EXTRAS_AVAILABLE else {},
                ),
                widget.Sep(linewidth=1, padding=3),
                widget.CurrentLayout(
                    foreground=colors["yellow"],
                    **powerline if QTILE_EXTRAS_AVAILABLE else {},
                ),
                widget.Sep(linewidth=1, padding=3),
                widget.Prompt(),
                widget.WindowName(
                    foreground=colors["foreground"],
                    max_chars=50,
                ),
                widget.Chord(
                    chords_colors={
                        "launch": (colors["red"], colors["foreground"]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # Spacer para empurrar widgets para a direita
                widget.Spacer(),
                # Widgets do qtile-extras (se disponível)
                *(
                    [
                        # widget.Sep(linewidth=1, padding=5),
                        # Status da bateria (se aplicável)
                        # (
                        #     qe_widget.BatteryIcon(
                        #         theme_path="/usr/share/icons/Papirus/symbolic/",
                        #         **rounded_rect
                        #     )
                        #     if os.path.exists("/sys/class/power_supply/BAT0")
                        #     else widget.TextBox("")
                        # ),
                    ]
                    if QTILE_EXTRAS_AVAILABLE
                    else []
                ),
                # CPU Graph
                widget.CPUGraph(
                    type="box",
                    graph_color=colors["cyan"],
                    fill_color=colors["cyan"],
                    border_color=colors["background_alt"],
                ),
                widget.Sep(linewidth=1, padding=5),
                widget.Memory(
                    format="󰍛 {MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
                    measure_mem="G",
                    foreground=colors["green"],
                    **powerline if QTILE_EXTRAS_AVAILABLE else {},
                ),
                widget.Sep(linewidth=1, padding=5),
                widget.Clock(
                    format=" %a, %d/%m |  %H:%M",
                    foreground=colors["purple"],
                    **rounded_rect if QTILE_EXTRAS_AVAILABLE else {},
                ),
                widget.Sep(linewidth=1, padding=3),
                widget.Volume(
                    channel="Master",
                    fmt="{}",
                    emoji=True,
                    emoji_list=["🔇", "", "", ""],
                    volume_app="pavucontrol",
                    limit_max_volume=True,
                    padding=5,
                    foreground=colors["yellow"],
                    **powerline if QTILE_EXTRAS_AVAILABLE else {},
                ),
                # volume: value
                widget.Volume(
                    channel="Master",
                    fmt="{}",
                    padding=2,
                    foreground=colors["yellow"],
                ),
                widget.Sep(linewidth=1, padding=7),
                # StatusNotifier or widgets extras
                *(
                    [
                        qe_widget.StatusNotifier(
                            icon_theme="Papirus-Dark",
                            icon_size=16,
                            padding=5,
                            background=None,
                            **rounded_rect,
                        )
                    ]
                    if QTILE_EXTRAS_AVAILABLE
                    else [
                        widget.StatusNotifier(
                            icon_theme="Papirus-Dark",
                            icon_size=16,
                            padding=5,
                            background=None,
                        )
                    ]
                ),
            ],
            20,  # anterior era 24
            background="00000000",
            margin=[4, 4, 0, 4] if QTILE_EXTRAS_AVAILABLE else [0, 0, 0, 0],
        ),
    ),
]

# Drag floating layouts.
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


# Autostart
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    # Adiciona 'sh -c' para garantir a execução via shell e '&' para rodar em background
    os.system(f"sh -c {home} &")


dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="session-messenger-desktop"),
        Match(wm_class="telegram-desktop"),
        Match(wm_class="zenity"),
        Match(wm_class="galculator"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ]
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"
