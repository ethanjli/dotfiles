_bash_plugins_bash-preexec_load() {
  unset -f "$0"

  local xdg_config_home="${XDG_CONFIG:-$HOME/.config}"
  local plugin="${xdg_config_home}/bash/plugins/bash-preexec"
  source "${plugin}/bash-preexec.sh"
}
_bash_plugins_bash-preexec_load
