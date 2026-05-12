# Sway Desktop Configuration

Personal desktop configuration for Sway, Waybar, Wofi, and Matugen.

## What Is Here

- `sway/`: compositor config, keybindings, idle behavior, lock screen scripts, and generated theme colors.
- `waybar/`: bar config, generated CSS, and small helper scripts for media, power profiles, and system toggles.
- `wofi/`: launcher config, generated CSS, and launcher wrapper.
- `matugen/`: wallpaper-based theme templates and the script that regenerates Sway, Waybar, Wofi, and lock screen colors.

Generated files are kept in the repo because they are the active files used by the desktop session:

- `sway/config.d/theme.conf`
- `sway/scripts/lock-colors.sh`
- `waybar/style.css`
- `wofi/style.css`

When changing generated styling, edit the matching file in `matugen/templates/` too.

## Dependencies

Core session tools:

- `sway`
- `waybar`
- `wofi`
- `matugen`
- `swayidle`
- `swaylock`

Helper scripts expect:

- `bash`
- `python3`
- `playerctl`
- `curl`
- `imagemagick`
- `powerprofilesctl`
- `nmcli`
- `bluetoothctl`
- `pactl`
- `brightnessctl`
- `grim`
- `slurp`
- `wl-copy`
- `wl-paste`
- `cliphist`
- `swaynag`
- `notify-send` (optional notifications)

Configured apps referenced by autostart or keybindings:

- `foot`
- `firefox`
- `spotify`
- `elecwhat`
- `vesktop`
- `gnome-keyring-daemon`
- `blueman-manager`
- `pavucontrol`
- `nm-connection-editor`

## Common Commands

Apply wallpaper colors without reloading Sway:

```sh
~/.config/matugen/scripts/apply-wallpaper-theme.sh --no-reload
```

Apply colors from a specific wallpaper and reload Sway:

```sh
~/.config/matugen/scripts/apply-wallpaper-theme.sh /path/to/wallpaper.png
```

Reload the running Sway session:

```sh
swaymsg reload
```

## Local Assumptions

The default wallpaper path is:

```text
~/.wallpaper/background.png
```

The repo lives directly under `~/.config`, so `.gitignore` ignores everything by default and then allows only this dotfiles codebase.
