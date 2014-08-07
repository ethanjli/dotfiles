#!/bin/zsh
# add_desktop.sh
# Written by Ethan Li, <lietk12@gmail.com>
# Summary: Adds a workspace.

# This script supports dynamic workspaces/desktops in bspwm.
# It expects that all existing workspaces be densely numbered in ascending
# order from 1 to n, where n is the total number of existing workspaces.
# Implementation summary: Let the current workspaces list be 1,2,3...n-1,n.
# Then we'll add workspace n+1.

bspc monitor --add-desktops $(( $(bspc query -D -m focused | wc -l) + 1 ))
