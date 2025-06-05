{
  description = "NixOS with Hyprland (Flake)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        (import ./pkgs/gpu-screen-recorder-ui)
      ];
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        desktop-nvidia = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
            })
            lanzaboote.nixosModules.lanzaboote
            ./modules/gpu-screen-recorder-ui.nix
            ./hosts/desktop-nvidia/configuration.nix
          ];
          specialArgs = {
            inherit pkgs-unstable;
          };
        };
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ({ config, pkgs, ... }: {
              nixpkgs.overlays = overlays;
              nixpkgs.config.allowUnfree = true;
            })
            ./hosts/wsl/configuration.nix
          ];
          specialArgs = {
            inherit pkgs-unstable;
          };
        };
      };
      homeConfigurations = {
        leanderk = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/leanderk/home.nix ];
          extraSpecialArgs = {
            inherit pkgs-unstable;
            inherit inputs;
          };
        };
      };
    };
}