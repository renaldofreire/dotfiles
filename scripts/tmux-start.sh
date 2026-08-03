#!/usr/bin/env bash

# If inside tmux, create a new window; otherwise start a new session or attach
if [ -z "$TMUX" ]; then
    tmux new-session
else
    tmux new-window
fi
