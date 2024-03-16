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

# NOTE: Start dunst as early as possible.
dunst &

# NOTE: Start waybar as early as possible, then wait until the hyprland notification socket reports it as a new layer.
waybar &

wait_for_waybar

1password --silent &
blueman-applet &
discord --start-minimized &
element-desktop --hidden &
heroic &
nm-applet --indicator &
slack --startup &
steam -silent &

# NOTE: copyq still seems to be somewhat unreliable on startup without a small delay.
sleep 5 && copyq --start-server &

wait
