require("git-worktree").setup({
    fetch_on_create = false,
})

-- Bindings
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Show git status" })

-- git-worktree
vim.keymap.set("n", "<leader>wc", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", { desc = "Create Git Worktree" })
vim.keymap.set("n", "<leader>ws", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>", { desc = "Switch Git Worktree" })
