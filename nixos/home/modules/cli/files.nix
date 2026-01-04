{ username, pkgs, ... }: {
    home.packages = with pkgs; [
        bat
        fd
        fzf
        ripgrep
        yazi
    ];

    programs.fzf.enableZshIntegration = true;
}
