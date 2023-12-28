if command -v s &> /dev/null; then
  source <(s --completion bash)
  alias sw="s --provider wikipedia"
  alias sp="s --provider"
fi
