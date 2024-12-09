return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
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
      local config = require "lspconfig"
      config.lua_ls.setup {}
      config.clangd.setup {}
      config.rust_analyzer.setup {
        diagnostics = {
          enable = false,
        }
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            print("No client could be connected")
            return
          end

          if client.supports_method(client, "textDocument/implementation", 0) then
            -- Create a keymap for vim.lsp.buf.implementation
          end

          if client.supports_method(client, "textDocument/completion", 0) then
            -- Enable auto-completion
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
    end,
  },
}
