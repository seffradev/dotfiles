return {
    {
        "nvim-treesitter/nvim-treesitter",
        enabled = true,
        build = ":TSUpdate",
        config = function()
            local configs = require "nvim-treesitter.configs"

            configs.setup {
                ensure_installed = {
                    "query",
                    "vim",
                    "vimdoc",
                },

                sync_install = false,
                auto_install = false,
                ignore_install = {},
                modules = {},

                highlight = {
                    enable = true,

                    disable = function(_, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        ---@diagnostic disable-next-line: undefined-field
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    additional_vim_regex_highlighting = false,
                }
            }
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            ---@diagnostic disable-next-line: missing-fields
            require "nvim-treesitter.configs".setup {
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                        include_surrounding_whitespace = true,
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>a"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["<leader>A"] = "@parameter.inner",
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true,
                        goto_next_start = {
                            ["]m"] = "@function.outer",
                            ["]]"] = "@class.outer",
                        },
                        goto_next_end = {
                            ["]M"] = "@function.outer",
                            ["]["] = "@class.outer",
                        },
                        goto_previous_start = {
                            ["[m"] = "@function.outer",
                            ["[["] = "@class.outer",
                        },
                        goto_previous_end = {
                            ["[M"] = "@function.outer",
                            ["[]"] = "@class.outer",
                        },
                        goto_next = {
                            ["]c"] = "@conditional.outer",
                        },
                        goto_previous = {
                            ["[c"] = "@conditional.outer",
                        },
                    },
                }
            }
            local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

            -- Repeat movement with ; and ,
            -- ensure ';' goes forward and ',' goes backward regardless of the last direction
            vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

            -- vim way: ';' goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ';' and ','
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end
    }
}
