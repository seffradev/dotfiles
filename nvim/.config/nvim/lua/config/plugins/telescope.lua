return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-lua/plenary.nvim",
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require "telescope"
      local builtin = require "telescope.builtin"

      telescope.load_extension "fzf"

      telescope.setup {
        defaults = {
          theme = "ivy",
          sorting_strategy = "ascending",
          layout_strategy = "bottom_pane",
          layout_config = {
            height = 40,
          },
          border = false,
          borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
        },
        extensions = {
          fzf = {},
        },
      }

      vim.keymap.set("n", "<space>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy-find current buffer" })
      vim.keymap.set("n", "<space>gf", builtin.git_files, { desc = "Search git files" })
      vim.keymap.set("n", "<space>gb", builtin.git_branches, { desc = "Search git branches" })
      vim.keymap.set("n", "<space>fs", builtin.lsp_document_symbols, { desc = "Search document symbols" })
      vim.keymap.set("n", "<space>fS", builtin.lsp_workspace_symbols, { desc = "Search workspace symbols" })
      vim.keymap.set("n", "<space>fd", builtin.diagnostics, { desc = "Search diagnostics" })
      vim.keymap.set("n", "<space>ff", builtin.find_files, { desc = "Search files in current working directory" })
      vim.keymap.set("n", "<space>fh", builtin.help_tags, { desc = "Search help tags" })
      vim.keymap.set("n", "<space>fk", builtin.keymaps, { desc = "Search keymaps" })
      vim.keymap.set("n", "<space>fr", builtin.lsp_references, { desc = "Search symbol references" })
      vim.keymap.set("n", "<space>fR", builtin.resume, { desc = "Resume last search" })
      vim.keymap.set("n", "<space>fb", builtin.buffers, { desc = "Search open buffers" })
      vim.keymap.set("n", "<space>fc", builtin.command_history, { desc = "Search command history" })

      vim.keymap.set("n", "<space>en", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end, { desc = "Edit Neovim configuration" })

      vim.keymap.set("n", "<space>ep", function()
        builtin.find_files {
          ---@diagnostic disable-next-line: param-type-mismatch
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
        }
      end, { desc = "Search files from Neovim packages" })

      vim.keymap.set("n", "<space>fg", function()
        builtin.grep_string {
          search = vim.fn.input "grep: ",
        }
      end, { desc = "Grep files in current working directory" })

      require "config.telescope.multigrep".setup {}
    end,
  },
}
