{ pkgs, inputs, ...  }:
let
in
{
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
                { plugin = inputs.minimal-tmux.packages.${pkgs.system}.default; }
            ];
            extraConfig = ''
                bind-key -T copy-mode-vi v send-keys -X begin-selection
                bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
                bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

                bind-key -r f run-shell "tmux neww ~/.local/bin/tmux-sessionizer"
                bind-key -r i run-shell "tmux neww ~/.local/bin/cheatsheet"

                bind '"' split-window -v -c "#{pane_current_path}"
                bind % split-window -h -c "#{pane_current_path}"
            '';
        };
    };

    home.file = {
        ".local/bin/tmux-sessionizer".source = ./tmux-sessionizer.sh;
        ".local/bin/cheatsheet".source = ./cheatsheet.sh;
    };
}
