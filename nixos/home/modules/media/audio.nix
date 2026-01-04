{ pkgs, config, ... }: {
    home.packages = with pkgs; [
        amberol
        pavucontrol
        picard
        playerctl
        pulsemixer
        spotify
    ];

    services = {
        playerctld.enable = true;
    };
}
