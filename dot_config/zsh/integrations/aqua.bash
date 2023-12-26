if command -v aqua &> /dev/null; then
  aqua() { # lazy-load completions
    unset -f "$0"
    source <(aqua completion bash)
    $0 "$@"
  }
fi
