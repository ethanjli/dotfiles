_zsh_plugins_zsh-autosuggestions_load() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/zsh/plugins/zsh-autosuggestions"
  source "${cached_plugin}/zsh-autosuggestions.zsh"
}
_zsh_plugins_zsh-autosuggestions_load
