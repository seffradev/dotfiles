local lspconfig = require("lspconfig")

lspconfig.svelte.setup({})

vim.cmd.LspStart()
