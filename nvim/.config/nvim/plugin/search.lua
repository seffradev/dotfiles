local telescope = require("telescope")

telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("git_worktree")

-- Bindings
local wk = require("which-key")

--- Telescope
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
