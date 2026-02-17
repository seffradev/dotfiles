vim.lsp.enable("nil_ls")
vim.lsp.config("nil_ls", {})

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "nix",
    },
}
