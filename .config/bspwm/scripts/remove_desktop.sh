#!/bin/bash
# remove_desktop.sh
# Written by Ethan Li, <lietk12@gmail.com>
# Summary: Safely removes the current workspace.

# This kludgy script supports dynamic workspaces/desktops in bspwm for other programs
# that segfault upon removal of workspaces iff those workspaces aren't the last
# workspace. It expects that the workspaces be densely numbered in ascending order
# from 1 to n, where n is the total number of workspaces.
# Iff the current workspace is not empty, this script does nothing.
# Implementation summary: Let the current workspace be m. If m = n, workspace m is
# removed (because removing the nth workspace is safe for tint2). Otherwise, m < n
# and workspace m is swapped (in order) with workspaces m + 1 to n. This makes the
# workspace list 1,2,3...m-1,m+1,m+2,...,n-2,n-1,n,m, so that workspace m is now
# safe to remove.
# Multi-monitor support: the current workspace m is moved to the monitor containing
# workspace n if it's not already there; such an operation moves m to the end, so
# that it becomes already safe to remove; if m and n are on the same monitor, however,
# then m must be swapped with workspaces m+1,m+2,...,n-2,n-1,n

# Only try to remove the desktop if there are no windows left on it and it's not the
# last desktop of the current monitor.
if [[ $(bspc query -W -d focused | wc -l) == 0 && $(bspc query -D -m focused | wc -l) > 1 ]]; then
  current_desktop=$(bspc query -D -d focused)
  num_desktops=$(bspc query -D | wc -l)
  if [[ ${current_desktop} == ${num_desktops} ]]; then
    bspc desktop ${current_desktop} --remove
  else
    current_monitor=$(bspc query -M -m focused)
    last_monitor=$(bspc query -M | tail -n 1)
    if [[ ${current_monitor} != ${last_monitor} ]]; then
      # We'll move the current desktop onto the last monitor if it's not already there
      bspc desktop ${current_desktop} --to-monitor ${last_monitor}
    else
      # We'll swap the desktops so that the current desktop is actually the last desktop...bubblesort style.
      for (( i=$((${current_desktop} + 1)); i<=${num_desktops}; ++i )); do
        bspc desktop ${current_desktop} --swap ${i}
      done
    fi
    bspc desktop ${current_desktop} --remove
    ~/.config/bspwm/scripts/renumber_desktops.sh
  fi
fi
