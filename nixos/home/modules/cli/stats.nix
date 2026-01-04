{ pkgs, ... }: {
    home.packages = with pkgs; [
        btop
        cloc
    ];
}
