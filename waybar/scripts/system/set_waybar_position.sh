#!/usr/bin/env bash

set -euo pipefail

position="${1:-}"
config="${WAYBAR_CONFIG:-$HOME/.config/waybar/config}"
restart_waybar="${WAYBAR_RESTART:-1}"
send_notification="${WAYBAR_NOTIFY:-1}"

case "$position" in
    top|bottom) ;;
    *)
        printf 'usage: %s top|bottom\n' "$0" >&2
        exit 2
        ;;
esac

python3 - "$config" "$position" <<'PY'
import json
import sys
from pathlib import Path

config_path = Path(sys.argv[1])
position = sys.argv[2]

with config_path.open(encoding="utf-8") as config_file:
    config = json.load(config_file)

def place_pulseaudio_before_network(modules):
    modules = [module for module in modules if module != "pulseaudio"]
    insert_at = modules.index("network") if "network" in modules else 0
    modules.insert(insert_at, "pulseaudio")
    return modules

config["position"] = position
config.pop("width", None)
config["height"] = 27
config["modules-center"] = ["sway/window"]
config["modules-right"] = place_pulseaudio_before_network(config.get("modules-right", []))

with config_path.open("w", encoding="utf-8") as config_file:
    json.dump(config, config_file, ensure_ascii=False, indent=4)
    config_file.write("\n")
PY

if [[ "$restart_waybar" == "1" ]]; then
    pkill -x waybar >/dev/null 2>&1 || true
    setsid waybar >/dev/null 2>&1 &
fi

if [[ "$send_notification" == "1" ]] && command -v notify-send >/dev/null 2>&1; then
    notify-send "Waybar" "Position: $position"
fi
