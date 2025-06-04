{
    config,
    pkgs,
    pkgs-unstable,
    lib,
    inputs,
    ...
}:
let
    myToybox = pkgs.toybox.overrideAttrs (old: {
        postInstall = ''
            rm $out/bin/readelf
            rm $out/bin/strings
        '';
    });
in
{
    home.username = "leanderk";
    home.homeDirectory = "/home/leanderk";
    home.stateVersion = "25.05";

    programs.obs-studio = {
        enable = true;
        package = pkgs.obs-studio.override {
            cudaSupport = true;
        };
    };

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
        myToybox
        waybar
        eww
        nerd-fonts._3270
        nerd-fonts.geist-mono
        nerd-fonts.terminess-ttf
        fira-mono
        htop
        atop
        nchat
        xfce.thunar
        xfce.thunar-volman
        xfce.thunar-archive-plugin
        gvfs
        baobab
        nextcloud-client
        discord
        betterdiscordctl
        wl-color-picker
        direnv
        nix-direnv
        gcc
        unityhub
        blender
        j4-dmenu-desktop
        vlc
        tree
    ];

    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".zshrc".source = ./zshrc;
}
