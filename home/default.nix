{ pkgs, pkgs-unstable, username, ... }: {
  # Enable Home Manager
  programs.home-manager.enable = true;

  # Specific Program Imports
  imports = [
     ./shell
     ./nvim
     ./git.nix
  ];

  # Home Configuration
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    # Copy Scripts
    file."scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };

    stateVersion = "24.05";
  };

  # direnv
  programs.direnv = {
    enable = true;
  };

  # Programs
  home.packages = with pkgs; [
    # Archives
    p7zip
    unzip

    # Utilities
    ripgrep
    tree
    jq
    eza

    # Productivity
    gh
    nnn
    lazygit
    glow

    # System
    htop
    btop

    # Build
    gnumake
    gcc

    # Project Management
    pkgs-unstable.devenv

    # Mason LSP Installs
    rust-bin.stable.latest.default
    nodejs-slim
  ];
}
