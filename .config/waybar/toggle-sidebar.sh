#!/bin/bash
CONFIG="$HOME/.config/waybar/config-sidebar.jsonc"
STYLE="$HOME/.config/waybar/style.css"


if pgrep -x "waybar" > /dev/null; then
    echo 1 > $XDG_RUNTIME_DIR/sidebar-hidden
    pkill waybar
else
    if [ -f "$XDG_RUNTIME_DIR/sidebar-hidden" ]; then
        waybar -c "$CONFIG" -s "$STYLE" &
    else
        sleep 5
        waybar -c "$CONFIG" -s "$STYLE" &
    fi
fi