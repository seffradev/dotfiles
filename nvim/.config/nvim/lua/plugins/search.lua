return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "mfussenegger/nvim-dap",
            "nvim-treesitter/nvim-treesitter",
        }
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}
