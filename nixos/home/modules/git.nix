{ pkgs, lib, ... }: {
    home.packages = with pkgs; [
        lazygit
        glab
        gh
    ];

    home.shellAliases = {
        lg = "lazygit";
    };

    programs = {
        git = {
            enable = true;
            extraConfig = {
                init = {
                    defaultBranch = "main";
                };
                rerere = {
                    enabled = true;
                };
                pull = {
                    rebase = true;
                };
                rebase = {
                    updateRefs = true;
                };
            };
        };
    };
}
