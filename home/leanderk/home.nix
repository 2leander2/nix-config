{
    config,
    pkgs,
    pkgs-unstable,
    lib,
    inputs,
    ...
}:

{
    home.username = "leanderk";
    home.homeDirectory = "/home/leanderk";
    home.stateVersion = "25.05";

    wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
    };

    home.packages = with pkgs; [
        terminator
        xterm
        alacritty
        firefox
        neovim
        zsh
    ];

    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
