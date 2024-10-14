{ config, ... }: {
  home.file.".config/omz" = {
    source = ./omz;
    recursive = true;
  };

  programs.zsh = {
    enable = true;
    
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      export WINDOWS=/mnt/c
      export WINDOWS_HOME=/mnt/c/Users/$(powershell.exe -noninteractive -command "[Environment]::UserName" | sed -e "s/\r//g")
    '';

    shellAliases = {
      # Windows Commands
      winget = "winget.exe";

      # Scripts
      update-os = "$HOME/scripts/update-os.sh";
      clean-os = "$HOME/scripts/clean-os.sh";

      # Neovim
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";

      # ls
      lla = "eza -llah --group-directories-first";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.config/omz";
      theme = "themes/classyTouch";
      plugins = [ "git" "gh" "sudo" "eza" "fzf" ];
    };
  };
}
