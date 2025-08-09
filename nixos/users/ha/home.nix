{ pkgs, lib, ... }: {
    imports = [
        ../../home/modules/clang
        ../../home/modules/dunst
        ../../home/modules/gamescope
        ../../home/modules/hyprland
        ../../home/modules/nvim
        ../../home/modules/rofi
        ../../home/modules/starship
        ../../home/modules/tmux
        ../../home/modules/waybar
        ../../home/modules/audio.nix
        ../../home/modules/cloud-storage.nix
        ../../home/modules/core.nix
        ../../home/modules/email.nix
        ../../home/modules/firefox.nix
        ../../home/modules/games.nix
        ../../home/modules/gcc.nix
        ../../home/modules/git.nix
        ../../home/modules/keyboard.nix
        ../../home/modules/kitty.nix
        ../../home/modules/media-creation.nix
        ../../home/modules/music.nix
        ../../home/modules/neomutt.nix
        ../../home/modules/networking.nix
        ../../home/modules/nix.nix
        ../../home/modules/perf.nix
        ../../home/modules/ssh.nix
        ../../home/modules/video.nix
        ../../home/modules/virtualization.nix
        ../../home/modules/xdg.nix
        ../../home/modules/zsh.nix
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        PAGER = "bat";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        MANPAGER = "sh -c 'bat -l man -p'";
    };

    home.shellAliases = {
        e = "$EDITOR";
    };

    editorconfig = {
        enable = true;
        settings = {
            "*" = {
                charset = "utf-8";
                end_of_line = "lf";
                trim_trailing_whitespace = true;
                max_line_width = 120;
                indent_style = "space";
                indent_size = 4;
            };
        };
    };

    programs = {
        zsh = {
            initContent = lib.mkBefore ''
                if [ ! $(tty | grep tty) ] && command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
                    exec tmux new -As 0
                fi
            '';
        };
        git = {
            userName = "Hampus Avekvist";
            userEmail = "hampus@seffra.dev";
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
                user = {
                    signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIf0lvauxhZ0c8IeB2Gb1QFGNaacNA9z8c0Y2CJDLIXO";
                };
                diff.tool = "nvimdiff";
                difftool.prompt = false;
                merge.tool = "nvimdiff";
                mergetool.prompt = false;
                "mergetool \"vimdiff\"".layout = "LOCAL,BASE,REMOTE / MERGED";
            };
        };
    };
}
