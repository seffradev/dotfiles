{ pkgs, ... }: {
    home.packages = with pkgs; [
        rfc
        man
    ];
}
