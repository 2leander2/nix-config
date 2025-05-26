{ inputs, pkgs, ... }:

let
    pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
    imports = [
        /etc/nixos/hardware-configuration.nix
    ];

    networking.hostName = "desktop";

    nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    hardware.graphics = {
        package = pkgs-unstable.mesa;
        package32 = pkgs-unstable.pkgsi686Linux.mesa;
    };

    users.users.leanderk = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
        description = "Leander Kroth";
        packages = with pkgs; [
            kitty
            firefox
        ];
    };

    environment.systemPackages = with pkgs; [
        git
    ];

    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };
    security.rtkit.enable = true;
    services.pulseaudio.enable = false;

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.05";
}
