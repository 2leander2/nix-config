{ inputs, lib, pkgs, config, ... }:

{
    imports = [
        <nixos-wsl/modules>
    ];

    wsl.enable = true;
    wsl.defaultUser = "nixos";

    networking.hostName = "wsl";

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

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };
    programs.zsh.enable = true;
    programs.gpu-screen-recorder-ui.enable = true;

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    environment.systemPackages = with pkgs; [
        cage
        sbctl
        efibootmgr
        grim
        slurp
        wl-clipboard
        mako
        git
        wineWowPackages.stable
        wineWowPackages.waylandFull
        mangohud
    ];

    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
        localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };

    nixpkgs.config.allowUnfree = true;
    hardware.graphics = {
        enable = true;
    };
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;

        open = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
                user = "greeter";
            };
        };
    };
    services.gvfs.enable = true;

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

    services.gnome.gnome-keyring.enable = true;

    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";

    system.stateVersion = "25.05";
}