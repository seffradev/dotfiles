return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.load_extension("git_worktree")

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find project files" })
        vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find git files" })
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({ search = vim.fn.input("search: ") });
        end, { desc = "Search project file contents" })
    end
}
