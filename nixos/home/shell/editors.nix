{ lib, pkgs, ...
}: {
    home.packages = with pkgs; [
        neovim
        tracy
        glab
        gh
        typos-lsp
        harper
        samply
    ];

    home.file = {
        ".config/nvim" = {
            source = ./nvim;
            recursive = true;
        };
        ".clang-format".source = ./clang/format.yml;
        ".config/clangd/config.yaml".source = ./clang/config.yaml;
    };

    programs = {
    };
}
