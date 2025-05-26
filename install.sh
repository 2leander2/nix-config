#!/usr/bin/env bash

# Usage: sudo ./install.sh <hostname> [--fresh]
# Example: sudo ./install.sh desktop
# Example (force fresh install): sudo ./install.sh desktop --fresh

set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root (e.g. sudo ./install.sh desktop)"
  exit 1
fi

if [ $# -lt 1 ]; then
  echo "Usage: $0 <hostname> [--fresh]"
  exit 1
fi

HOSTNAME="$1"
FRESH_MODE=false
if [ "${2:-}" = "--fresh" ]; then
  FRESH_MODE=true
fi

# Helper to check if flakes are enabled
flakes_enabled() {
  local conf_file="$1"
  [ -f "$conf_file" ] && grep -q "nix-command" "$conf_file" && grep -q "flakes" "$conf_file"
}

# Helper to try enabling flakes
enable_flakes() {
  local conf_file="$1"
  if [ -w "$conf_file" ]; then
    if ! flakes_enabled "$conf_file"; then
      echo "experimental-features = nix-command flakes" >> "$conf_file"
      echo "==> Enabled flakes and nix-command in $conf_file"
    fi
  else
    echo "WARNING: $conf_file is not writable! Skipping flakes enable."
    return 1
  fi
  return 0
}

# Fresh install path
if $FRESH_MODE || [ -d "/mnt/etc/nixos" ]; then
  TARGET_DIR="/mnt/etc/nixos"
  CONF_FILE="/mnt/etc/nix/nix.conf"
  echo "==> Detected fresh install mode (using $TARGET_DIR)"
  if [ ! -f "$TARGET_DIR/flake.nix" ]; then
    echo "Error: $TARGET_DIR does not contain flake.nix."
    echo "Clone your flake repo into $TARGET_DIR before running this script."
    exit 1
  fi
  if ! flakes_enabled "$CONF_FILE"; then
    enable_flakes "$CONF_FILE" || {
      echo "==> You must manually enable flakes before running nixos-install."
      echo "Try: sudo sh -c 'echo \"experimental-features = nix-command flakes\" >> $CONF_FILE'"
      exit 1
    }
  fi
  echo "==> Running nixos-install with flake"
  nixos-install --flake "$TARGET_DIR#$HOSTNAME"
  echo "==> Installation finished! You can now reboot."
else
  TARGET_DIR="$(pwd)"
  CONF_FILE="/etc/nix/nix.conf"
  echo "==> Detected running system mode (using $TARGET_DIR)"
  if [ ! -f "$TARGET_DIR/flake.nix" ]; then
    echo "Error: $TARGET_DIR does not contain flake.nix."
    echo "Run this script from your cloned flake repo directory."
    exit 1
  fi
  if ! flakes_enabled "$CONF_FILE"; then
    if enable_flakes "$CONF_FILE"; then
      FLAKE_CMD="sudo nixos-rebuild switch --flake \"$TARGET_DIR#$HOSTNAME\""
    else
      echo "WARNING: $CONF_FILE is not writable. Will use temporary environment for flakes."
      FLAKE_CMD="sudo NIX_CONFIG=\"experimental-features = nix-command flakes\" nixos-rebuild switch --flake \"$TARGET_DIR#$HOSTNAME\""
    fi
  else
    FLAKE_CMD="sudo nixos-rebuild switch --flake \"$TARGET_DIR#$HOSTNAME\""
  fi
  echo "==> Running: $FLAKE_CMD"
  eval $FLAKE_CMD
  echo "==> System switched to new configuration!"
fi