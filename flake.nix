{
    description = "NixOS with Hyprland (Flake)";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        hyprland.url = "github:hyprwm/Hyprland";
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
