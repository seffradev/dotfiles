return {
    {
        "hinell/lsp-timeout.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        dependencies = {
            -- LSP support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    {
        "williamboman/mason-lspconfig.nvim",
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "mfussenegger/nvim-jdtls",
    },
    {
        "folke/trouble.nvim",
    }
}
