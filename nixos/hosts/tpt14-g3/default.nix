{ config, pkgs, ... }: {
    imports = [
        ../../modules/1password.nix
        ../../modules/audio.nix
        ../../modules/fonts.nix
        ../../modules/layout/us-mac.nix
        ../../modules/locale/sv_SE.nix
        ../../modules/networking.nix
        ../../modules/security.nix
        ../../modules/ssh.nix
        ../../modules/system.nix
        ../../modules/systemd.nix
        ../../modules/timezone/europe/stockholm.nix
        ../../modules/vim-plugins.nix
        ../../modules/virtualization.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "tpt14-g3";

    system.stateVersion = "25.05";
}
