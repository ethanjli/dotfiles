#!/usr/bin/env bash

# Set up integrations
_sh_integrations() {
  unset -f "$0"

  local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local bash_configs="${xdg_config_home}/bash"
  local bash_integrations="${bash_configs}/integrations"
  local file
  for file in "$bash_integrations"/*.basic.sh; do
    source "$file"
  done

  for file in "$bash_integrations"/*.basic.bash; do
    source "$file"
  done
}
_sh_integrations
