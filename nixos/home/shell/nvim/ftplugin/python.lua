---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "python",
    },
}

vim.lsp.enable("ruff")
vim.lsp.config("ruff", {})

vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = {
                    "*",
                },
            },
        },
    },
})
