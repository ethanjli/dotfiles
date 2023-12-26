#!/usr/bin/env zsh

if command -v aqua &> /dev/null; then
  aqua() { # lazy-load completions
    unset -f "$0"
    source <(aqua completion zsh)
    $0 "$@"
  }
fi
