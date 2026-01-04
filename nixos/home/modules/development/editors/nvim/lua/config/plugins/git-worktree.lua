return {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = {
        "seffradev/telescope.nvim",
    },
    config = function()
        telescope  = require("telescope")
        telescope.load_extension("git_worktree")
        worktree = telescope.extensions.git_worktree

        vim.keymap.set("n", "<leader>wtc", function()
            worktree.create_git_worktree()
        end, { desc = "Create Git Worktree" })

        vim.keymap.set("n", "<leader>wts", function()
            worktree.git_worktrees()
        end, { desc = "Switch Git Work tree" })
    end
}

