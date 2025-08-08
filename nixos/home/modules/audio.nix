{ pkgs, config, ... }: {
    home.packages = with pkgs; [
        pavucontrol
        playerctl
        pulsemixer
        spotify
    ];
    
    services = {
        playerctld.enable = true;
    };
}