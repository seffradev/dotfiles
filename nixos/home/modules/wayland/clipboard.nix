{ username, pkgs, ... }: {
    home.packages = with pkgs; [
        wl-clipboard
    ];
}