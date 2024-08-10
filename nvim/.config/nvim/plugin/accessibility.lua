-- Zen Mode
local zen_mode = require("zen-mode")

zen_mode.setup({
    window = {
        width = 90,
        backdrop = 1,
        options = {
            signcolumn = "no",      -- disable signcolumn
            number = true,          -- disable number column
            relativenumber = false, -- disable relative numbers
            cursorline = false,     -- disable cursorline
            cursorcolumn = false,   -- disable cursor column
            foldcolumn = "0",       -- disable fold column
            list = false,           -- disable whitespace characters
        },
    },
})

-- Bindings
local wk = require("which-key")

wk.add({
    { "n",     "nzzzv",            desc = "Move to next match",     nowait = true, remap = false },
    { "gcc",   "<nop>",            desc = "",                       nowait = true, remap = false },
    { "N",     "Nzzzv",            desc = "Move to previous match", nowait = true, remap = false },
    { "K",     ":m '<-2<CR>gv=gv", desc = "Move line up",           nowait = true, remap = false },
    { "J",     "mzJ`z",            desc = "Join line below",        nowait = true, remap = false },
    { "J",     ":m '>+1<CR>gv=gv", desc = "Move line down",         nowait = true, remap = false },
    { "<C-u>", "<C-u>zz",          desc = "Scroll up",              nowait = true, remap = false },
    { "<C-d>", "<C-d>zz",          desc = "Scroll down",            nowait = true, remap = false },
    { "<C-c>", "<nop>",            desc = "",                       nowait = true, remap = false },
    {
        "<leader>s",
        ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
        desc = "Substitute word under cursor"
    },
})

--- Tmux
wk.add({
    { "<C-l>", "<cmd> TmuxNavigateRight<CR>",                desc = "Go right in tmux",      nowait = true, remap = false },
    { "<C-k>", "<cmd> TmuxNavigateUp<CR>",                   desc = "Go up in tmux",         nowait = true, remap = false },
    { "<C-j>", "<cmd> TmuxNavigateDown<CR>",                 desc = "Go down in tmux",       nowait = true, remap = false },
    { "<C-h>", "<cmd> TmuxNavigateLeft<CR>",                 desc = "Go left in tmux",       nowait = true, remap = false },
    { "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>", desc = "Open tmux sessionizer", nowait = true, remap = false },
})

--- Undotree
wk.add({
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree", nowait = true, remap = false },
})

--- Zen Mode
wk.add({
    { "<leader>z",  group = "Zen Mode", desc = "",                nowait = true, remap = false },
    { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Toggle zen mode", nowait = true, remap = false },
})
