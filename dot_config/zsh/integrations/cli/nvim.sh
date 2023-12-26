# Note: this depends on an nvim_host_path env var to be set

_zsh_integrations_nvim() {
  unset -f "$0"
  if command -v "$nvim_host_path" &> /dev/null; then # nvim is provided by the host, so just use that
    local nvim_path="$nvim_host_path"
    alias nvim="$nvim_path" # we must use an alias, not a function, to properly capture the path everywhere
  elif command -v nvim &> /dev/null; then # fall back to nvim provided by aqua, which is broken on musl hosts
    local nvim_path="$(which nvim)"
  fi

  if command -v "$nvim_path" &> /dev/null; then # nvim is provided by any source
    export EDITOR="$nvim_path"
    export VISUAL="$EDITOR"
    alias vim=nvim
  elif command -v vim &> /dev/null; then # try to fall back to vim
    export EDITOR="$(which vim)"
    export VISUAL="$EDITOR"
  fi
}
_zsh_integrations_nvim
