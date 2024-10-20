{ pkgs-unstable, config, ... }: {
  # Split configs into individual directories to prevent symlinking the entire directory
  # This will allow lazy-lock to be created and not get error messages
  home.file.".config/nvim/init.lua".source = config.lib.file.mkOutOfStoreSymlink ./config/init.lua;
  home.file.".config/nvim/lua/lazyvim.lua".source = config.lib.file.mkOutOfStoreSymlink ./config/lua/lazyvim.lua;
  home.file.".config/nvim/lua/core" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config/lua/core;
    recursive = true;
  };
  home.file.".config/nvim/lua/plugins" = {
    source =  config.lib.file.mkOutOfStoreSymlink ./config/lua/plugins;
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

  # Formatter Config
  home.file.".config/rustfmt/rustfmt.toml".source = config.lib.file.mkOutOfStoreSymlink ./fmt-config/rustfmt.toml;
}
