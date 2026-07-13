#!/bin/bash

# --- CONFIGURATION ---
# The path to eww binary and config
EWW_BIN="eww"
CFG="$HOME/.config/eww/"

WIDGET="music"

# Check interval in seconds
INTERVAL=2
# ---------------------

# Loop forever
while true; do
    # Check if Spotify is running
    if pgrep -x "spotify" > /dev/null; then
        
        # Spotify is OPEN. Check if the widget is NOT open.
        # We grep the active windows list to see if our widget is there.
        if ! $EWW_BIN --config "$CFG" active-windows | grep -q "$WIDGET"; then
            $EWW_BIN --config "$CFG" open "$WIDGET"
        fi
        
    else
        # Spotify is CLOSED. Check if the widget IS open.
        if $EWW_BIN --config "$CFG" active-windows | grep -q "$WIDGET"; then
            $EWW_BIN --config "$CFG" close "$WIDGET"
        fi
    fi

    sleep $INTERVAL
done