#!/usr/bin/env sh

among_paths() {
  local directory="$1"
  local paths="$2"
  [[ ":${paths}:" == *":${directory}:"* ]]
}

_zsh_integrations_aqua_update_path() {
  local xdg_data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
  local aqua_path="${xdg_data_home}/aquaproj-aqua/bin"
  if [ -d "$aqua_path" ] && ! among_paths "$aqua_path" "$PATH"; then
    export PATH="${aqua_path}:$PATH"
  fi
}
_zsh_integrations_aqua_update_path
unset -f _zsh_integrations_aqua_update_path

_zsh_integrations_aqua_set_global_configs() {
  if command -v aqua &> /dev/null; then
    local xdg_config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
    local aqua_configs="${xdg_config_home}/aquaproj-aqua"
    local aqua_global_config="${aqua_configs}/aqua.yaml"
    if [ -f "$aqua_global_config" ] && ! among_paths "$aqua_global_config" "$AQUA_GLOBAL_CONFIG"; then
      export AQUA_GLOBAL_CONFIG="${aqua_global_config}:${AQUA_GLOBAL_CONFIG:-}"
    fi
    local aqua_policy_config="${aqua_configs}/aqua-policy.yaml"
    if [ -f "$aqua_policy_config" ] && ! among_paths "$aqua_policy_config" "$AQUA_POLICY_CONFIG"; then
      export AQUA_POLICY_CONFIG="${aqua_policy_config}:${AQUA_POLICY_CONFIG:-}"
    fi
  fi
}
_zsh_integrations_aqua_set_global_configs
unset -f _zsh_integrations_aqua_set_global_configs

unset -f among_paths
