if command -v bat &> /dev/null; then
  export MANROFFOPT="-c"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
  export PAGER="$HOME/.local/bin/batpager.sh"
fi
