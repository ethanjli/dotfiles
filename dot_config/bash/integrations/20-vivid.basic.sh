if command -v vivid &> /dev/null ; then
  export LS_COLORS="$(vivid generate one-dark)"
fi
