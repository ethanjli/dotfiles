#!/usr/bin/env sh

if command -v cheat &> /dev/null && command -v fzf &> /dev/null; then
  export CHEAT_USE_FZF=true
fi
