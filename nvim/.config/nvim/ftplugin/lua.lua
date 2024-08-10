-- LSP
local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})

vim.cmd.LspStart()

-- Treesitter
local treesitter_configs = require("nvim-treesitter.configs")

treesitter_configs.setup({
    ensure_installed = {
        "lua"
    }
})
