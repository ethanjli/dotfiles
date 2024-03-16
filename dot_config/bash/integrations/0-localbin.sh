_sh_integrations_util_among_paths() {
  local directory="$1"
  local paths="$2"
  [[ ":${paths}:" == *":${directory}:"* ]]
}

_sh_integrations_localbin_update_path() {
  unset -f "$0"
  local localbin_path="$HOME/.local/bin"
  if [ -d "$localbin_path" ] && ! _sh_integrations_util_among_paths "$localbin_path" "$PATH"; then
    export PATH="${localbin_path}:$PATH"
  fi
}
_sh_integrations_localbin_update_path

unset -f _sh_integrations_util_among_paths
