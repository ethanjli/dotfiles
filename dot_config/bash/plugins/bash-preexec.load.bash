_bash_plugins_bash-preexec_load() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/bash/plugins/bash-preexec"
  source "${cached_plugin}/bash-preexec.sh"
}
_bash_plugins_bash-preexec_load
