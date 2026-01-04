{ pkgs, ... }: {
    programs = {
        nix-ld.enable = true;
        appimage = {
            enable = true;
            binfmt = true;
        };
    };

    services.flatpak.enable = true;

    xdg.portal = {
        enable = true;
        config.common.default = "*";
        extraPortals = with pkgs; [
            xdg-desktop-portal-wlr
        ];
    };
}
