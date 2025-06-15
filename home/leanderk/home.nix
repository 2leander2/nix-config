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
        imagemagick
        feh
        direnv
        nix-direnv
        gcc
        unityhub
        blender
        j4-dmenu-desktop
        vlc
        tree
        vulkan-tools
        networkmanagerapplet
        qbittorrent
        wireguard-tools
        openvpn
        unrar
        jq
        prismlauncher
        xorg.xlsclients
        protonup-qt
        bottles
        p7zip
        aria2
        file
        lutris
        libreoffice
        gedit
        xorg.xcursorthemes
        squashfsTools
        xorg.xcursorgen
        win2xcur
        pkgs-unstable.gimp3
        hackneyed
        quintom-cursor-theme
        oh-my-zsh
    ];

    # xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
    # home.file.".zshrc".source = ./zshrc;
}
