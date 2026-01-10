"""
Color Schemes for Qtile
"""

# Tema atual - troque aqui para mudar o tema
CURRENT_THEME = "custom"

# Seus cores atuais (Raven Black + Blue)
custom = {
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

# Tema Dracula
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

# Tema Nord
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

# Seleciona o tema
themes = {
    "custom": custom,
    "dracula": dracula,
    "nord": nord,
}

colors = themes.get(CURRENT_THEME, custom)
