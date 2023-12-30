if command -v nvim &> /dev/null; then # nvim is provided by the host, so just use that
  export EDITOR="$(which nvim)"
  alias vim="$EDITOR"
elif command -v neovim &> /dev/null; then # try to fall back to neovim provided by aqua, which is broken on musl hosts
  export EDITOR="$(which neovim)"
  alias nvim="$EDITOR"
  alias vim="$EDITOR"
elif command -v vim &> /dev/null; then # try to fall back to vim
  export EDITOR="$(which vim)"
fi
export VISUAL="$EDITOR"
