#!/bin/zsh
# remove_desktops.sh
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

# Only try to remove the desktop if there are no windows left on it
if [[ $(bspc query -W -d focused | wc -l) == 0 ]]; then
#	echo "Current desktop is empty, so we'll remove it" >> ~/bspwm.log
	current_desktop=$(bspc query -D -d focused)
	num_desktops=$(bspc query -D -m focused | wc -l)
#	echo "Current desktop is ${num_desktops} (out of ${num_desktops} total)" >> ~/bspwm.log
	
	if [[ ${current_desktop} != ${num_desktops} ]]; then
#		echo "Not the last desktop..." >> ~/bspwm.log
		# We'll swap the desktops so that the current desktop is actually the last desktop...bubblesort style.
	 	for i in {$(( ${current_desktop} ))..${num_desktops}}; do
#			echo "Swapping desktops..." >> ~/bspwm.log
			bspc desktop --swap ${i}
		done
	fi
	bspc desktop --remove
	~/.config/bspwm/scripts/renumber_desktops.sh
fi
