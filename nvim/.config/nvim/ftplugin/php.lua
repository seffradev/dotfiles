local lspconfig = require("lspconfig")

lspconfig.intelephense.setup({})

vim.cmd.LspStart()
