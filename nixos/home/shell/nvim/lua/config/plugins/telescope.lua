return {
    {
        "seffradev/telescope.nvim",
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            {
                "nvim-telescope/telescope-ui-select.nvim",
            },
        },
        config = function()
            local telescope = require "telescope"
            local builtin = require "telescope.builtin"

            telescope.setup {
                defaults = {
                    theme = "dropdown",
                    sorting_strategy = "ascending",
                    layout_strategy = "flex",
                    border = true,
                },
                extensions = {
                    fzf = {},
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {}
                    },
                },
            }

            telescope.load_extension "fzf"
            telescope.load_extension "ui-select"

            vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy-find current buffer" })
            vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search git files" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search git branches" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Search document symbols" })
            vim.keymap.set("n", "<leader>fS", builtin.lsp_workspace_symbols, { desc = "Search workspace symbols" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search diagnostics" })
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search files in current working directory" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
            vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search keymaps" })
            vim.keymap.set("n", "<leader>fr", builtin.lsp_references, { desc = "Search symbol references" })
            vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Resume last search" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Search open buffers" })
            vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "Search command history" })

            vim.keymap.set("n", "<leader>en", function()
                builtin.find_files {
                    cwd = vim.fn.stdpath("config")
                }
            end, { desc = "Edit Neovim configuration" })

            vim.keymap.set("n", "<leader>ep", function()
                builtin.find_files {
                    ---@diagnostic disable-next-line: param-type-mismatch
                    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
                }
            end, { desc = "Search files from Neovim packages" })

            vim.keymap.set("n", "<leader>fg", function()
                builtin.grep_string {
                    search = vim.fn.input "grep: ",
                    hidden = true,
                }
            end, { desc = "Grep files in current working directory" })

            vim.keymap.set("n", "<leader>fG", function()
                builtin.grep_string {
                    search = vim.fn.input "grep (hidden): ",
                    hidden = true,
                }
            end, { desc = "Grep files (inclusive hidden) in current working directory" })

            require "config.telescope.multigrep".setup {}
        end,
    },
}
