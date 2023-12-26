#!/usr/bin/env zsh

if command -v direnv &> /dev/null; then
  eval "$(direnv hook zsh)"
fi
