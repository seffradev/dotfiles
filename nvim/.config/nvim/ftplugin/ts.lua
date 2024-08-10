local lspconfig = require("lspconfig")

lspconfig.tsserver.setup({})

vim.cmd.LspStart()
