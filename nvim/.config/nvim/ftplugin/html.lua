local lspconfig = require("lspconfig")

lspconfig.tailwindcss.setup({})
lspconfig.htmx.setup({})

vim.cmd.LspStart()
