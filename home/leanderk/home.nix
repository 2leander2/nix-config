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

    programs.hyprland.enable = true;

    home.packages = with pkgs; [
        firefox
        neovim
        zsh
        kitty
    ];

    xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
