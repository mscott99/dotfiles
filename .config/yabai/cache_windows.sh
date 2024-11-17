#!/bin/zsh
while true; do
    tmp_file=$(mktemp)
    yabai -m query --windows | \
        jq -r '.[] | "\(.app):\(.id)"' > "$tmp_file"
    mv "$tmp_file" /private/tmp/yabai-window-cache
    sleep 0.5
done
