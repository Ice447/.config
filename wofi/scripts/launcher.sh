#!/usr/bin/env bash

set -euo pipefail

exec wofi --show drun \
    --conf "$HOME/.config/wofi/config" \
    --style "$HOME/.config/wofi/style.css"
