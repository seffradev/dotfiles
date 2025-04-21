---@diagnostic disable-next-line: missing-fields
require "mason-lspconfig".setup { ensure_installed = { "rust_analyzer" } }

vim.lsp.enable("rust_analyzer")
vim.lsp.config("rust_analyzer", {})
