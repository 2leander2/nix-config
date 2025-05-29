#!/usr/bin/env bash

set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <hostname>"
  exit 1
fi

HOSTNAME="$1"
echo "Switching system configuration using flake..."
sudo nixos-rebuild switch --flake ".#${HOSTNAME}" --impure