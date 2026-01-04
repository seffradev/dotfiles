{ pkgs, ... }: {
    home.packages = with pkgs; [
        vlc
    ];

    programs = {
        mpv = {
            enable = true;
            defaultProfiles = ["gpu-hq"];
            scripts = [pkgs.mpvScripts.mpris];
        };
    };
}
