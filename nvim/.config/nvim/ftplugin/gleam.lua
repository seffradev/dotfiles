local lspconfig = require("lspconfig")

lspconfig.gleam.setup({})

vim.cmd.LspStart()
