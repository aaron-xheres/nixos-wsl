{
  imports = [
    ./zsh
    ./tmux.nix
    ./fzf.nix
    ./bat.nix
  ];

  programs.zoxide.enable = true;
}
