#!/bin/bash

# 1. Search for files in Home, ignoring hidden files/folders
# 2. Show them in Wofi
# 3. Open the selected file with the default app (xdg-open)

selection=$(fd --type f . $HOME --hidden --exclude .git | wofi --show dmenu --prompt "Search Files" --width 800 --height 500)

# If we selected a file, open it
if [ -n "$selection" ]; then
    xdg-open "$selection"
    # Optional: notify user
    notify-send "Opening:" "$selection"
fi
