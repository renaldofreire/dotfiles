"""
Layouts Configuration
"""

from libqtile import layout
from libqtile.config import Match
from .colors import colors

layouts = [
    layout.Columns(
        border_focus=[colors["border_active"], colors["secondary"]],
        border_normal=colors["border_inactive"],
        border_width=2,
        margin=4,
    ),
    layout.Max(
        border_focus=colors["border_active"],
        border_normal=colors["border_inactive"],
        border_width=2,
    ),
    # Layouts adicionais (descomente se desejar)
    # layout.MonadTall(
    #     border_focus=colors["border_active"],
    #     border_normal=colors["border_inactive"],
    #     margin=4,
    #     border_width=2,
    # ),
    # layout.Spiral(
    #     border_focus=colors["border_active"],
    #     border_normal=colors["border_inactive"],
    #     margin=4,
    #     border_width=2,
    # ),
]

floating_layout = layout.Floating(
    border_focus=colors["border_active"],
    border_normal=colors["border_inactive"],
    border_width=2,
    float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),
        Match(wm_class="makebranch"),
        Match(wm_class="maketag"),
        Match(wm_class="ssh-askpass"),
        Match(wm_class="session-messenger-desktop"),
        Match(wm_class="telegram-desktop"),
        Match(wm_class="zenity"),
        Match(wm_class="galculator"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
)
