{ ... }: {
  programs.git = {
    enable = true;
    userName = "Aaron Xheres Tan";
    userEmail = "aaron.xheres@gmail.com";

    delta = {
      enable = true;
      options = {
        navigate = true;
      };
    };

    extraConfig = {
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "master";
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        colorMoved = "default";
      };
    };
  };
}
