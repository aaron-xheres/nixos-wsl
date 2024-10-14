{ pkgs-unstable, ... }: {
  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}
