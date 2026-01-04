{ config, pkgs, ... }: {
    imports = [
        ../../modules/audio.nix
        ../../modules/environment/link-paths.nix
        ../../modules/hardware/bluetooth.nix
        ../../modules/layout/us-mac.nix
        ../../modules/locale/fonts.nix
        ../../modules/locale/sv_SE.nix
        ../../modules/locale/timezone/europe/stockholm.nix
        ../../modules/networking.nix
        ../../modules/programs/1password.nix
        ../../modules/programs/wireshark.nix
        ../../modules/security.nix
        ../../modules/ssh.nix
        ../../modules/system.nix
        ../../modules/systemd.nix
        ../../modules/vim/plugins.nix
        ../../modules/virtualization/docker.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "tpt14-g3";

    system.stateVersion = "25.05";
}
