#!/usr/bin/env zsh

if [ $commands[direnv] ]; then
  eval "$(direnv hook zsh)"
fi
