#!/bin/bash

# $1 is the hook name (onWallpaperChanged)
# $2 is the value (the file path to the wallpaper)

WALLPAPER_PATH=$2

# sleep 3

EWW_BIN="eww"
CFG="$HOME/.config/eww/"
WIDGET_WALLPAPER="wallpaper"

# 1. Start swww-daemon if not running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

# 2. Open EWW window if needed
if ! $EWW_BIN --config "$CFG" active-windows | grep -q "$WIDGET_WALLPAPER"; then
    $EWW_BIN --config "$CFG" open "$WIDGET_WALLPAPER"
fi

FILENAME=$(basename "$WALLPAPER_PATH")
BLURRED_IMG="/tmp/${FILENAME%.*}-blurred.png"

# Generate the blurred image if it doesn't exist
if [ ! -f "$BLURRED_IMG" ]; then
    magick "$WALLPAPER_PATH" -blur 0x25 "$BLURRED_IMG"
fi

# 3. Set the wallpaper using swww
swww img "$BLURRED_IMG" --transition-type grow --transition-pos 0.5,0.5 --transition-fps 60 --transition-step 20

$EWW_BIN --config "$CFG" update current_wallpaper="$WALLPAPER_PATH"

# Cleanup old blurred image (optional, to save space in /tmp)
# rm "$BLURRED_IMG"

matugen image "$WALLPAPER_PATH" --prefer=darkness
