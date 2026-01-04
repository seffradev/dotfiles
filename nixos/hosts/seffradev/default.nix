{ config, pkgs, ... }: {
    imports = [
        ../../modules/audio.nix
        ../../modules/environment/link-paths.nix
        ../../modules/graphics/nvidia.nix
        ../../modules/layout/us-mac.nix
        ../../modules/locale/fonts.nix
        ../../modules/locale/sv_SE.nix
        ../../modules/locale/timezone/europe/stockholm.nix
        ../../modules/networking.nix
        ../../modules/programs
        ../../modules/programs/1password.nix
        ../../modules/programs/wireshark.nix
        ../../modules/security.nix
        ../../modules/ssh.nix
        ../../modules/steam
        ../../modules/system.nix
        ../../modules/systemd.nix
        ../../modules/vim/plugins.nix
        ../../modules/virtualization/docker.nix
        ./hardware-configuration.nix
    ];

    networking.hostName = "seffradev";

    fileSystems."/media" = {
        device = "/dev/sda1";
        fsType = "ext4";
    };

    system.stateVersion = "25.05";
}
