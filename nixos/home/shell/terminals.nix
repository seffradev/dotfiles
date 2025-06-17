{ lib, pkgs, ...
}: {
    programs = {
        kitty = {
            enable = true;
            font = {
                size = 16.0;
                name = "JetBrainsMono Nerd Font";
            };
            extraConfig = ''
                bold_font "JetBrainsMono Nerd Font Bold"
                italic_font "JetBrainsMono Nerd Font Italic"
                bold_italic_font "JetBrainsMono Nerd Font Italic Bold"
                background_opacity 1
                background_blur 0
                '';
        };
    };
}
