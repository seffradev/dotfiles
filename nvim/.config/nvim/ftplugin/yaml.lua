local lspconfig = require("lspconfig")

lspconfig.yamlls.setup({})

vim.cmd.LspStart()
