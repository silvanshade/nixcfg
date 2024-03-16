#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
hyprctl --batch "$HYPRCMDS" >>/tmp/hypr/hyprexitwithgrace.log 2>&1

systemctl --user stop tray.target
systemctl --user stop hyprland-session.target
systemctl --user stop graphical-session.target

hyprctl dispatch exit 0
