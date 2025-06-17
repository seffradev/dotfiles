{ pkgs, lib, ...
}: {
    home.packages = with pkgs; [
        lazygit
    ];

    programs = {
        git = {
            enable = true;
            extraConfig = {
                gpg = {
                    format = "ssh";
                };
                "gpg \"ssh\"" = {
                    program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
                };
                commit = {
                    gpgsign = true;
                };
                tag = {
                    gpgsign = true;
                };
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
