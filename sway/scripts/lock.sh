#!/bin/bash

BAT_CAP=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n 1)
BAT_CAP=${BAT_CAP:-"--"}

LOCK_SCREEN_COLOR="#282828"
LOCK_BS_HL_COLOR="#fb4934"
LOCK_CAPS_LOCK_BS_HL_COLOR="#fb4934"
LOCK_CAPS_LOCK_KEY_HL_COLOR="#fabd2f"
LOCK_INSIDE_COLOR="#282828"
LOCK_INSIDE_CLEAR_COLOR="#282828"
LOCK_INSIDE_CAPS_LOCK_COLOR="#282828"
LOCK_INSIDE_VERIFY_COLOR="#282828"
LOCK_INSIDE_WRONG_COLOR="#282828"
LOCK_KEY_HL_COLOR="#8ec07c"
LOCK_LAYOUT_BG_COLOR="#282828"
LOCK_LAYOUT_BORDER_COLOR="#3c3836"
LOCK_LAYOUT_TEXT_COLOR="#ebdbb2"
LOCK_LINE_COLOR="#3c3836"
LOCK_LINE_CLEAR_COLOR="#3c3836"
LOCK_LINE_CAPS_LOCK_COLOR="#fabd2f"
LOCK_LINE_VERIFY_COLOR="#FDFD96"
LOCK_LINE_WRONG_COLOR="#fb4934"
LOCK_RING_COLOR="#E4D4A3"
LOCK_RING_CLEAR_COLOR="#ebdbb2"
LOCK_RING_CAPS_LOCK_COLOR="#fabd2f"
LOCK_RING_VERIFY_COLOR="#FDFD96"
LOCK_RING_WRONG_COLOR="#fb4934"
LOCK_SEPARATOR_COLOR="#000000"
LOCK_TEXT_COLOR="#ebdbb2"
LOCK_TEXT_CLEAR_COLOR="#ebdbb2"
LOCK_TEXT_CAPS_LOCK_COLOR="#fabd2f"
LOCK_TEXT_VERIFY_COLOR="#ebdbb2"
LOCK_TEXT_WRONG_COLOR="#ebdbb2"

theme_file="$HOME/.config/sway/scripts/lock-colors.sh"
if [[ -r "$theme_file" ]]; then
    # shellcheck source=/dev/null
    source "$theme_file"
fi

hex_color() {
    local color="${1:-#000000}"
    color="${color#\#}"
    printf '%s' "${color:0:6}"
}

hex_alpha() {
    printf '%s%s' "$(hex_color "$1")" "$2"
}

swaylock \
    --screenshots \
    --clock \
    --indicator \
    --indicator-radius 120 \
    --indicator-thickness 15 \
    --effect-blur 10x10 \
    --effect-vignette 0.5:0.5 \
    --font "JetBrains Mono" \
    --font "Symbols Nerd Font" \
    --color "$(hex_color "$LOCK_SCREEN_COLOR")" \
    --bs-hl-color "$(hex_color "$LOCK_BS_HL_COLOR")" \
    --caps-lock-bs-hl-color "$(hex_color "$LOCK_CAPS_LOCK_BS_HL_COLOR")" \
    --caps-lock-key-hl-color "$(hex_color "$LOCK_CAPS_LOCK_KEY_HL_COLOR")" \
    --inside-color "$(hex_alpha "$LOCK_INSIDE_COLOR" cc)" \
    --inside-clear-color "$(hex_alpha "$LOCK_INSIDE_CLEAR_COLOR" cc)" \
    --inside-caps-lock-color "$(hex_alpha "$LOCK_INSIDE_CAPS_LOCK_COLOR" cc)" \
    --inside-ver-color "$(hex_alpha "$LOCK_INSIDE_VERIFY_COLOR" cc)" \
    --inside-wrong-color "$(hex_alpha "$LOCK_INSIDE_WRONG_COLOR" cc)" \
    --key-hl-color "$(hex_color "$LOCK_KEY_HL_COLOR")" \
    --layout-bg-color "$(hex_alpha "$LOCK_LAYOUT_BG_COLOR" cc)" \
    --layout-border-color "$(hex_color "$LOCK_LAYOUT_BORDER_COLOR")" \
    --layout-text-color "$(hex_color "$LOCK_LAYOUT_TEXT_COLOR")" \
    --line-color "$(hex_color "$LOCK_LINE_COLOR")" \
    --line-clear-color "$(hex_color "$LOCK_LINE_CLEAR_COLOR")" \
    --line-caps-lock-color "$(hex_color "$LOCK_LINE_CAPS_LOCK_COLOR")" \
    --line-ver-color "$(hex_color "$LOCK_LINE_VERIFY_COLOR")" \
    --line-wrong-color "$(hex_color "$LOCK_LINE_WRONG_COLOR")" \
    --ring-color "$(hex_color "$LOCK_RING_COLOR")" \
    --ring-clear-color "$(hex_color "$LOCK_RING_CLEAR_COLOR")" \
    --ring-caps-lock-color "$(hex_color "$LOCK_RING_CAPS_LOCK_COLOR")" \
    --ring-ver-color "$(hex_color "$LOCK_RING_VERIFY_COLOR")" \
    --ring-wrong-color "$(hex_color "$LOCK_RING_WRONG_COLOR")" \
    --separator-color "$(hex_alpha "$LOCK_SEPARATOR_COLOR" 00)" \
    --text-color "$(hex_color "$LOCK_TEXT_COLOR")" \
    --text-clear-color "$(hex_color "$LOCK_TEXT_CLEAR_COLOR")" \
    --text-caps-lock-color "$(hex_color "$LOCK_TEXT_CAPS_LOCK_COLOR")" \
    --text-ver-color "$(hex_color "$LOCK_TEXT_VERIFY_COLOR")" \
    --text-wrong-color "$(hex_color "$LOCK_TEXT_WRONG_COLOR")" \
    --timestr "%H:%M" \
    --datestr "%a, %d %b | $BAT_CAP%"
