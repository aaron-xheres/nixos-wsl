{ pkgs, lib, hostname, username, ... }: {
  imports = [
    ./system-packages.nix
  ];

  networking.hostName = hostname;
  users.users.${username} = {
    isNormalUser = true;
    description = username;
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
