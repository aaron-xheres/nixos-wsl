#!/usr/bin/env zsh

# Copy Directories
cdir_scripts="scripts"
cdir_nvim=".config/nvim"
dir_omz=".config/omz"

# Variables
copy_config=true
git_push=true
nixos_dir="/nixos"
commit_msg="update nixos-wsl"

# Usage
usage() {
  echo
  echo "Usage: $0 [options] [arguments]"
  echo
  echo "Options:"
  echo "  -c, --no-copy-config  Skip copy configurations from current home"
  echo "  -g, --no-git-push         Skip git push"
  echo "  -m, --message         Commit Message"
  echo "  -n, --nixos-dir       NixOS flake directory"
  echo
  echo "  -h, --help            Display this help"

  exit 1
}

# Parse options
zparseopts -D -E \
  {c,-no-copy-config}=_copy_config \
  {g,-no-git-push}=_git_push \
  {m,-message}:=_commit_msg \
  {n,-nixos-dir}:=_nixos_dir \
  {h,-help}=_help

# Handlers
# -h
if (( $#_help )); then
  usage
fi

# -c
if (( $#_copy_config )); then
  copy_config=false
fi

# -g
if (( $#_git_push )); then
  git_push=false
fi

# -m <args>
if [[ -n $_commit_msg ]]; then
  commit_msg=${_commit_msg[2]}
fi

# -n <args>
if [[ -n $_nixos_dir ]]; then
  nixos_dir=${_nixos_dir[2]}
fi

####################

# Display current args
echo
echo "Commit message: \"$commit_msg\""
echo "Git Push: $git_push"
echo "Copy configurations: $copy_config"
echo "NixOS directory: $nixos_dir"
echo
echo "--------------------"
echo

####################

# Directories
home_dir="$nixos_dir/home"
tmp_dir="/tmp/nixos_bak"
  
# cdir variable names
cdir_names=( ${(k)parameters[(I)cdir_*]} )

# Ensure that the directories has correct ownership and permissions
set_owner_permissions() {
  sudo chown -R $(id -un) $nixos_dir
  sudo chmod 755 $nixos_dir
}

####################

# Set ownsership and permission
set_owner_permissions

# Copy configurations
if [[ "$copy_config" = true ]]; then
  # Create a backup of current NixOS directory to /tmp
  sudo rm -rf "$tmp_dir"

  sudo mkdir -p "$tmp_dir/cdir"
  sudo cp -rfL $nixos_dir "$tmp_dir/nixos"

  for var in "${cdir_names[@]}"; do
    dir="${(P)var}"
    
    if [[ "$var" == "cdir_scripts" ]]; then
      # Scripts
      copy_to_dir="$home_dir"
    elif [[ "$var" == "cdir_nvim" ]]; then
      # Neovim
      copy_to_dir="$home_dir/nvim"
    elif [[ "$var" == "cdir_omz" ]]; then
      # Oh-my-zsh
      copy_to_dir="$home_dir/zsh"
    fi

      sudo cp -rf "$HOME/$dir" "$tmp_dir/cdir"
      sudo cp -rfL "$HOME/$dir" $copy_to_dir

    # Special Handling
    if [[ "$var" == "cdir_nvim" ]]; then
      sudo rm -rf "$home_dir/nvim/config"
      sudo mv "$home_dir/nvim/nvim" "$home_dir/nvim/config"
    fi
  done
fi

# Set ownsership and permissions again for copying linked configs
cd $nixos_dir
set_owner_permissions

# Build and switch NixOS
git add .
sudo nixos-rebuild switch --flake $nixos_dir

if [[ $? -eq 0 ]]; then
  if [[ "$git_push" = true ]]; then
    # Commit and Push if successful
    git commit -m "$commit_msg"
    git push

    if [[ $? -ne 0 ]]; then
      echo
      echo "Failed to git push"
    fi
  fi

  # Convert copied symlinks into regular files for editing
  cd "$HOME"
  for var in "${cdir_names[@]}"; do
    dir="${(P)var}"
    for file in $(find -type l | sed 's ..  ' | grep $dir); do
      sudo cp --remove-destination $(readlink $file) $file 
      sudo chown $(id -un) $file
      sudo chmod 755 $file
    done
  done

  # Remove tmp_dir
  sudo rm -rf $tmp_dir

else
  echo
  echo "Failed to build NixOS"

  if [[ "$copy_config" = true ]]; then
    # Revert to backup
    echo "Reverting to old configuration"
    sudo rm -rf $nixos_dir
    sudo cp -rf "$tmp_dir/nixos" $nixos_dir

    # Set ownership and permission back to user
    set_owner_permissions

    # Revert user config directories
    dir="${(P)var}"
    sudo cp -rf "$tmp_dir/cdir/.config" "$HOME/.config"
    sudo cp -rf "$tmp_dir/cdir/scripts" "$HOME/scripts"
  fi

  echo
  echo "Update failed"
  echo "--------------------"
  
  exit 1
fi

echo
echo
echo "Update complete"
echo "--------------------"
echo
