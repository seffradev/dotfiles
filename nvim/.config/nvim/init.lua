require "config.lazy"
require "config.autocmd"

local set = vim.opt
local keymap = vim.keymap

set.shiftwidth = 4
set.tabstop = 4
set.number = true
set.relativenumber = true
set.clipboard = "unnamedplus"
set.hlsearch = false
set.incsearch = true
set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.termguicolors = true
set.signcolumn = "yes"

keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file" })
keymap.set("n", "<space>x", ":.lua<CR>", { desc = "Source current line" })
keymap.set("v", "<space>x", ":lua<CR>", { desc = "Source selection" })

keymap.set("n", "<space>pv", "<cmd>Explore<CR>", { desc = "Open Netrw" })

keymap.set("n", "<C-H>", "<C-W>h", { desc = "Focus left" })
keymap.set("n", "<C-J>", "<C-W>j", { desc = "Focus down" })
keymap.set("n", "<C-K>", "<C-W>k", { desc = "Focus up" })
keymap.set("n", "<C-L>", "<C-W>l", { desc = "Focus right" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

keymap.set("n", "n", "nzzzv", { desc = "Move to next match" })
keymap.set("n", "N", "Nzzzv", { desc = "Move to previous match" })
keymap.set("n", "J", "mzJ`z", { desc = "Join line below" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Substitute word under cursor" })
keymap.set("n", "<leader>S", "V:s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
  { desc = "Substitute word under cursor on current line" })
keymap.set("v", "<leader>s", "\"my:%s/\\<<C-r>m\\>/<C-r>m/gI<Left><Left><Left>",
  { desc = "Substitute selection" })
