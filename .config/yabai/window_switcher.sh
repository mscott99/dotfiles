#!/bin/zsh
app_name="$1"
window_id=$(grep -F "$app_name:" /private/tmp/yabai-window-cache | cut -d':' -f2)
if [ -n "$window_id" ]; then
    yabai -m window --focus "$window_id"
else
    open -a "$app_name"
    osascript -e "display notification \"Opening $app_name\" with title \"Window Switcher\""
fi
