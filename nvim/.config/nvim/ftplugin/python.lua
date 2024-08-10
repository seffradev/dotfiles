local lspconfig = require("lspconfig")

lspconfig.ruff.setup({})

lspconfig.ruff_lsp.setup({
    on_attach = function(client, _)
        if client.name == "ruff_lsp" then
            client.server_capabilities.hoverProvider = false
        end
    end
})

lspconfig.pyright.setup({
    settings = {
        pyright = {
            disableOrganizeImports = true,
        },
        python = {
            analysis = {
                ignore = { "*" },
            }
        }
    }
})

vim.cmd.LspStart()
