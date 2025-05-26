#!/usr/bin/env bash

# Usage: sudo ./install.sh <hostname> [--fresh]
#   <hostname>: your flakes host name (e.g. desktop)
#   --fresh: (optional) force fresh install mode (nixos-install)
#
# - If run as 'sudo ./install.sh desktop --fresh' it will use /mnt/etc/nixos and run nixos-install
# - If run as 'sudo ./install.sh desktop' it will use current dir and run nixos-rebuild

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

# Determine if we're on a live ISO (fresh install) or a running system
if $FRESH_MODE || [ -d "/mnt/etc/nixos" ]; then
  TARGET_DIR="/mnt/etc/nixos"
  echo "==> Detected fresh install mode (using $TARGET_DIR)"

  if [ ! -f "$TARGET_DIR/flake.nix" ]; then
    echo "Error: $TARGET_DIR does not contain flake.nix."
    echo "Clone your flake repo into $TARGET_DIR before running this script."
    exit 1
  fi

  echo "==> Enabling nix flakes and nix-command in installer environment"
  echo "experimental-features = nix-command flakes" >> /mnt/etc/nix/nix.conf

  echo "==> Running nixos-install with flake"
  nixos-install --flake "$TARGET_DIR#$HOSTNAME"

  echo "==> Installation finished! You can now reboot."
else
  TARGET_DIR="$(pwd)"
  echo "==> Detected running system mode (using $TARGET_DIR)"

  if [ ! -f "$TARGET_DIR/flake.nix" ]; then
    echo "Error: $TARGET_DIR does not contain flake.nix."
    echo "Run this script from your cloned flake repo directory."
    exit 1
  fi

  echo "==> Ensuring nix flakes and nix-command are enabled"
  if ! grep -q "nix-command" /etc/nix/nix.conf 2>/dev/null; then
    echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
  fi

  echo "==> Running nixos-rebuild switch with flake"
  nixos-rebuild switch --flake "$TARGET_DIR#$HOSTNAME"

  echo "==> System switched to new configuration!"
fi