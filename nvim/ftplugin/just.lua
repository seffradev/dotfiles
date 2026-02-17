vim.lsp.config("just-lsp", {})
vim.lsp.enable("just-lsp")

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "just",
    },
}
