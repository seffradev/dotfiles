{ config, pkgs, ... }: let
    browser = ["firefox.desktop"];
    audio = ["mpv.desktop"];
    video = ["mpv.desktop"];
    image = ["imv.desktop"];
    document = ["org.pwmt.zathura.desktop"];
    editor = ["nvim.desktop"];

    associations = {
        "application/epub" = document;
        "application/json" = editor;
        "application/pdf" = document;
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "audio/*" = audio;
        "image/*" = document;
        "text/html" = browser;
        "text/plain" = editor;
        "video/*" = video;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/spotify" = ["spotify.desktop"];
        "x-scheme-handler/unknown" = browser;
    };
in {
    xdg = {
        enable = true;
        cacheHome = config.home.homeDirectory + "/.local/cache";

        mimeApps = {
            enable = true;
            defaultApplications = associations;
        };

        portal = {
            enable = true;
            xdgOpenUsePortal = true;
            config = {
                common.default = ["hyprland"];
                hyprland.default = ["hyprland" "wlr" "gtk"];
            };
            extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal-wlr
                xdg-desktop-portal-hyprland
            ];
        };

        userDirs = {
            enable = true;
            createDirectories = true;
            pictures = "pictures";
            download = "downloads";
            documents = "documents";
            publicShare = "public";
            desktop = "desktop";
            music = "music";
            videos = "videos";
            templates = "templates";
            extraConfig = {
                XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/screenshots";
            };
        };
    };
}
