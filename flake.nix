{ 
  description = "WSL2 NixOS Configuration";

  inputs = {
    # NixOS
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    # Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, ... } @ inputs: let
    system = "x86_64-linux";
    username = "aaron-xheres";
    specialArgs = { inherit inputs; inherit username; };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        
        modules = [
          ./users/${username}/nixos

          nixos-wsl.nixosModules.default {
            system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = username;

            wsl.wslConf.interop.enable = true;
            wsl.interop.includePath = true;
          }

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = inputs // specialArgs;
            home-manager.users.${username} = import ./users/${username}/home;
          }
        ];
      };
    };
  };
} 
