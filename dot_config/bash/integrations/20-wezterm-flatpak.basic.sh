if [[ ! -z "$WAYLAND_DISPLAY" ]]; then
  display="$(basename "$WAYLAND_DISPLAY")"
  if [[ -S "${XDG_RUNTIME_DIR}/$display" ]]; then
    export WAYLAND_DISPLAY="$display"
  elif [ command -v dbus-launch ]; then
    export "$(dbus-launch)"
  fi
fi
