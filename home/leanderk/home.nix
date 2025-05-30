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
        fontforge-gtk
        lcdf-typetools
        xorg.fonttosfnt
        bdfresize
        xlsfonts
        steamcmd
        polychromatic
        steam-tui
        github-desktop
        google-chrome
        bitwarden-desktop
        sway-contrib.grimshot
        xcur2png
        unzip
        razer-cli
        zip
        wofi
        vesktop
        pamixer
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
        waybar
        eww
        nerd-fonts._3270
        nerd-fonts.geist-mono
        nerd-fonts.terminess-ttf
        fira-mono
    ];

# https://google.de
    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".zshrc".source = ./zshrc;
}
