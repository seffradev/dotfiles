{ pkgs, lib, username, ... }: {
    users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [ "networkmanager" ];
    };

    system.autoUpgrade = {
        enable = true;
        allowReboot = true;
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

    services.udev.extraRules = ''
        KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
    '';

    hardware.graphics.enable = true;

    boot.kernelPackages = pkgs.linuxPackages;
}
