{ pkgs, ...
}: {
    programs = {
        tmux = {
            enable = true;
            shell = "${pkgs.zsh}/bin/zsh";
            terminal = "tmux-256color";
            historyLimit = 100000;
            clock24 = true;
            keyMode = "vi";
            mouse = true;
            prefix = "C-f";
            plugins = with pkgs; [
                tmuxPlugins.yank
                tmuxPlugins.sensible
                tmuxPlugins.vim-tmux-navigator
            ];
            extraConfig = ''
                bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
            '';
        };
    };

    home.file = {
        ".local/bin/tmux-sessionizer".source = ./tmux-sessionizer.sh;
        ".local/bin/cheatsheet".source = ./cheatsheet.sh;
    };
}
