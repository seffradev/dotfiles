-- Bindings
local wk = require("which-key")

wk.add({
    { "<leader>p",  group = "Project", desc = "",                  nowait = true, remap = false },
    { "<leader>pv", vim.cmd.Ex,        desc = "Show project view", nowait = true, remap = false },
})

--- Harpoon
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

wk.add({
    { "<leader>a", mark.add_file,                 desc = "Add current file to Harpoon list" },
    { "<C-e>",     ui.toggle_quick_menu,          desc = "Toggle Harpoon quick menu" },
    { "<C-t>",     function() ui.nav_file(1) end, desc = "Go to 1st marked file" },
    { "<C-n>",     function() ui.nav_file(2) end, desc = "Go to 2nd marked file" },
    { "<C-s>",     function() ui.nav_file(3) end, desc = "Go to 3rd marked file" },
})
