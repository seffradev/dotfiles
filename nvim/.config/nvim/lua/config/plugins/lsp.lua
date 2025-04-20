return {
  {
    "neovim/nvim-lspconfig",
    enabled = true,
    dependencies = {
      "obarbier/sonarlint.nvim",
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
      local config = require "lspconfig"
      local capabilities = require "blink.cmp".get_lsp_capabilities()

      config.lua_ls.setup { capabilities = capabilities }
      config.clangd.setup { capabilities = capabilities }
      config.texlab.setup { capabilities = capabilities }
      config.mesonlsp.setup { capabilities = capabilities }
      config.ruff.setup { capabilities = capabilities }
      config.gdscript.setup { capabilities = capabilities }
      config.pyright.setup {
        capabilities = capabilities,
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              ignore = {
                "*",
              },
            },
          },
        },
      }
      config.typos_lsp.setup { capabilities = capabilities }
      config.harper_ls.setup {
        capabilities = capabilities,
        settings = {
          ["harper-ls"] = {
            userDictPath = "~/dictionary.txt"
          },
        },
      }
      config.rust_analyzer.setup {
        capabilities = capabilities,
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

          vim.keymap.set("n", "gd", vim.lsp.buf.definition)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition)

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
                -- vim.lsp.buf.format({
                --   bufnr = args.buf,
                --   id = client.id,
                -- })
              end,
            })
          end
        end,
      })

      local sonarlint = require "sonarlint"
      sonarlint.setup {
        server = {
          cmd = {
            'sonarlint-ls',
            -- Ensure that sonarlint-language-server uses stdio channel
            '-stdio',
            -- '-analyzers', 'path/to/analyzer1.jar', 'path/to/analyzer2.jar', 'path/to/analyzer3.jar',
          },
        },
        filetypes = {
          -- Tested and working
          'python',
          'cpp',
        }
      }
    end,
  },
}
