if [[ ! -z "$WAYLAND_DISPLAY" ]]; then
  display="$(basename "$WAYLAND_DISPLAY")"
  if [[ -S "${XDG_RUNTIME_DIR}/$display" ]]; then
    export WAYLAND_DISPLAY="$display"
  fi
fi
