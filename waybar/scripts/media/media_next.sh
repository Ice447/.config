#!/usr/bin/env bash

set -euo pipefail

playerctl_cmd="$HOME/.config/waybar/scripts/media/playerctl-priority.sh"

status="$("$playerctl_cmd" status 2>/dev/null || true)"
title="$("$playerctl_cmd" metadata title 2>/dev/null || true)"
player="$("$playerctl_cmd" metadata --format '{{playerName}}' 2>/dev/null || true)"
text="󰒭"

case "$status" in
    Playing|Paused)
        if [ -n "$title" ] || [ -n "$player" ]; then
            class=""
        else
            class="collapsed"
        fi
        ;;
    *)
        text=""
        class="hidden"
        ;;
esac

python3 -c 'import json, sys; print(json.dumps({"text": sys.argv[1], "tooltip": sys.argv[2], "class": sys.argv[3]}))' \
    "$text" "Naechster Titel" "$class"
