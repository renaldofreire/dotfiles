"""
Hooks and Callbacks
"""

import os
import subprocess
from libqtile import hook


@hook.subscribe.startup_once
def autostart():
    """Executa script de autostart uma vez na inicialização"""
    home = os.path.expanduser("~/.config/qtile/scripts/autostart.sh")
    subprocess.Popen(["sh", home])


@hook.subscribe.client_new
def floating_dialogs(window):
    """Faz diálogos flutuarem automaticamente"""
    dialog = window.window.get_wm_type() == "dialog"
    transient = window.window.get_wm_transient_for()
    if dialog or transient:
        window.floating = True


# Hook para adicionar PATH do pipx
@hook.subscribe.startup
def setup_environment():
    """Configura variáveis de ambiente"""
    home = os.path.expanduser("~")
    local_bin = os.path.join(home, ".local", "bin")

    if local_bin not in os.environ["PATH"]:
        os.environ["PATH"] = local_bin + os.pathsep + os.environ["PATH"]
