"""
Screens Configuration
"""

from libqtile import bar
from libqtile.config import Screen
from .widgets import get_widgets

screens = [
    Screen(
        top=bar.Bar(
            get_widgets(primary=True),
            22,
            margin=[0, 0, 0, 0],
        ),
    ),
]

# Para múltiplos monitores, adicione mais screens:
# screens.append(
#     Screen(
#         top=bar.Bar(get_widgets(), 22),
#     )
# )
