{ config, lib, pkgs, ... }: {
    home.packages = with pkgs; [
        starship
    ];

    programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            format = lib.concatStrings [
                "$username"
                "$hostname"
                "$directory"
                "$git_branch"
                "$shell"
                "$character"
            ];
            right_format = "$time";
            add_newline = false;
            package = {
                disabled = true;
            };
            character = {
                success_symbol = "[➜](bold green) ";
                error_symbol = "[✗](bold red) ";
            };
            time = {
                disabled = false;
                format = "[$time]($style) ";
                time_format = "%Y-%m-%d %T";
            };
            git_branch = {
                format = "[$symbol$branch(:$remote_branch)]($style) ";
                truncation_length = 17;
                truncation_symbol = "";
            };
            c = {
                detect_extensions = [
                    "c"
                    "h"
                    "cpp"
                    "hpp"
                    "cxx"
                    "hxx"
                ];
            };
        };
    };
}
