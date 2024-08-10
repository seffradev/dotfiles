local lspconfig = require("lspconfig")

lspconfig.rust_analyzer.setup({
    autostart = true,
    settings = {
        ['rust-analyzer'] = {
            check = {
                command = "clippy",
            }
        }
    }
})

vim.cmd.LspStart()
