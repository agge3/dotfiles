#!/usr/bin/env bash

# xxx just make two hyprland configs instead of this, also gives more tailored
# experience!

main_monitor="DP-2"
kvm_monitor="DP-1"
conf="$HOME/.config/hypr/hyprland.conf"
offset="1920x0"

main_main="\\\$main_monitor=$main_monitor"
middle_main="monitor=\\\$main_monitor,2560x1440@165,$offset,1,bitdepth,10"
right_main="monitor=$kvm_monitor,1920x1080@60,4480x0,1"

main_kvm="\\\$main_monitor=$kvm_monitor"
middle_kvm="monitor=$main_monitor,disable"
right_kvm="monitor=\\\$main_monitor,1920x1080@60,1920x0,1"

# left: doesn't change
# monitor = HDMI-A-1, 1920x1080@60, 0x0, 1

echo "$main_main"
echo "$main_kvm"
echo "$middle_main"
echo "$middle_kvm"
echo "$right_main"
echo "$right_kvm"

if hyprctl monitors | grep -q -F "$main_monitor"; then
	sed -i	\
		-e "s|$main_main|$main_kvm|"	\
		-e "s|$middle_main|$middle_kvm|"	\
		-e "s|$right_main|$right_kvm|"	\
	"$conf"
	hyprctl keyword monitor "$main_monitor,disable"
else
	sed -i	\
		-e "s|$main_kvm|$main_main|"	\
		-e "s|$middle_kvm|$middle_main|"	\
		-e "s|$right_kvm|$right_main|"	\
	"$conf"
	hyprctl keyword monitor "$main_monitor,2560x1440@165,$offset,1"
fi
