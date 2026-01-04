{ pkgs, ... }: {
    home.packages = with pkgs; [
        pcloud
    ];
}