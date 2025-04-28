local set = vim.opt_local

set.linebreak = true
set.wrap = true

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "typst",
    },
}
---
---@diagnostic disable-next-line: missing-fields
require "mason-lspconfig".setup { ensure_installed = { "tinymist" } }

vim.lsp.config("tinymist", {})
vim.lsp.enable("tinymist")
