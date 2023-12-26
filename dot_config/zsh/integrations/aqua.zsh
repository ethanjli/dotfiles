#!/usr/bin/env zsh

if [ $commands[aqua] ]; then
  aqua() { # lazy-load completions
    unfunction "$0"
    source <(aqua completion zsh)
    $0 "$@"
  }
fi
