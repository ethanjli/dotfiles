_zsh_plugins_zsh-syntax-highlighting_load() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/zsh/plugins/zsh-syntax-highlighting"
  source "${cached_plugin}/zsh-syntax-highlighting.zsh"
}
_zsh_plugins_zsh-syntax-highlighting_load
