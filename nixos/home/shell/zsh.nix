{ lib, pkgs, ...
}: {
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;

            history.size = 10000;
# history.file = "$HOME/.zsh_history";

# setOptions = [
#   "HIST_IGNORE_ALL_DUPS"
# ];

            oh-my-zsh = {
                enable = true;
                plugins = [
                    "git"
                    "thefuck"
                    "z"
                    "fzf"
                ];
                theme = "robbyrussell";
            };
        };
    };
}
