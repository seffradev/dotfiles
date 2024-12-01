local wk = require("which-key")

wk.add({
    { "<leader>f", group = "Find", desc = "", nowait = true, remap = false },
})

local telescope = require("telescope")

telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("git_worktree")

-- Bindings
-- Telescope
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find project files" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find project diagnostics" })
vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>fs", function()
    builtin.grep_string({ search = vim.fn.input("search: ") });
end, { desc = "Search project file contents" })
