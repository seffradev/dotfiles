{ pkgs, ... }: {
    home.packages = with pkgs; [
        davinci-resolve
        obs-studio
        inkscape
    ];
}
