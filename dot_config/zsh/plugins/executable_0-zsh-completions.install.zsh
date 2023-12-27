#!/usr/bin/env zsh

plugin_name="zsh-completions"
build() {
}

# Boilerplate:
script_path="${0:A:h}"
source "${script_path}/installer-utils.zsh"
_install_from_zsh_configs "$plugin_name" build
