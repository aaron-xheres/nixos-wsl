{
  description = "WSL2 NixOS Configuration";

  inputs = {
    # NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-ld
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-wsl,
      home-manager,
      nix-ld,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos-wsl =
          let
            system = "x86_64-linux";
            hostname = "nixos-wsl";
            username = "nixos";
            pkgs-unstable = import nixpkgs-unstable {
              inherit system;
              config.allowUnfree = true;
            };
            specialArgs = {
              inherit inputs;
              inherit hostname;
              inherit username;
              inherit nixpkgs;
              inherit pkgs-unstable;
            };
          in
          nixpkgs.lib.nixosSystem {
            inherit system;
            inherit specialArgs;

            modules = [
              ./system/wsl

              nixos-wsl.nixosModules.default
              {
                system.stateVersion = "24.05";
                wsl.enable = true;
                wsl.defaultUser = username;
              }

              home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = inputs // specialArgs;
                home-manager.users.${username} = import ./home;
              }

              nix-ld.nixosModules.nix-ld
            ];
          };
      };
    };
}
