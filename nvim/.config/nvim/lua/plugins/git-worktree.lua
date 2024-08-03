return {
    "seffradev/git-worktree.nvim",
    config = function()
        require("git-worktree").setup({
            fetch_on_create = false,
        })
    end
}
