{ pkgs, lib, username, ... }: {
  imports = [
    ./system-packages.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = "Aaron Xheres Tan";
    extraGroups = [ "wheel" ];

    shell = pkgs.zsh;
  };

  nix.settings.trusted-users = [ username ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_SG.UTF-8";
}
