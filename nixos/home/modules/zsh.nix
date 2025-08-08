{ pkgs, ...  }: {
    programs = {
        zsh = {
            enable = true;
            enableCompletion = true;
            autosuggestion.enable = true;
            syntaxHighlighting.enable = true;
            defaultKeymap = "viins";

            history.size = 10000;
            history.append = true;
            history.extended = true;
            history.ignoreDups = true;
            history.share = true;
            history.path = "$HOME/.zsh_history";

            oh-my-zsh = {
                enable = true;
                plugins = [
                    "git"
                    "z"
                    "fzf"
                ];
                theme = "robbyrussell";
            };
        };
    };
}
