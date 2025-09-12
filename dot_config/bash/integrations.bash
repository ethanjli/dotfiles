#!/usr/bin/env bash

# Set up integrations
_bash_integrations() {
  unset -f "$0"
  local reset_nullglob="$(shopt -p nullglob)"
  shopt -s nullglob # suppress errors when for loops have no matching files

  local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local bash_configs="${xdg_config_home}/bash"
  local bash_integrations="${bash_configs}/integrations"
  local file
  for file in "$bash_integrations"/*.sh; do
    source "$file"
  done

  for file in "$bash_integrations"/*.bash; do
    source "$file"
  done

  $reset_nullglob
}
_bash_integrations
