#!/bin/bash

# --- CONFIGURATION ---
WALLPAPER_DIR="$HOME/Downloads/Wallpaper"
EWW_BIN="eww"
CFG="$HOME/.config/eww/"

# --- 1. PREPARE THE LIST WITH ICONS ---
# We loop through files and format them for Rofi:
# "FilePath \0 icon \x1f FilePath"
# This tells Rofi: "Return the path, but use the image at the path as the icon."

if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found!"
    exit 1
fi

# This finds images and pipes them into rofi with icon support
SELECTED=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) -print0 | sort -z | while IFS= read -r -d '' file; do
    echo -en "$(basename "$file")\0icon\x1f$file\n"
done | rofi -dmenu -i -show-icons -p "Wallpaper" \
    -theme-str '@import "~/.config/rofi/colors.rasi"' \
    -theme-str 'window { width: 800px; border: 3px; border-color: @main-br; background-color: @main-bg; border-radius: 12px; }' \
    -theme-str 'listview { columns: 4; lines: 3; background-color: transparent; }' \
    -theme-str 'element { orientation: vertical; padding: 10px; background-color: transparent; text-color: @main-fg; }' \
    -theme-str 'element selected { background-color: @select-bg; text-color: @select-fg; border-radius: 8px; }' \
    -theme-str 'element-icon { size: 120px; }' \
    -theme-str 'element-text { vertical-align: 0.5; horizontal-align: 0.5; text-color: inherit; }')

# Exit if no selection made
if [ -z "$SELECTED" ]; then
    exit 0
fi

# Rofi returns just the filename because of how we piped it.
# We need to reconstruct the full path.
FULL_PATH="$WALLPAPER_DIR/$SELECTED"

# --- 3. APPLY LOGIC ---

# A. Ensure swww daemon is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

if pgrep -x "hyprpaper.conf" > /dev/null; then
    pkill -f "/home/nishant/.config/hypr/hyprpaper.conf"
fi

# B. Generate the Blurred Image
FILENAME=$(basename "$FULL_PATH")
BLURRED_IMG="/tmp/${FILENAME%.*}-blurred.png"

if [ ! -f "$BLURRED_IMG" ]; then
    convert "$FULL_PATH" -blur 0x25 "$BLURRED_IMG"
fi

# notify-send "Wallpaper" "Applying wallpaper... ${FILENAME}"
dms ipc call wallpaper set "$FULL_PATH"

# C. Apply Wallpaper (Blurred version)
swww img "$BLURRED_IMG" --transition-type grow --transition-pos 0.5,0.5 --transition-fps 60 --transition-step 20

# D. Update EWW
$EWW_BIN --config "$CFG" update current_wallpaper="$FULL_PATH"

# E. Update Matugen
matugen image "$FULL_PATH"
