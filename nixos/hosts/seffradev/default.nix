{ config, pkgs, ... }: {
    imports = [
        ../../modules/system.nix
        ./hardware-configuration.nix
    ];

    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
    };

    environment.systemPackages = with pkgs; [
        audacity
        davinci-resolve
        obs-studio
        prismlauncher
        asterisk
    ];

    networking = {
        hostName = "seffradev";
        networkmanager.enable = true;

        firewall.enable = true;
        firewall.allowedTCPPorts = [ 25565 ];
        firewall.allowedUDPPorts = [ 25565 ];
    };

    programs = {
        gamescope = {
            enable = true;
            capSysNice = true;
        };

        steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
            gamescopeSession.enable = true;
        };
    };

    services = {
        xserver.videoDrivers = [ "nvidia" ];
    };

    hardware.nvidia = {
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    system.stateVersion = "25.05";
}
