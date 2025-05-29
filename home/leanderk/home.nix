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
        nnn
        flameshot
        steamcmd
        polychromatic
        steam-tui
        github-desktop
        google-chrome
        bitwarden-desktop
        xcur2png
        unzip
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
        fira-mono
    ];

# https://google.de
    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".zshrc".source = ./zshrc;
}
