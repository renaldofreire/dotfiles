"""
Layouts Configuration
"""

from libqtile import layout
from libqtile.config import Match
from .colors import colors

# Common border configuration
BORDER_CONFIG = dict(
    border_focus=colors["border_active"],
    border_normal=colors["border_inactive"],
    border_width=2,
    margin=4,
)

layouts = [
    layout.Columns(
        **BORDER_CONFIG,
        border_focus_stack=[colors["border_active"], colors["secondary"]],
    ),
    layout.Max(**BORDER_CONFIG),
    # Additional layouts (uncomment to enable)
    # layout.MonadTall(**BORDER_CONFIG),
    # layout.Spiral(**BORDER_CONFIG),
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
        Match(wm_class="TelegramDesktop"),
        Match(wm_class="zenity"),
        Match(wm_class="galculator"),
        Match(wm_class="QuickNotes"),
        Match(wm_class="quick-notes"),
        Match(title="branchdialog"),
        Match(title="pinentry"),
    ],
)
