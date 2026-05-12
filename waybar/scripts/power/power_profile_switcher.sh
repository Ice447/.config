#!/usr/bin/env bash

set -euo pipefail

wofi_style="$HOME/.config/wofi/style.css"

choose_menu() {
    local prompt="$1"
    local height="$2"
    shift 2

    printf '%s\n' "$@" |
        wofi --dmenu \
            --prompt "$prompt" \
            --width 260 \
            --height "$height" \
            --style "$wofi_style"
}

notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "$@"
    fi
}

selection="$(choose_menu "Power profile" 320 \
    "󰓅 performance" \
    "󰾅 balanced" \
    "󰌪 power-saver" \
    "󰓡 waybar position" \
    "󰜉 reboot" \
    "󰐥 shutdown" \
    "󰍃 logout")" || exit 0

case "$selection" in
    *performance*) profile="performance" ;;
    *balanced*) profile="balanced" ;;
    *power-saver*) profile="power-saver" ;;
    *"waybar position"*)
        position="$(
            python3 - "$HOME/.config/waybar/config" <<'PY'
import json
import sys
from pathlib import Path

config_path = Path(sys.argv[1])

try:
    with config_path.open(encoding="utf-8") as config_file:
        current_position = json.load(config_file).get("position", "top")
except (OSError, json.JSONDecodeError):
    current_position = "top"

print("top" if current_position == "bottom" else "bottom")
PY
        )"
        "$HOME/.config/waybar/scripts/system/set_waybar_position.sh" "$position"
        exit 0
        ;;
    *reboot*)
        systemctl reboot
        exit 0
        ;;
    *shutdown*)
        systemctl poweroff
        exit 0
        ;;
    *logout*)
        swaymsg exit
        exit 0
        ;;
    *) exit 0 ;;
esac

if powerprofilesctl set "$profile"; then
    pkill -RTMIN+8 waybar 2>/dev/null || true
    notify "Power profile" "$profile"
else
    notify "Power profile" "Could not set $profile"
    exit 1
fi
