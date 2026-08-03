#!/usr/bin/env bash

# Direct directory for quick notes
NOTES_DIR="$HOME/txt"
mkdir -p "$NOTES_DIR"

# Generate a timestamped file
FILENAME="$NOTES_DIR/note-$(date +'%Y-%m-%d_%H-%M-%S').md"

# Launch alacritty with custom WM_CLASS so Qtile keeps it on current group and floats top-center
alacritty --class QuickNotes,QuickNotes --title "Anotação Rápida" -e nvim "$FILENAME"
