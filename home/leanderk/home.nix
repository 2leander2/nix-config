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
        github-desktop
        bitwarden-desktop
        xcur2png
        unzip
        zip
        wofi
        discordo
        spotify-player
        nwg-displays
        nixfmt-rfc-style
        nil
        xterm
        vscode
        alacritty
        firefox
        neovim
        toybox
        eww
    ];

    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".zshrc".source = ./zshrc;
}
