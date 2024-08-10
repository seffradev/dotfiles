local lspconfig = require("lspconfig")

lspconfig.sqlls.setup({})

vim.cmd.LspStart()
