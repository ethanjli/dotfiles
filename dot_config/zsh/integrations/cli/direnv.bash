#!/usr/bin/env bash

if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi
