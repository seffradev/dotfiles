{ pkgs, ... }: {
    fonts = {
        enableDefaultPackages = false;
        fontDir.enable = true;
        packages = with pkgs; [
            # icons
            material-design-icons

            # normal fonts
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji

            # nerdfonts
            nerd-fonts.symbols-only
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
        ];

        fontconfig = {
            enable = true;
            defaultFonts = {
                emoji = ["Noto Color Emoji"];
                monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
                sansSerif = ["Noto Sans" "Noto Color Emoji"];
                serif = ["Noto Serif" "Noto Color Emoji"];
            };
        };
    };
}