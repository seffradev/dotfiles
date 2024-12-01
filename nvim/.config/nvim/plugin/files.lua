-- Bindings
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Show project view" })

--- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add current file to Harpoon list" })
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })
vim.keymap.set("n", "<A-h>", function() ui.nav_file(1) end, { desc = "Go to 1st marked file" })
vim.keymap.set("n", "<A-j>", function() ui.nav_file(2) end, { desc = "Go to 2nd marked file" })
vim.keymap.set("n", "<A-k>", function() ui.nav_file(3) end, { desc = "Go to 3rd marked file" })
vim.keymap.set("n", "<A-l>", function() ui.nav_file(4) end, { desc = "Go to 4th marked file" })
