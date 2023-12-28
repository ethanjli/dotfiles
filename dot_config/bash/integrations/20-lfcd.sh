if command -v lf &> /dev/null; then
  lfcd() {
    local result=$(command lf -print-last-dir "$@")
    [ -n "$result" ] && cd -- "$result"
  }
fi
