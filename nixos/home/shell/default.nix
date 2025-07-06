{ config, pkgs, ... }: {
    imports = [
        ./terminals.nix
        ./editors.nix
        ./tmux.nix
        ./zsh.nix
    ];

    home.packages = with pkgs; [
        bat
        btop
        cloc
        curl
        distrobox
        fd
        fzf
        jq
        neofetch
        neomutt
        neovim
        onefetch
        pre-commit
        presenterm
        rfc
        ripgrep
        starship
        stow
        thefuck
        tmux
        unzip
        wget
        xmake
        yazi
        zip
    ];

    home.sessionVariables = {
        EDITOR = "nvim";
        PAGER = "bat";
        BROWSER = "firefox";
        TERMINAL = "kitty";
        MANPAGER = "sh -c 'bat -l man -p'";
    };

    home.file = {
        ".config/starship.toml".source = ./starship.toml;
        ".local/bin/start-gamescope".source = ./start-gamescope.sh;
    };

    home.shellAliases = {
        update = "sudo nixos-rebuild switch --flake .";
        develop = "nix develop --command $SHELL";
        e = "nvim";
        lg = "lazygit";
    };
}
