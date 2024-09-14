#!/usr/bin/env bash

# Display names
PRIMARY="DisplayPort-1"    # 2K @ 165Hz
SECONDARY="DisplayPort-0"  # 1080p @ 60Hz
HDMI="HDMI-A-0"            # 1080p @ 60Hz

# Display resolutions and refresh rates
PRIMARY_RES="2560x1440_165.00"
SECONDARY_RES="1920x1080"
HDMI_RES="1920x1080"

# Modeline for 2560x1440 at 165Hz
MODEL_NAME="2560x1440_165.00"
MODELINE="378.10  2560 2744 3016 3472  1440 1443 1448 1650 -hsync +vsync"

# Check connected displays
connected_displays=$(xrandr --listmonitors | awk '{print $NF}' | tail -n +2)

# Set up display configurations
flag=false
if echo "$connected_displays" | grep -q "$HDMI"; then
    xrandr --output $HDMI --mode $HDMI_RES --pos 0x0
	flag = true
else
    xrandr --output $HDMI --off
fi

if echo "$connected_displays" | grep -q "$PRIMARY"; then
    # Add and apply new mode for 2K at 165Hz if needed
    if ! xrandr | grep -q "$MODEL_NAME"; then
    	xrandr --newmode "$MODEL_NAME" $MODELINE
    	xrandr --addmode $PRIMARY "$MODEL_NAME"
    fi
	# First monitor may occasionally be turned off
	if $flag; then
    	xrandr --output $PRIMARY --mode "$MODEL_NAME" --pos 0x0
	else
    	xrandr --output $PRIMARY --mode "$MODEL_NAME" --pos 1920x0
	fi
else
    xrandr --output $PRIMARY --off
fi

if echo "$connected_displays" | grep -q "$SECONDARY"; then
	if $flag; then
    	xrandr --output $SECONDARY --mode $SECONDARY_RES --pos 2560x0
	else
    	xrandr --output $SECONDARY --mode $SECONDARY_RES --pos 4480x0
	fi
else
    xrandr --output $SECONDARY --off
fi

# Optional: set a default configuration if no displays are connected
if [ -z "$connected_displays" ]; then
    xrandr --output $PRIMARY --off --output $SECONDARY --off --output $HDMI --off
fi
