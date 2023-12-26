#!/usr/bin/env bash

plugin_name="bash-preexec"
build() {
  return
}

# Boilerplate:
script_path="${0:A:h}"
source "$(dirname -- "$(readlink -f -- "$0")")/installer-utils.bash"
_install_from_bash_configs "$plugin_name" build
