#!/usr/bin/env zsh
# TODO: put these scripts somewhere else for modularity
export SDL_VIDEODRIVER=wayland
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway

exec sway --unsupported-gpu

# Launch sway in a systemd user scope
# exec dbus-run-session systemd-run --user --scope sway --unsupported-gpu