{
    description = "NixOS with Hyprland (Flake)";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/25.05";
        hyprland.url = "github:hyprwm/Hyprland/v0.49.0";
    };

    outputs =
        { nixpkgs, ... }@inputs:
        {
            nixosConfigurations = {
                desktop = nixpkgs.lib.nixosSystem {
                    specialArgs = { inherit inputs; };
                    modules = [
                        ./hosts/desktop/configuration.nix
                    ];
                };
            };
        };
}
