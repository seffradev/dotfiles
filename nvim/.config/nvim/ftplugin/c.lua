local lspconfig = require("lspconfig")

lspconfig.clangd.setup({})

vim.cmd.LspStart()
