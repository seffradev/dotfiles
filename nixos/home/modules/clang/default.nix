{ config, ... }: {
    home.file = {
        "${config.xdg.configHome}/clangd/config.yaml".source = ./config.yaml;
        ".clang-format".source = ./format.yml;
    };
}