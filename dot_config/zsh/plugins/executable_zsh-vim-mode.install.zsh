#!/usr/bin/env zsh

plugin_name="zsh-vim-mode"
build() {
  local cached_plugin="$1"

  _zsh_compile ${cached_plugin}/zsh-vim-mode.plugin.zsh
}

# Boilerplate:
script_path="${0:A:h}"
source "${script_path}/installer-utils.zsh"
_install_from_zsh_configs "$plugin_name" build
