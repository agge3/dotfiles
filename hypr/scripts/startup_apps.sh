#!/usr/bin/env bash

# gentoo pipewire sound server
exec gentoo-pipewire-launcher &

# sway lock screen and idle
exec swayidle -w \
    timeout 300 'swaylock -f' \
    timeout 600 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    before-sleep 'swaylock -f' &

# polkit - kde is best (gentoowiki)
exec /usr/lib64/libexec/polkit-kde-authentication-agent-1 &

# notification manager
exec dunst &

# taskbar
exec waybar &

# wallpaper manager
exec hyprpaper &

# clipboard
exec wl-clipboard &
exec copyq --start-server &

# japanese ime
exec fcitx5 &
