local set = vim.opt_local

set.linebreak = true
set.wrap = true

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "typst",
    },
}

vim.lsp.config("tinymist", {})
vim.lsp.enable("tinymist")
