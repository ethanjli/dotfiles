command_not_found_handle() {
  # don't run if not in a container:
  if [ ! -e /run/.containerenv ] && [ ! -e /.dockerenv ]; then
    exit 127
  fi
  distrobox-host-exec "${@}"
}
