{ username, pkgs, ... }: {
    home = {
        inherit username;
        homeDirectory = "/home/${username}";

        stateVersion = "25.05";

        packages = with pkgs; [
            bat
            btop
            curl
            fd
            fzf
            grim
            imv
            jq
            presenterm
            rfc
            ripgrep
            slurp
            unzip
            wget
            wl-clipboard
            yazi
            zathura
            zip
        ];
    };

    programs.home-manager.enable = true;
}
