return {
    {
        "neovim/nvim-lspconfig",
        enabled = true,
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        {
                            path = "${3rd}/luv/library",
                            words = { "vim%.uv" },
                        },
                    },
                },
            },
        },
        config = function()
            vim.lsp.enable("typos_lsp")
            vim.lsp.config("typos_lsp", {})

            vim.lsp.enable("harper_ls")
            vim.lsp.config("harper_ls", {})

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        print("No client could be connected")
                        return
                    end

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })

                    if client.supports_method(client, "textDocument/declaration", 0) then
                        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
                    else
                        vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "Go to definition" })
                    end

                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })

                    if client.supports_method(client, "textDocument/implementation", 0) then
                        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
                    end

                    if client.supports_method(client, "textDocument/completion", 0) then
                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
                    end

                    if client.supports_method(client, "textDocument/formatting", 0) then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = args.buf,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = args.buf,
                                    id = client.id,
                                })
                            end,
                        })
                    end
                end,
            })
        end
    },
}
