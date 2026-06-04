#!/usr/bin/env bash

hyprctl activewindow -j | jq -r '.pid' | xargs kill -9
