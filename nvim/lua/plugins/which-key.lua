return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>g",  group = "Git",                                                                     desc = "Git",                                          nowait = true, remap = false },
        { "<leader>gs", "<cmd>Git<cr>",                                                                    desc = "Show git status",                              nowait = true, remap = false },
        { "<leader>l",  group = "LSP",                                                                     desc = "LSP",                                          nowait = true, remap = false },
        { "<leader>p",  group = "Project",                                                                 desc = "",                                             nowait = true, remap = false },
        { "<leader>u",  "<cmd>UndotreeToggle<cr>",                                                         desc = "Toggle Undotree",                              nowait = true, remap = false },
        { "<leader>w",  group = "Worktree",                                                                desc = "",                                             nowait = true, remap = false },
        { "<leader>wc", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "Create",                                       nowait = true, remap = false },
        { "<leader>ws", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",       desc = "Switch",                                       nowait = true, remap = false },
        { "<leader>z",  group = "Zen Mode",                                                                desc = "",                                             nowait = true, remap = false },
        { "<leader>zm", "<cmd>ZenMode<cr>",                                                                desc = "Toggle zen mode",                              nowait = true, remap = false },
        { "<C-h>",      "<cmd> TmuxNavigateLeft<CR>",                                                      desc = "Go left in tmux",                              nowait = true, remap = false },
        { "<C-l>",      "<cmd> TmuxNavigateRight<CR>",                                                     desc = "Go right in tmux",                             nowait = true, remap = false },
        { "<C-j>",      "<cmd> TmuxNavigateDown<CR>",                                                      desc = "Go down in tmux",                              nowait = true, remap = false },
        { "<C-k>",      "<cmd> TmuxNavigateUp<CR>",                                                        desc = "Go up in tmux",                                nowait = true, remap = false },
        { "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>",                                             desc = "Diagnostics (Trouble)",                        nowait = true, remap = false },
        { "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=1<cr>",                                desc = "Buffer Diagnostics (Trouble)",                 nowait = true, remap = false },
        { "<leader>ts", "<cmd>Trouble symbols toggle focus=false<cr>",                                     desc = "Symbols (Trouble)",                            nowait = true, remap = false },
        { "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",                      desc = "LSP Definitions / references / ... (Trouble)", nowait = true, remap = false },
        { "<leader>tL", "<cmd>Trouble loclist toggle<cr>",                                                 desc = "Location List (Trouble)",                      nowait = true, remap = false },
        { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>",                                                  desc = "Quickfix List (Trouble)",                      nowait = true, remap = false },
        { "<C-c>",      "<nop>",                                                                           desc = "",                                             nowait = true, remap = false },
        { "gcc",        "<nop>",                                                                           desc = "",                                             nowait = true, remap = false },
        { "<leader>pv", vim.cmd.Ex,                                                                        desc = "Show project view",                            nowait = true, remap = false },
        { "J",          ":m '>+1<CR>gv=gv",                                                                desc = "Move line down",                               nowait = true, remap = false },
        { "K",          ":m '<-2<CR>gv=gv",                                                                desc = "Move line up",                                 nowait = true, remap = false },
        { "J",          "mzJ`z",                                                                           desc = "Join line below",                              nowait = true, remap = false },
        { "<C-d>",      "<C-d>zz",                                                                         desc = "Scroll down",                                  nowait = true, remap = false },
        { "<C-u>",      "<C-u>zz",                                                                         desc = "Scroll up",                                    nowait = true, remap = false },
        { "n",          "nzzzv",                                                                           desc = "Move to next match",                           nowait = true, remap = false },
        { "N",          "Nzzzv",                                                                           desc = "Move to previous match",                       nowait = true, remap = false },
        { "<C-f>",      "<cmd>silent !tmux new tmux-sessionizer<CR>",                                      desc = "Open tmux sessionizer",                        nowait = true, remap = false },
        {
            "<leader>s",
            ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
            desc = "Substitute word under cursor"
        },
    },
    config = function()
        local wk = require("which-key")

        -- Harpoon
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        wk.add({
            { "<leader>a", mark.add_file,                 desc = "Add current file to Harpoon list" },
            { "<C-e>",     ui.toggle_quick_menu,          desc = "Toggle Harpoon quick menu" },
            { "<C-t>",     function() ui.nav_file(1) end, desc = "Go to 1st marked file" },
            { "<C-n>",     function() ui.nav_file(2) end, desc = "Go to 2nd marked file" },
            { "<C-s>",     function() ui.nav_file(3) end, desc = "Go to 3rd marked file" },
        })

        -- Telescope
        local telescope = require("telescope")
        telescope.load_extension("git_worktree")
        local builtin = require("telescope.builtin")

        wk.add({
            { "<leader>ff", builtin.find_files,  desc = "Find project files" },
            { "<leader>fd", builtin.diagnostics, desc = "Find project diagnostics" },
            { "<leader>fg", builtin.git_files,   desc = "Find git files" },
            {
                "<leader>fs",
                function()
                    builtin.grep_string({ search = vim.fn.input("search: ") });
                end,
                desc = "Search project file contents"
            },
        })

        -- LSP
        local lsp = require("lsp-zero")
        lsp.on_attach(function(_, bufnr)
            wk.add({
                { "<leader>li",  "<cmd>LspInfo<cr>",                                 desc = "LSP info" },
                { "gd",          function() vim.lsp.buf.definition() end,            desc = "Go to definition",            buffer = bufnr, remap = false },
                { "gt",          function() vim.lsp.buf.type_definition() end,       desc = "Go to type definition",       buffer = bufnr, remap = false },
                { "gi",          function() vim.lsp.buf.implementation() end,        desc = "Go to implementation",        buffer = bufnr, remap = false },
                { "K",           function() vim.lsp.buf.hover() end,                 desc = "Show type information",       buffer = bufnr, remap = false },
                { "<leader>lw",  function() vim.lsp.buf.workspace_symbol() end,      desc = "Show workspace symbols",      buffer = bufnr, remap = false },
                { "<leader>ld",  function() vim.diagnostic.open_float() end,         desc = "Open diagnostics",            buffer = bufnr, remap = false },
                { "<leader>nd",  function() vim.diagnostic.goto_next() end,          desc = "Go to next diagnostic",       buffer = bufnr, remap = false },
                { "<leader>pd",  function() vim.diagnostic.goto_prev() end,          desc = "Go to previous diagnostic",   buffer = bufnr, remap = false },
                { "<leader>lc",  function() vim.lsp.buf.code_action() end,           desc = "Show available code actions", buffer = bufnr, remap = false },
                { "<leader>lR",  function() vim.lsp.buf.references() end,            desc = "Show references",             buffer = bufnr, remap = false },
                { "<leader>lr",  function() vim.lsp.buf.rename() end,                desc = "Rename symbol",               buffer = bufnr, remap = false },
                { "<leader>lsh", function() vim.lsp.buf.signature_help() end,        desc = "Signature help",              buffer = bufnr, remap = false },
                { "<leader>lf",  vim.lsp.buf.format,                                 desc = "Format document",             remap = false },
                { "<leader>fws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Show Workspace Symbols",      buffer = bufnr, remap = false },
            })
        end)
    end
}
