{pkgs, ...}: {
    imports = [
        ../../home/core.nix
        ../../home/hyprland
        ../../home/programs
        ../../home/shell
    ];

    editorconfig = {
        enable = true;
        settings = {
            "*" = {
                charset = "utf-8";
                end_of_line = "lf";
                trim_trailing_whitespace = true;
                max_line_width = 67;
                indent_style = "space";
                indent_size = 4;
            };
        };
    };

    programs.git = {
        userName = "Hampus Avekvist";
        userEmail = "hampus.avekvist@hey.com";
        extraConfig = {
            user = {
                signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIf0lvauxhZ0c8IeB2Gb1QFGNaacNA9z8c0Y2CJDLIXO";
            };
        };
    };
}
