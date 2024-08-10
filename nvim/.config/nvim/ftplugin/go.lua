local lspconfig = require("lspconfig")

lspconfig.gopls.setup({})

vim.cmd.LspStart()
