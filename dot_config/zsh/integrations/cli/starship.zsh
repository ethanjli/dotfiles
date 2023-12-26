#!/usr/bin/env zsh

if [ $commands[starship] ]; then
  eval "$(starship init zsh)"
fi
