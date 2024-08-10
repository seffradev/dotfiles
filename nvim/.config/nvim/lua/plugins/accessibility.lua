return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
    },
    {
        "folke/zen-mode.nvim",
        dependencies = {
            "folke/twilight.nvim",
        },
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false,
    },
    {
        "mbbill/undotree",
    }
}
