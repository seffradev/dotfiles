{ pkgs, lib, username, ... }: {
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [ "networkmanager" ];
    };

    nix.settings = {
        trusted-users = [username];
        experimental-features = [ "nix-command" "flakes" ];
    };

    nix.gc = {
        automatic = lib.mkDefault true;
        dates  = lib.mkDefault "weekly";
        options = lib.mkDefault "--delete-older-than 7d";
    };

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = pkg: true;

    i18n.defaultLocale = "en_US.UTF-8";

    services.printing.enable = true;

    environment.pathsToLink = [
        "/share/xdg-desktop-portal"
        "/share/applications"
        "/share/zsh"
    ];

    programs = {
        nix-ld.enable = true;
        appimage = {
            enable = true;
            binfmt = true;
        };
    };

    hardware.graphics.enable = true;

    boot.kernelPackages = pkgs.linuxPackages;
}
