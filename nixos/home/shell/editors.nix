{ lib, pkgs, ...
}: {
    home.packages = with pkgs; [
        neovim
        tracy
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
