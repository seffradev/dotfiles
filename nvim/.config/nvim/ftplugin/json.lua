local lspconfig = require("lspconfig")

lspconfig.jsonls.setup({})

vim.cmd.LspStart()
