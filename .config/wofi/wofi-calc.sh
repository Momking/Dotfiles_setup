#!/bin/bash
# 1. Clear previous result 
# 2. Open wofi in dmenu mode
# 3. Pipe input to qalc (calculator)
# 4. Copy result to clipboard

expression=$(wofi --dmenu --prompt "Calculate: ")

if [ -n "$expression" ]; then
    # Use qalc to calculate. '-t' prints only the result.
    result=$(qalc -t "$expression")
    
    # Notify user and copy to clipboard
    notify-send "Result: $result"
    wl-copy "$result"
fi