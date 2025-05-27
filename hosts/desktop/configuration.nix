{ inputs, pkgs, ... }:

{
    imports = [
        /etc/nixos/hardware-configuration.nix
    ];

    networking.hostName = "desktop";

    nix.settings = {
        substituters = [
            "https://cache.nixos.org/"
            "https://nix-gaming.cachix.org"
        ];
        trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        ];
    };

    # Disable for dual boot
    services.vmwareGuest.enable = true;

    programs.hyprland.enable = true;

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
        git
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    users.users.leanderk = {
        isNormalUser = true;
        extraGroups = [
            "wheel"
            "networkmanager"
        ];
        description = "Leander Kroth";
    };

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

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "25.05";
}
