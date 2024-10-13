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

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-wsl, home-manager, nix-ld, ... } @ inputs: let
    system = "x86_64-linux";
    username = "aaron-xheres";

    pkgs-unstable = import nixpkgs-unstable { 
      inherit system;
      config.allowUnfree = true;
    };

    specialArgs = { inherit inputs; inherit username; inherit pkgs-unstable; };
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
          
          nix-ld.nixosModules.nix-ld
        ];
      };
    };
  };
} 
