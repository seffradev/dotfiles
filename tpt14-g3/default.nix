{
    config,
    pkgs,
    ...
}: {
    imports = [
        ./hardware-configuration.nix
    ];

    networking.hostName = "tpt14-g3";
}
