# If not in a graphical session (i.e., in TTY), switch to bash
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
  exec bash
fi

