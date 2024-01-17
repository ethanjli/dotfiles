_sh_integrations_util_among_paths() {
  local directory="$1"
  local paths="$2"
  [[ ":${paths}:" == *":${directory}:"* ]]
}

_sh_integrations_pyenv_update_path() {
  unset -f "$0"
  local pyenv_bin_path="${PYENV_ROOT}/bin"
  if [ -d "$pyenv_bin_path" ] && ! _sh_integrations_util_among_paths "$pyenv_bin_path" "$PATH"; then
    export PATH="${pyenv_bin_path}:$PATH"
  fi
}

if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
fi
_sh_integrations_pyenv_update_path

if command -v pyenv &> /dev/null; then
  eval "$(pyenv init -)"
fi
