#!/usr/bin/env sh

# Set up display configurations using xrandr.
~/.config/awesome/scripts/displays.sh

# Load X utilities.
xrdb ~/.Xresources

# Start compositor as daemon (BEFORE window manager).
picom --daemon --config ~/.config/picom/picom.conf

# Start window manager.
exec dbus-launch --sh-syntax --exit-with-session awesome

# IBus environment variables:
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

# Use `xim` in case some Electron apps (like Chromium) refuse to work with IBus.
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

ibus-daemon -drx
