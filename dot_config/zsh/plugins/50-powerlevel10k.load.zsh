_zsh_plugins_powerlevel10k_load() {
  unset -f "$0"

  local xdg_cache_home="${XDG_CACHE_HOME:-$HOME/.cache}"
  local cached_plugin="${xdg_cache_home}/zsh/plugins/powerlevel10k"
  source "${cached_plugin}/powerlevel10k.zsh-theme"

  local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
  local zsh_configs="${xdg_config_home}/zsh"
  if [[ -f "${zsh_configs}/p10k.zsh" ]]; then
    source "${zsh_configs}/p10k.zsh"
  fi
}
_zsh_plugins_powerlevel10k_load
