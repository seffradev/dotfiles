{ pkgs, lib, ... }: {
    imports = [
        ../../home/modules/browsers/chromium.nix
        ../../home/modules/browsers/firefox.nix
        ../../home/modules/cli/documentation.nix
        ../../home/modules/cli/files.nix
        ../../home/modules/cli/pager.nix
        ../../home/modules/cli/presentation.nix
        ../../home/modules/cli/stats.nix
        ../../home/modules/cli/web.nix
        ../../home/modules/cli/zip.nix
        ../../home/modules/cloud/storage/dropbox.nix
        ../../home/modules/cloud/storage/pcloud.nix
        ../../home/modules/communication/discord.nix
        ../../home/modules/communication/neomutt.nix
        ../../home/modules/core.nix
        ../../home/modules/creation/audio.nix
        ../../home/modules/creation/image.nix
        ../../home/modules/creation/video.nix
        ../../home/modules/debugging/networking.nix
        ../../home/modules/development/clang
        ../../home/modules/development/editors/nvim
        ../../home/modules/development/editors/vscode.nix
        ../../home/modules/development/gcc.nix
        ../../home/modules/development/git.nix
        ../../home/modules/documents/libreoffice.nix
        ../../home/modules/documents/zathura.nix
        ../../home/modules/hardware/keyboard.nix
        ../../home/modules/kdeconnect.nix
        ../../home/modules/media/audio.nix
        ../../home/modules/media/spotify.nix
        ../../home/modules/media/video.nix
        ../../home/modules/obsidian.nix
        ../../home/modules/shells/starship
        ../../home/modules/shells/tmux
        ../../home/modules/shells/zsh.nix
        ../../home/modules/ssh.nix
        ../../home/modules/terminals/kitty.nix
        ../../home/modules/virtualization/distrobox.nix
        ../../home/modules/wayland/clipboard.nix
        ../../home/modules/wayland/dunst
        ../../home/modules/wayland/hyprland
        ../../home/modules/wayland/rofi
        ../../home/modules/wayland/screenshot.nix
        ../../home/modules/xdg.nix
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        PAGER = "bat";
        BROWSER = "brave";
        TERMINAL = "kitty";
        MANPAGER = "sh -c 'bat -l man -p'";
        FZF_BASE = "${pkgs.fzf}/share/fzf";
    };

    home.shellAliases = {
        e = "$EDITOR";
        update = "sudo -E nixos-rebuild switch --flake .";
        develop = "nix develop --command $SHELL";
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
        git.settings = {
            user.name = "Hampus Avekvist";
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
            "mergetool \"vimdiff\"".prompt = false;
            "includeIf \"gitdir:~/projects/\"".path = "~/projects/.gitconfig";
        };
    };
}
