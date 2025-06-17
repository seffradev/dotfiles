{ lib, pkgs, username, ...
}: {
    home.packages = with pkgs; [
        keymapp
        pcloud
        spotify
        termshark
        typst
        wireshark
    ];

    programs = {};

    services = {};
}
