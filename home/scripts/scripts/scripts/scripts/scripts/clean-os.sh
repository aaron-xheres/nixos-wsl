#!/usr/bin/env zsh

# Variables
nixos_dir="/nixos"

# Usage
usage() {
  echo
  echo "Usage: $0 [options] [arguments]"
  echo
  echo "Options:"
  echo "  -n, --nixos-dir       NixOS flake directory"
  echo
  echo "  -h, --help            Display this help"

  exit 1
}

# Parse options
zparseopts -D -E \
  {n,-nixos-dir}:=_nixos_dir \
  {h,-help}=_help

# Handlers
# -h
if (( $#_help )); then
  usage
fi

# -n <args>
if [[ -n $_nixos_dir ]]; then
  nixos_dir=${_nixos_dir[2]}
fi

####################

# Display current args
echo
echo "NixOS directory: $nixos_dir"
echo
echo "--------------------"
echo

####################

# Dry-activate to ensure that current build works
sudo nixos-rebuild dry-activate --flake $nixos_dir

# Collect Garbage and clear boot records
if [[ $? -eq 0 ]]; then
  sudo nix-collect-garbage -d
  sudo /run/current-system/bin/switch-to-configuration boot

else
  echo "Failed to dry build current configuration"
  echo "--------------------"

  exit 1
fi

echo
echo "Clean OS complete"
echo "--------------------"
echo
