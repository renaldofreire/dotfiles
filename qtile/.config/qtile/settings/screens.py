"""
Screens Configuration
"""

from libqtile import bar, qtile
from libqtile.config import Screen
from .widgets import get_widgets


def get_screens():
    """Auto-detect monitors and create screens accordingly."""
    screens = []
    # Get number of connected monitors
    num_monitors = len(qtile.conn.pseudoscreens) if hasattr(qtile, 'conn') else 1
    
    for i in range(max(1, num_monitors)):
        screens.append(
            Screen(
                top=bar.Bar(
                    get_widgets(primary=(i == 0)),
                    22,
                    margin=[0, 0, 0, 0],
                ),
            )
        )
    return screens


screens = get_screens()
