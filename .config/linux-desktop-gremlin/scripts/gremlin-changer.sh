#!/bin/bash

# 1. Define the list of characters
gremlin_list=("hikari" "agnes-tachyon" "cafe" "gold-ship" "haru-urara" "mambo" "meisho-doto" "oguri-cap" "opera" "rice-shower")
RUN_SCRIPT="/home/nishant/.config/linux-desktop-gremlin/run.sh"

# 2. Check if a gremlin is currently running
# pgrep -af returns the full command line so we can see which name was used
RUNNING_INFO=$(pgrep -af "src.launcher")
LOG_FILE="/home/nishant/.config/linux-desktop-gremlin/animation_log.txt"

if [ -n "$RUNNING_INFO" ]; then
    # 3. Identify which character is currently running
    # It takes the last word of the command line (the character name)
    CURRENT_CHAR=$(echo "$RUNNING_INFO" | awk '{print $NF}' | head -n 1)

    # 4. Find the next character in the list (Cycling logic)
    NEXT_CHAR=""
    for i in "${!gremlin_list[@]}"; do
       if [[ "${gremlin_list[$i]}" == "$CURRENT_CHAR" ]]; then
           # Move to the next index, or back to 0 if at the end
           next_idx=$(( (i + 1) % ${#gremlin_list[@]} ))
           NEXT_CHAR="${gremlin_list[$next_idx]}"
           break
       fi
    done

    # Fallback if character wasn't in list
    if [ -z "$NEXT_CHAR" ]; then NEXT_CHAR="${gremlin_list[0]}"; fi

    # 5. Kill the current one
    pkill -f "src.launcher"

    # Give it a split second to close
    sleep 0.3

    # 5. READ the last position from the text file (Bash way)
    if [ -f "$LOG_FILE" ]; then
        # Reads "x,y" from file into variables
        IFS=',' read -r pos_x pos_y < "$LOG_FILE"
    else
        pos_x=0
        pos_y=650
    fi

    # 6. Launch the next one
    $RUN_SCRIPT "$NEXT_CHAR" &

    # sleep 0.5

    # Move the new window to the saved coordinates
    # niri msg action move-floating-window --x "$pos_x" --y "$pos_y"
    # notify-send "Gremlin" "Switched to $NEXT_CHAR at $pos_x, $pos_y"
else
    # 7. If nothing is running, start with the first one (hikari)
    $RUN_SCRIPT "hikari" &
fi
