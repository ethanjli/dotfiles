#!/usr/bin/env -S zsh -i
# This script allows the user to attach to an existing or new Zellij session; if the user chooses
# not to attach any Zellij session, it will instead start a login shell (chosen using $SHELL).

if command -v zellij &>/dev/null && [ "$ZELLIJ" = "" ]; then
  zellij_sessions=$(zellij list-sessions --short --reverse)
  num_sessions=$(echo "$zellij_sessions" | wc -l)
  if [ "$num_sessions" -eq 0 ] && gum confirm "Start a new Zellij session?"; then
    zellij attach -c
  else
    echo
    echo "  Attach to a Zellij session?"
    chosen_session=$(printf "(don't attach)\n(new session)\n%s" "$zellij_sessions" |
      GUM_FILTER_HEADER_FOREGROUND="007" gum filter --header='  Attach to a Zellij session?')
    if [[ "$chosen_session" == "(don't attach)" ]] || [[ "$chosen_session" == "" ]]; then
      "$SHELL" --login
    elif [[ "$chosen_session" == "(new session)" ]]; then
      zellij attach -c "$(gum input --placeholder "Name of new session")"
    else
      zellij attach "$chosen_session"
    fi
  fi
else
  echo "Couldn't find Zellij! Press Enter to continue:"
  read
fi
