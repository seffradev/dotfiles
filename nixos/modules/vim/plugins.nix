{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
        vimPlugins.fzfWrapper
        vimPlugins.nvim-treesitter
    ];
}