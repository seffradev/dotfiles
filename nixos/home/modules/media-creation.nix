{ pkgs, ... }: {
    home.packages = with pkgs; [
        audacity
        davinci-resolve
        obs-studio
    ];
}