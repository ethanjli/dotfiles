_zsh_integrations_ohmyposh() {
  unset -f "$0"

  if command -v oh-my-posh &> /dev/null; then
    local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
    local ohmyposh_configs="${xdg_config_home}/oh-my-posh"
    local theme="${ohmyposh_configs}/lutho.omp.toml"

    eval "$(oh-my-posh init bash --config "$theme")"
  fi
}
_zsh_integrations_ohmyposh
