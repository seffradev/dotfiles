{ config, pkgs, ... }: {
    home.packages = with pkgs; [
        neovim
        typos-lsp
        harper
    ];

    home.file = {
        "${config.xdg.configHome}/nvim" = {
            source = ./.;
            recursive = true;
        };
    };
}
