{ ... }: {
  home.file.".config/direnv/direnvrc".source = ./direnvrc;

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
