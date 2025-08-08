{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        rofi-wayland
        rofimoji
    ];

    home.file = {
        "${config.xdg.configHome}/rofi/config.rasi".source = ./config.rasi;
        "${config.xdg.dataHome}/rofi" = {
            source = ./rofi-themes;
            recursive = true;
        };
    };
}