{ pkgs, lib, ... }: {
    home.packages = with pkgs; [
        gh
        glab
        lazygit
        onefetch
    ];

    home.shellAliases = {
        lg = "lazygit";
    };

    programs = {
        git = {
            enable = true;
            settings = {
                init = {
                    defaultBranch = "main";
                };
                merge.ff = true;
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
