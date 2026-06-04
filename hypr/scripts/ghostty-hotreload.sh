#!/usr/bin/env bash

# SEE: https://github.com/ghostty-org/ghostty/discussions/3643

GHOSTTY_CONF_F="$HOME/.config/ghostty/config"

while ! inotifywait -e close_write,move,create,delete "$GHOSTTY_CONF_F" >/dev/null 2>&1; do
	# XXX DEPR in PR
	if [[ true -eq false ]]; then
		# CREDIT: https://github.com/ghostty-org/ghostty/discussions/3643#discussioncomment-13897392
		# Trigger ghostty config reload
		if pgrep -x ghostty &>/dev/null; then
			ghostty_addresses=$(hyprctl clients -j | jq -r '.[] | select(.class == "com.mitchellh.ghostty") | .address')

			if [[ -n "$ghostty_addresses" ]]; then
				# Save current active window
				current_window=$(hyprctl activewindow -j | jq -r '.address')

				# Focus each ghostty window and send reload key combo
				while IFS= read -r address; do
					hyprctl dispatch focuswindow "address:$address"
					sleep 0.1
					hyprctl dispatch sendshortcut "CTRL SHIFT, comma, address:$address"
				done <<<"$ghostty_addresses"

				# Return focus to original window
				if [[ -n "$current_window" ]]; then
					hyprctl dispatch focuswindow "address:$current_window"
				fi
			fi
		fi
	else
		pkill -USR2 ghostty
	fi
done
