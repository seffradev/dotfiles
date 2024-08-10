-- LSP
local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
    autostart = true,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            }
        }
    }
})

vim.cmd.LspStart()

-- Treesitter
local treesitter_configs = require("nvim-treesitter.configs")

treesitter_configs.setup({
    ensure_installed = {
        "rust",
    }
})
