#!/usr/bin/env bash

USERNAME=$(whoami)

echo "Switching home configuration..."
nix run .#homeConfigurations.$USERNAME.activationPackage