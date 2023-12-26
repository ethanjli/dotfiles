#!/usr/bin/env bash

if command -v atuin &> /dev/null; then
  eval "$(atuin init bash)"
fi
