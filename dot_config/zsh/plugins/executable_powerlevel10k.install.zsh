#!/usr/bin/env zsh

plugin_name="powerlevel10k"
build() {
  local cached_plugin="$1"

  make -C "$cached_plugin" pkg
}

# Boilerplate:
script_path="${0:A:h}"
source "${script_path}/installer-utils.zsh"
_install_from_zsh_configs "$plugin_name" build
