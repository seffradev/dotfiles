local lspconfig = require("lspconfig")

lspconfig.taplo.setup({})

vim.cmd.LspStart()
