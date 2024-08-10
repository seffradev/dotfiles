local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = {
        "css",
        "gitignore",
        "make",
        "query",
        "vim",
        "vimdoc",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            scope_incremental = false,
            node_decremental = "<bs>",
        },
    },
})

require("nvim-treesitter.configs").setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                ["l="] = { query = "@assignment.lhs", desc = "Select left-hand side of an assignment" },
                ["r="] = { query = "@assignment.rhs", desc = "Select right-hand side of an assignment" },

                ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter" },
                ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter" },

                ["ac"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                ["ic"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                ["as"] = { query = "@class.outer", desc = "Select outer part of a struct/class" },
                ["is"] = { query = "@class.inner", desc = "Select inner part of a struct/class" },

                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
                ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },

                ["ad"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
                ["id"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
            },
        },
        swap = {
            enable = true,
            swap_next = {
                ["<leader>na"] = "@parameter.inner",
            },
            swap_previous = {
                ["<leader>pa"] = "@parameter.inner",
            },
        },
    },
})
