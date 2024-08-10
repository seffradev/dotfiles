local lspconfig = require("lspconfig")

lspconfig.bashls.setup({})

vim.cmd.LspStart()
