{ pkgs, pkgs-unstable, lib, username, ... }: {
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
    #file."scripts" = {
    #  source = ./scripts;
    #  recursive = true;
    #  executable = true;
    #};

    # Activations
    activation = {
      # Rustup
      rustup_rustc = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs-unstable.rustup}/bin/rustup default stable
      '';
      rustup_rust-analyzer = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs-unstable.rustup}/bin/rustup component add rust-analyzer
      '';
      rustup_rustfmt = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs-unstable.rustup}/bin/rustup component add rustfmt
      '';
      rustup_clippy = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs-unstable.rustup}/bin/rustup component add clippy
      '';
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

    # Nix Related
    pkgs-unstable.nixfmt-rfc-style

    # Rust
    pkgs-unstable.rustup

    # Mason LSP Installs
    nodejs_22
  ];
}
