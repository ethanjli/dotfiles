#!/bin/bash
# renumber_desktops.sh
# Written by Ethan Li, <lietk12@gmail.com>
# Summary: Renumbers all existing workspaces to be densely numbered in
# ascending order from 1 to n, where n is the total number of workspaces.

num_desktops=$(bspc query -D | wc -l)
desktops=($(bspc query -D))
for (( i=1; i<=${num_desktops}; ++i ))
do
  bspc desktop "^${i}" --rename ${i}
done
