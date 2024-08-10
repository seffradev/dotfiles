local lspconfig = require("lspconfig")

lspconfig.lua_ls.setup({})

vim.cmd.LspStart()
