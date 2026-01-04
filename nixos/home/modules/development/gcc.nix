{ pkgs, ... }: {
    home.packages = with pkgs; [
        gcc15
        gnumake
    ];
}
