#!/usr/bin/env bash

main_monitor="DP-2"

handle() {
	case $1 in monitoradded*)
		# workspace = 1, monitor:$main_monitor, default:true, persistent:true
		# workspace = 2, monitor:$main_monitor
		# workspace = 3, monitor:$main_monitor
		# workspace = 4, monitor:$main_monitor
		# workspace = 5, monitor:$main_monitor
		# workspace = 6, monitor:$main_monitor
		# workspace = 7, monitor:$main_monitor
		# workspace = 8, monitor:$main_monitor
		# workspace = 11, monitor:$main_monitor
		# workspace = 12, monitor:$main_monitor
		# workspace = 13, monitor:$main_monitor
		# workspace = 14, monitor:$main_monitor
		# workspace = 15, monitor:$main_monitor
		# workspace = 16, monitor:$main_monitor
		# workspace = 17, monitor:$main_monitor
		# workspace = 18, monitor:$main_monitor
		# workspace = 19, monitor:$main_monitor
		# workspace = 20, monitor:$main_monitor
		for ((i = 1; i <= 8; i++)); do
			hyprctl dispatch moveworkspacetomonitor "$i $main_monitor"
		done
		for ((i = 11; i <= 20; i++)); do
			hyprctl dispatch moveworkspacetomonitor "$i $main_monitor"
		done
		;;
	esac
}

socat -u \
	UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - |
	while read -r line; do handle "$line"; done
