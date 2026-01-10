"""
Widgets Configuration
"""

from libqtile import widget
from .colors import colors

# Verifica disponibilidade do qtile-extras
try:
    import qtile_extras.widget as qe_widget
    from qtile_extras.widget.decorations import RectDecoration, PowerLineDecoration

    QTILE_EXTRAS_AVAILABLE = True
except ImportError:
    QTILE_EXTRAS_AVAILABLE = False

widget_defaults = dict(
    font="Ubuntu Nerd Font",
    fontsize=13,
    padding=3,
    background=colors["background"],
    foreground=colors["foreground"],
)

extension_defaults = widget_defaults.copy()

# Decorações
powerline = (
    {"decorations": [PowerLineDecoration(path="arrow_right")]}
    if QTILE_EXTRAS_AVAILABLE
    else {}
)
rounded_rect = (
    {
        "decorations": [
            RectDecoration(
                colour=colors["selection"],
                radius=9,
                filled=True,
                padding_y=2,
                group=True,
            )
        ]
    }
    if QTILE_EXTRAS_AVAILABLE
    else {}
)


def get_widgets():
    """Retorna lista de widgets para a barra"""
    widgets = [
        widget.TextBox(
            text="",
            foreground=colors["secondary"],
            fontsize=16,
            padding=10,
        ),
        widget.GroupBox(
            hide_unused=True,
            highlight_method="block",
            active=colors["accent"],
            inactive=colors["inactive"],
            this_current_screen_border=colors["secondary"],
            urgent_border=colors["urgent"],
            block_highlight_text_color=colors["background"],
            **rounded_rect,
        ),
        widget.Sep(linewidth=1, padding=3, foreground=colors["primary"]),
        widget.CurrentLayout(foreground=colors["accent"], **powerline),
        widget.Sep(linewidth=1, padding=3, foreground=colors["primary"]),
        widget.Prompt(foreground=colors["accent"], cursor_color=colors["secondary"]),
        widget.WindowName(foreground=colors["foreground"], max_chars=50),
        widget.Chord(
            chords_colors={"launch": (colors["urgent"], colors["foreground"])},
            name_transform=lambda name: name.upper(),
        ),
        widget.Spacer(),
        widget.CPUGraph(
            type="box",
            graph_color=colors["secondary"],
            fill_color=colors["secondary"],
            border_color=colors["primary"],
            background=colors["background"],
        ),
        widget.Sep(linewidth=1, padding=5, foreground=colors["primary"]),
        widget.Memory(
            format="󰍛 {MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            measure_mem="G",
            foreground=colors["success"],
            **powerline,
        ),
        widget.Sep(linewidth=1, padding=5, foreground=colors["primary"]),
        widget.Clock(
            format=" %a, %d/%m - %H:%M",
            foreground=colors["accent"],
            **rounded_rect,
        ),
        widget.Sep(linewidth=1, padding=3, foreground=colors["primary"]),
        widget.Volume(
            fmt="{}",
            emoji=True,
            emoji_list=["🔇", "🔈", "🔉", "🔊"],
            padding=5,
            foreground=colors["warning"],
            **powerline,
        ),
        widget.Volume(
            fmt="{}",
            padding=2,
            foreground=colors["warning"],
        ),
        widget.Sep(linewidth=1, padding=7, foreground=colors["primary"]),
    ]

    # Adiciona StatusNotifier
    if QTILE_EXTRAS_AVAILABLE:
        widgets.append(
            qe_widget.StatusNotifier(
                icon_theme="Papirus-Dark",
                icon_size=16,
                padding=5,
                background=colors["background"],
            )
        )
    else:
        widgets.append(
            widget.StatusNotifier(
                icon_theme="Papirus-Dark",
                icon_size=16,
                padding=5,
                background=colors["background"],
            )
        )

    return widgets
