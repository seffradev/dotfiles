{ config, pkgs, ... }: {
    imports = [
        ../../modules/programs/1password.nix
        ../../modules/programs/wireshark.nix
        ../../modules/audio.nix
        ../../modules/locale/fonts.nix
        ../../modules/layout/us-mac.nix
        ../../modules/locale/sv_SE.nix
        ../../modules/networking.nix
        ../../modules/security.nix
        ../../modules/ssh.nix
        ../../modules/system.nix
        ../../modules/hardware/bluetooth.nix
        ../../modules/systemd.nix
        ../../modules/locale/timezone/europe/stockholm.nix
        ../../modules/vim/plugins.nix
        ../../modules/virtualization/docker.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "tpt14-g3";

    system.stateVersion = "25.05";
}
