local lspconfig = require("lspconfig")

lspconfig.jdtls.setup({})

vim.cmd.LspStart()
