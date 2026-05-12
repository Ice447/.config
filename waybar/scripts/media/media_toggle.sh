#!/usr/bin/env bash

set -euo pipefail

playerctl_cmd="$HOME/.config/waybar/scripts/media/playerctl-priority.sh"
status="$("$playerctl_cmd" status 2>/dev/null || true)"

case "$status" in
    Playing)
        printf '{"text":"󰏤","tooltip":"Pause"}\n'
        ;;
    Paused)
        printf '{"text":"󰐊","tooltip":"Wiedergabe"}\n'
        ;;
    *)
        printf '{"text":"","class":"hidden"}\n'
        ;;
esac
