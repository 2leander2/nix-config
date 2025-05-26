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

    home.packages = with pkgs; [
        firefox
        neovim
        git
        zsh
        kitty
    ];
}
