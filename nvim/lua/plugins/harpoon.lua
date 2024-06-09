return {
    "ThePrimeagen/harpoon",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        vim.keymap.set("n", "<leader>a", mark.add_file, { desc = "Add current file to Harpoon list" })
        vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon quick menu" })

        vim.keymap.set("n", "<C-t>", function() ui.nav_file(1) end, { desc = "Go to 1st marked file" })
        vim.keymap.set("n", "<C-n>", function() ui.nav_file(2) end, { desc = "Go to 2nd marked file" })
        vim.keymap.set("n", "<C-s>", function() ui.nav_file(3) end, { desc = "Go to 3rd marked file" })
    end
}
