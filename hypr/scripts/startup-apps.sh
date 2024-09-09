#!/usr/bin/env bash

# gentoo pipewire sound server
exec gentoo-pipewire-launcher &

# hypr ecosystem
#exec hypridle &
exec hyprpaper &
exec hyprcursor &

# polkit - kde is best (gentoowiki)
exec /usr/lib64/libexec/polkit-kde-authentication-agent-1 &

# notification manager
exec dunst &

# taskbar
exec waybar &

# clipboard
exec wl-clipboard &
exec copyq --start-server &

# japanese ime
exec fcitx5 &
