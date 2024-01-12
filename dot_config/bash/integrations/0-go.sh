_sh_integrations_util_among_paths() {
  local directory="$1"
  local paths="$2"
  [[ ":${paths}:" == *":${directory}:"* ]]
}

_sh_integrations_go_update_path() {
  unset -f "$0"
  local go_bin_path="${GOPATH:-$HOME/go}/bin"
  if [ -d "$go_bin_path" ] && ! _sh_integrations_util_among_paths "$go_bin_path" "$PATH"; then
    export PATH="${go_bin_path}:$PATH"
  fi
}
_sh_integrations_go_update_path

unset -f _sh_integrations_util_among_paths
