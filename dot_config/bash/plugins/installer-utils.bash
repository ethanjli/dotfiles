# _install_from_bash_configs will copy the specified plugin directory from ~/.config/bash/plugins to
# ~/.cache/bash/plugins if needed, and then invoke the builder command with the path of the
# cached plugin in ~/.cache/bash/plugins .
_install_from_bash_configs() {
  local plugin_name="$1"
  local builder="$2"

  local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local plugin="${xdg_config_home}/bash/plugins/${plugin_name}"
  if ! [[ -d "$plugin" ]]; then
    return
  fi
  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/bash/plugins/${plugin_name}"
  if [[ -d "$cached_plugin" ]]; then
    # TODO: only return if the cached copy isn't stale; if it's stale, delete it and proceed to rebuild
    return
  fi

  echo
  echo "Rebuilding cached plugin ${plugin_name}..."
  mkdir -p "$cached_plugin"
  cp -rT "$plugin" "$cached_plugin"
  "$builder" "$cached_plugin"
}
