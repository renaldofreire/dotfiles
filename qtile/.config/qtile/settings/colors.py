"""
Color Schemes for Qtile
Modular theme management
"""

import os
import json

# Theme Selector: "raven_blue", "catppuccin_mocha", "everforest", "dracula", "nord", "monochrome_slate"
CURRENT_THEME = "monochrome_slate"

# Raven Blue (Original setup)
raven_blue = {
    "background": "#050301",
    "foreground": "#FDF5AA",
    "primary": "#34699A",
    "secondary": "#58A0C8",
    "accent": "#FDF5AA",
    "urgent": "#FF6B6B",
    "inactive": "#7BA7D1",
    "selection": "#2C5F8A",
    "border_active": "#58A0C8",
    "border_inactive": "#34699A",
    "success": "#4ECDC4",
    "warning": "#FFE66D",
    "error": "#FF6B6B",
}

# Catppuccin Mocha (Modern & Soft)
catppuccin_mocha = {
    "background": "#1e1e2e",
    "foreground": "#cdd6f4",
    "primary": "#89b4fa",
    "secondary": "#f5c2e7",
    "accent": "#fab387",
    "urgent": "#f38ba8",
    "inactive": "#585b70",
    "selection": "#313244",
    "border_active": "#89b4fa",
    "border_inactive": "#313244",
    "success": "#a6e3a1",
    "warning": "#f9e2af",
    "error": "#f38ba8",
}

# Everforest Dark (Relaxing Green)
everforest = {
    "background": "#2d353b",
    "foreground": "#d3c6aa",
    "primary": "#a7c080",
    "secondary": "#7fbbb3",
    "accent": "#dbbc7f",
    "urgent": "#e67e80",
    "inactive": "#859289",
    "selection": "#3d484d",
    "border_active": "#a7c080",
    "border_inactive": "#3d484d",
    "success": "#a7c080",
    "warning": "#dbbc7f",
    "error": "#e67e80",
}

# Dracula Theme
dracula = {
    "background": "#282a36",
    "foreground": "#f8f8f2",
    "primary": "#6272a4",
    "secondary": "#bd93f9",
    "accent": "#50fa7b",
    "urgent": "#ff5555",
    "inactive": "#44475a",
    "selection": "#44475a",
    "border_active": "#bd93f9",
    "border_inactive": "#6272a4",
    "success": "#50fa7b",
    "warning": "#f1fa8c",
    "error": "#ff5555",
}

# Nord Theme
nord = {
    "background": "#2E3440",
    "foreground": "#D8DEE9",
    "primary": "#5E81AC",
    "secondary": "#81A1C1",
    "accent": "#88C0D0",
    "urgent": "#BF616A",
    "inactive": "#4C566A",
    "selection": "#434C5E",
    "border_active": "#88C0D0",
    "border_inactive": "#5E81AC",
    "success": "#A3BE8C",
    "warning": "#EBCB8B",
    "error": "#BF616A",
}

# Monochrome Slate (Sober & Minimalist)
monochrome_slate = {
    "background": "#0f111a",
    "foreground": "#d1d5db",
    "primary": "#374151",
    "secondary": "#717b88",
    "accent": "#9ca3af",
    "urgent": "#ef4444",
    "inactive": "#374151",
    "selection": "#1f2937",
    "border_active": "#9ca3af",
    "border_inactive": "#1f2937",
    "success": "#d1d5db",
    "warning": "#9ca3af",
    "error": "#ef4444",
}

# Theme Map
themes = {
    "raven_blue": raven_blue,
    "catppuccin_mocha": catppuccin_mocha,
    "everforest": everforest,
    "dracula": dracula,
    "nord": nord,
    "monochrome_slate": monochrome_slate,
}

RECOL_THEME_FILE = os.path.expanduser("~/.config/qtile/recol_theme.json")


def load_current_theme() -> dict:
    if os.path.isfile(RECOL_THEME_FILE):
        try:
            with open(RECOL_THEME_FILE, "r") as f:
                theme_data = json.load(f)
                if isinstance(theme_data, dict) and "background" in theme_data:
                    return theme_data
        except Exception:
            pass
    return themes.get(CURRENT_THEME, raven_blue)


# Load the current theme, fallback to raven_blue
colors = load_current_theme()


def set_theme(name: str) -> dict:
    """Dynamically switch theme at runtime."""
    global colors, CURRENT_THEME
    if name in themes:
        CURRENT_THEME = name
        colors = themes[name]
        if os.path.isfile(RECOL_THEME_FILE):
            try:
                os.remove(RECOL_THEME_FILE)
            except OSError:
                pass
    return colors


def cycle_theme() -> dict:
    """Cycle to the next available theme."""
    theme_names = list(themes.keys())
    current_idx = theme_names.index(CURRENT_THEME) if CURRENT_THEME in theme_names else 0
    next_idx = (current_idx + 1) % len(theme_names)
    return set_theme(theme_names[next_idx])


def get_available_themes() -> list:
    """Return list of available theme names."""
    return list(themes.keys())
