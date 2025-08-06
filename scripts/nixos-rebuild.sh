#!/usr/bin/env bash

# A rebuild script that commits on a successful build
set -e

# cd to your config dir
pushd ~/.config/nixos/
sudo echo "You're sudoed"
echo "NixOS Rebuilding..."


# Rebuild, output simplified errors, log trackebacks
sudo nixos-rebuild switch --flake .#$(hostname) &>.rebuild.log || (cat .rebuild.log | grep --color error && exit 1)

# Save dotfiles
echo "Chezmoi adding"
chezmoi re-add

# Back to where you were
popd

# Notify all OK!
echo "NixOS Rebuilt OK!" 
