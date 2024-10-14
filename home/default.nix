{ pkgs, username, ... }: {
  # Enable Home Manager
  programs.home-manager.enable = true;

  # Specific Program Imports
  imports = [
     ./shell
     ./nvim
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

  # Defalt Git Configurations
  ## To move to individual import if config gets larger
  programs.git = {
    enable = true;
    userName = "Aaron Xheres Tan";
    userEmail = "aaron.xheres@gmail.com";
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

    pkgs.rust-bin.stable.latest.default # Rust
  ];
}
