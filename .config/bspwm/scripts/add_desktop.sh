#!/bin/bash
# add_desktop.sh
# Written by Ethan Li, <lietk12@gmail.com>
# Summary: Adds a workspace.

# This script supports dynamic workspaces/desktops in bspwm.
# It expects that all existing workspaces be densely numbered in ascending
# order from 1 to n, where n is the total number of existing workspaces.
# Implementation summary: Let the current workspaces list be 1,2,3...n-1,n.
# Then we'll add workspace n+1.
# Multi-monitor support: the new workspace is added to the monitor containing
# workspace n, then it is swapped until it is on the current monitor.

new_workspace=$(( $(bspc query -D | wc -l) + 1 ))
current_monitor=$(bspc query -M -m focused)
last_monitor=$(bspc query -M | tail -n 1)
bspc monitor ${last_monitor} --add-desktops ${new_workspace}
bspc desktop ${new_workspace} --to-monitor ${current_monitor}
# Renumber the desktops (this is necessary to maintain proper numbering
# order in multihead setups)
~/.config/bspwm/scripts/renumber_desktops.sh
