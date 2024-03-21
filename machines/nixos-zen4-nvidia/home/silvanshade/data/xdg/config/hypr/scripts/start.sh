#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

HYPRLAND_INSTANCE_TMPDIR=/tmp/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/

recursive_kill() {
  local pid="$1"
  local and_self="${2:-false}"

  if children="$(pgrep -P "$pid")"; then
    for child in $children; do
      recursive_kill "$child" true
    done
  fi

  if [[ $and_self == true ]]; then
    timeout 3 kill -SIGTERM "$pid" || kill -SIGKILL "$pid"
  fi
}

cleanup() {
  rm -f "$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo
  recursive_kill $$
}
trap cleanup EXIT

wait_for_waybar() {
  rm -f "$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo # NOTE: Force remove any existing fifo first; shouldn't be needed, but just in case.
  mkfifo "$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo
  socat -u UNIX-CONNECT:"$HYPRLAND_INSTANCE_TMPDIR"/.socket2.sock - >"$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo &
  PID_SOCAT=$!
  while read -r line; do
    case "$line" in
    "openlayer>>waybar")
      kill -SIGTERM "$PID_SOCAT"
      break
      ;;
    *) ;;
    esac
  done <"$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo
  rm -f "$HYPRLAND_INSTANCE_TMPDIR"/.socket2.start.fifo
}

waybar &

"$(nix eval -f '<nixpkgs>' --raw 'polkit_gnome')"/libexec/polkit-gnome-authentication-agent-1 &
"$(nix eval -f '<nixpkgs>' --raw 'tracker-miners')"/libexec/tracker-miner-fs-3 &
dunst &

wait_for_waybar

1password --silent &
blueman-applet &
discord --start-minimized &
element-desktop --hidden &
nm-applet --indicator &
slack --startup &

copyq --start-server &

wait
