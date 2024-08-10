require("git-worktree").setup({
    fetch_on_create = false,
})

-- Bindings
local wk = require("which-key")

wk.add({
    { "<leader>g",  group = "Git",  desc = "Git",             nowait = true, remap = false },
    { "<leader>gs", "<cmd>Git<cr>", desc = "Show git status", nowait = true, remap = false },
})

--- git-worktree
wk.add({
    { "<leader>w",  group = "Worktree",                                                                desc = "",       nowait = true, remap = false },
    { "<leader>wc", "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>", desc = "Create", nowait = true, remap = false },
    { "<leader>ws", "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",       desc = "Switch", nowait = true, remap = false },
})
