#!/usr/bin/env bash

# Retrive PID if inhibition runs:
pid=$(systemd-inhibit --list | grep "i3BlockManualInhibition" | awk '{print $5}')

# Do something only if left click on block.
# Avoid script running at i3 (re)start.
# FYI, 2 = middle click, 3 = right click.
if [[ "$BLOCK_BUTTON" != "1" ]]; then
  if [[ -z "$pid" ]]; then
    echo "🔒"
  else
    echo "🔓"
  fi
  exit 0
fi

# Empty pid, so locking:
if [[ -z "$pid" ]]; then
  tmux -v new-session -d -s i3block-inhibit-idle 'systemd-inhibit --why=i3BlockManualInhibition --what=idle sleep infinity'
  echo "🔓"
  exit 0
fi

tmux kill-session -t i3block-inhibit-idle
echo "🔒"
exit 0
