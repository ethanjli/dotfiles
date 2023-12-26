#!/usr/bin/env zsh

if command -v aqua &> /dev/null; then
  aqua() { # lazy-load completions
    unset -f "$0"
    source <(aqua completion zsh)
    $0 "$@"
  }
  # This may be slow, but we can afford to wait because we're using powerlevel10k:
  aqua i -a
fi
