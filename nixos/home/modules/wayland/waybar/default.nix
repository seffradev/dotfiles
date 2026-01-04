{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        waybar
    ];

    home.file = {
        "${config.xdg.configHome}/waybar/config.jsonc".source = ./config.jsonc;
        "${config.xdg.configHome}/waybar/style.css".source = ./style.css;
    };
}