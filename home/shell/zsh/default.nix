{ ... }: {
  home.file.".config/zsh/omz" = {
    source = ./omz;
    recursive = true;
  };

  home.file.".config/zsh/sources" = {
    source = ./sources;
    recursive = true;
  };
  
  programs.fd.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      export WINDOWS=/mnt/c
      export WINDOWS_HOME=/mnt/c/Users/$(powershell.exe -noninteractive -command "[Environment]::UserName" | sed -e "s/\r//g")
    '';

    initExtra = ''
      # -- FZF
      export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
      export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

      _fzf_compgen_path() {
        fd --hidden --exclude .git . "$1"
      }

      _fzf_compgen_dir() {
        fd --type=d --hidden --exclude .git . "$1"
      }

      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)             fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
          export|unset)   fzf --preview "eval 'echo \$' {}" "$@"  ;;
          ssh)            fzf --preview "dig {}" "$@" ;;
          *)              fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
        esac
      }

      # -- Sources
      source ~/.config/zsh/sources/fzf-git.sh
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
      ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
      lla = "eza -llah --group-directories-first";

      # cat
      cat = "bat";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      custom = "$HOME/.config/zsh/omz";
      theme = "themes/classyTouch";
      plugins = [ "git" "gh" "sudo" "eza" "fzf" "direnv" ];
    };
  };
}
