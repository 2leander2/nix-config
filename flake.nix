{
    description = "NixOS with Hyprland (Flake)";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs =
        {
            self,
            nixpkgs,
            nixpkgs-unstable,
            home-manager,
            ...
        }@inputs:
        let
            system = "x86_64-linux";
            pkgs = nixpkgs.legacyPackages.${system};
            pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
        in
        {
            nixosConfigurations = {
                desktop = nixpkgs.lib.nixosSystem {
                    inherit system;
                    modules = [
                        ./hosts/desktop/configuration.nix
                    ];
                    specialArgs = {
                        inherit pkgs-unstable;
                    };
                };
            };

            homeConfigurations = {
                leanderk = home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home ];
                    extraSpecialArgs = {
                        inherit pkgs-unstable;
                        inherit inputs;
                    };
                };
            };
        };
}
