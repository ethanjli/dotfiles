_zsh_plugins_zsh-completions_add() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/zsh/plugins/zsh-completions"
  export fpath=("${cached_plugin}/src" $fpath)
}
_zsh_plugins_zsh-completions_add
