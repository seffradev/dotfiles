local lspconfig = require("lspconfig")

lspconfig.csharp_ls.setup({})

vim.cmd.LspStart()
