vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {})

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "rust",
    },
}
