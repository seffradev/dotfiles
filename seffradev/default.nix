{
    config,
    pkgs,
    ...
}: {
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostName = "seffradev";

    fileSystems."/media" = {
        device = "/dev/sda1";
        fsType = "ext4";
    };

    services = {
        xserver.videoDrivers = [ "nvidia" ];
    };

    environment.variables = {
        NVD_BACKEND = "direct";
        LIBVA_DRIVER_NAME = "nvidia";
    };

    hardware = {
        graphics.extraPackages = with pkgs; [
            nvidia-vaapi-driver
        ];

        nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            dynamicBoost.enable = false;
            nvidiaPersistenced = false;
            open = true;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.latest;
        };
    };
}
