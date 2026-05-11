#!/usr/bin/env bash

preferred_player="${MEDIA_PREFERRED_PLAYER:-spotify}"

if playerctl --player="$preferred_player" status >/dev/null 2>&1; then
    exec playerctl --player="$preferred_player" "$@"
fi

exec playerctl "$@"
