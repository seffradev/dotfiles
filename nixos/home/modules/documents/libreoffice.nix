{ pkgs, ... }: {
    home.packages = with pkgs; [
        libreoffice-qt
        hunspell
        hunspellDicts.en_US
        hunspellDicts.sv_SE
    ];
}