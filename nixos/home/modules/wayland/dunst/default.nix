{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        dunst
    ];

    home.file = {
        "${config.xdg.configHome}/dunst/dunstrc".source = ./dunstrc;
    };
}