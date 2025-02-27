#!/usr/bin/env sh

# Set up display configuration.
~/scripts/x11_tools/set-display.sh

# Load X utilities.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
xrdb ~/.Xresources

# Start compositor as daemon (BEFORE window manager).
picom --daemon --config ~/.config/picom/picom.conf

# Start window manager and redirect logs to `.cache`.
exec dbus-launch --sh-syntax --exit-with-session awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr

# IBus environment variables:
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus

# Use `xim` in case some Electron apps (like Chromium) refuse to work with IBus.
export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

ibus-daemon -drx
