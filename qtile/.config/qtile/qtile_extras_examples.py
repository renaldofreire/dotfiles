# Arquivo: ~/.config/qtile/qtile_extras_examples.py
# Exemplos de widgets do qtile-extras para adicionar à sua configuração

"""
Este arquivo contém exemplos de widgets do qtile-extras que você pode adicionar
à sua configuração principal. Copie os que desejar para o seu config.py.
"""

import qtile_extras.widget as qe_widget
from qtile_extras.widget.decorations import (
    RectDecoration,
    PowerLineDecoration,
    BorderDecoration,
)

# Cores para os exemplos
colors = {
    "background": "#090707",
    "foreground": "#f8f8f2",
    "cyan": "#8be9fd",
    "green": "#50fa7b",
    "purple": "#bd93f9",
    "red": "#ff5555",
    "yellow": "#f1fa8c",
    "blue": "#6272a4",
    "orange": "#ffb86c",
    "pink": "#ff79c6",
    "background_alt": "#44475a",
}

# ===== WIDGETS DE SISTEMA =====

# 1. Widget de CPU com temperatura
cpu_widget = qe_widget.CPUGraph(
    type="box",
    graph_color=colors["cyan"],
    fill_color=colors["cyan"],
    border_color=colors["background_alt"],
    decorations=[
        RectDecoration(
            colour=colors["background_alt"],
            radius=8,
            filled=True,
            padding_y=2,
        )
    ],
)

# 2. Widget de temperatura
thermal_widget = qe_widget.ThermalSensor(
    foreground=colors["red"],
    threshold=70,
    fmt="🌡️ {temp:.0f}°C",
    decorations=[PowerLineDecoration(path="arrow_right")],
)

# 3. Widget de rede com velocidade
net_graph = qe_widget.Net(
    interface="wlan0",  # Ajuste conforme sua interface
    format="🌐 ↓{down} ↑{up}",
    foreground=colors["green"],
)

# 4. Widget de GPU (NVIDIA)
gpu_widget = qe_widget.NvidiaSensors(
    format="🎮 GPU: {temp}°C {perf}%",
    foreground=colors["purple"],
)

# ===== WIDGETS DE MÍDIA =====

# 5. Controle de mídia (MPRIS)
media_widget = qe_widget.Mpris2(
    name="spotify",  # ou qualquer player MPRIS
    format="{xesam:artist} - {xesam:title}",
    max_chars=30,
    foreground=colors["green"],
    decorations=[
        RectDecoration(
            colour=colors["background_alt"],
            radius=10,
            filled=True,
            padding_y=2,
        )
    ],
)

# 6. Widget de volume melhorado
volume_widget = qe_widget.PulseVolume(
    fmt="🔊 {volume}%",
    foreground=colors["yellow"],
    mute_format="🔇 Muted",
)

# ===== WIDGETS DE CONECTIVIDADE =====

# 7. Widget de Bluetooth
bluetooth_widget = qe_widget.Bluetooth(
    fmt="📶 {connected}",
    foreground=colors["blue"],
)

# 8. Widget de WiFi com informações detalhadas
wifi_widget = qe_widget.Wlan(
    interface="wlan0",
    format="📶 {essid} {percent:2.0%}",
    foreground=colors["cyan"],
    decorations=[
        BorderDecoration(
            colour=colors["cyan"],
            border_width=2,
        )
    ],
)

# ===== WIDGETS DE PRODUTIVIDADE =====

# 9. Widget do Weather (requer API key)
weather_widget = qe_widget.OpenWeather(
    location="São Paulo",  # Sua cidade
    format="🌤️ {location_city}: {main_temp}°C",
    foreground=colors["orange"],
    # app_key="SUA_API_KEY_AQUI"  # Obtenha em openweathermap.org
)

# 10. Widget de notificações
notifications_widget = qe_widget.UPowerWidget(
    fmt="🔋 {percentage}%",
    foreground=colors["green"],
)

# 11. Widget de calendário popup
calendar_widget = qe_widget.Calendar(
    foreground=colors["purple"],
    background=colors["background_alt"],
)

# ===== WIDGETS DECORATIVOS =====

# 12. Separador personalizado
custom_sep = qe_widget.Sep(
    linewidth=2,
    padding=10,
    foreground=colors["background_alt"],
)

# 13. Widget de logo personalizado
logo_widget = qe_widget.TextBox(
    text="",  # Ícone do Arch Linux
    foreground=colors["cyan"],
    fontsize=16,
    padding=10,
    decorations=[
        RectDecoration(
            colour=colors["background_alt"],
            radius=8,
            filled=True,
            padding_y=2,
        )
    ],
)

# ===== WIDGETS DE MONITORAMENTO =====

# 14. Widget de espaço em disco
disk_widget = qe_widget.DF(
    visible_on_warn=False,
    format="💾 {p} {uf}{m}",
    foreground=colors["yellow"],
    partition="/",
)

# 15. Widget de processos (top)
top_widget = qe_widget.CheckUpdates(
    distro="Arch",
    display_format="📦 {updates}",
    colour_have_updates=colors["red"],
    colour_no_updates=colors["green"],
)

# ===== EXEMPLO DE BARRA ALTERNATIVA =====

# Barra inferior com widgets extras
bottom_bar_widgets = [
    qe_widget.CurrentLayoutIcon(
        scale=0.7,
        foreground=colors["purple"],
    ),
    qe_widget.TaskList(
        border=colors["cyan"],
        urgent_border=colors["red"],
        rounded=True,
        highlight_method="block",
        icon_size=16,
        max_title_width=200,
    ),
    qe_widget.Spacer(),
    disk_widget,
    custom_sep,
    thermal_widget,
    custom_sep,
    net_graph,
    custom_sep,
    weather_widget,
]

# ===== EXEMPLO DE USO NA CONFIGURAÇÃO =====
"""
Para usar estes widgets, adicione-os à sua lista de widgets na barra:

screens = [
    Screen(
        top=bar.Bar([
            # Seus widgets atuais...
            thermal_widget,
            custom_sep,
            media_widget,
            # ... mais widgets
        ], 24),
        
        # Barra inferior opcional
        bottom=bar.Bar(bottom_bar_widgets, 20),
    ),
]
"""

# ===== CONFIGURAÇÕES DE DECORAÇÕES =====

# Decorações pré-definidas que você pode reutilizar
decorations = {
    "powerline_right": [PowerLineDecoration(path="arrow_right")],
    "powerline_left": [PowerLineDecoration(path="arrow_left")],
    "rounded": [
        RectDecoration(
            colour=colors["background_alt"],
            radius=10,
            filled=True,
            padding_y=2,
            group=True,
        )
    ],
    "border": [
        BorderDecoration(
            colour=colors["cyan"],
            border_width=2,
        )
    ],
}

# ===== KEYBINDINGS PARA WIDGETS =====
"""
Adicione estas teclas de atalho ao seu keys[] para controlar widgets:

from libqtile.config import Key
from libqtile.lazy import lazy

# Atalhos para widgets de mídia
Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),

# Atalhos para WiFi
Key([mod], "F12", lazy.spawn("nmcli device wifi rescan")),

# Atalhos para Bluetooth
Key([mod, "shift"], "b", lazy.spawn("bluetoothctl power toggle")),
"""
