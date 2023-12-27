_zsh_plugins_zsh-vim-mode_load() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/zsh/plugins/zsh-vim-mode"
  source "${cached_plugin}/zsh-vim-mode.plugin.zsh"
  bindkey -rpM viins '^[^[' # make <Esc><Esc> go to normal mode immediately
  bindkey -M viins "^[[3;5~" kill-word # make Ctrl+Delete work
  bindkey -M vicmd "^[[3;5~" kill-word # make Ctrl+Delete work
  MODE_CURSOR_VIINS='fg steady bar'
}
_zsh_plugins_zsh-vim-mode_load
