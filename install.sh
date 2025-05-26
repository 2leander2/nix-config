#!/usr/bin/env bash

# Usage: sudo ./install.sh <hostname>
# Example: sudo ./install.sh desktop

set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root (e.g. sudo ./install.sh desktop)"
  exit 1
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 <hostname>"
  exit 1
fi

HOSTNAME="$1"
TARGET_DIR="/mnt/etc/nixos"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: $TARGET_DIR does not exist. Please clone your flake repo there first."
  exit 1
fi

echo "==> Enabling nix flakes and nix-command"
echo "experimental-features = nix-command flakes" >> /mnt/etc/nix/nix.conf

echo "==> Running nixos-install with flake"
nixos-install --flake "$TARGET_DIR#$HOSTNAME"

echo "==> Installation finished!"
echo "You can now reboot."