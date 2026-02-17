return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        lazy = false,
        config = function()
            local harpoon = require"harpoon"
            harpoon:setup{}

            vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "Add current file to Harpoon list" })
            vim.keymap.set("n", "<leader>H", function() harpoon:list():select(1) end, { desc = "Switch to first Harpoon entry" })
            vim.keymap.set("n", "<leader>T", function() harpoon:list():select(2) end, { desc = "Switch to second Harpoon entry" })
            vim.keymap.set("n", "<leader>N", function() harpoon:list():select(3) end, { desc = "Switch to third Harpoon entry" })
            vim.keymap.set("n", "<leader>S", function() harpoon:list():select(4) end, { desc = "Switch to fourth Harpoon entry" })

            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open Harpoon quick menu" })

            local conf = require"telescope.config".values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require"telescope.pickers".new({}, {
                    prompt_title = "Harpoon",
                    finder = require"telescope.finders".new_table{
                        results = file_paths,
                    },
                    previewer = conf.file_previewer{},
                    sorter = conf.generic_sorter{},
                }):find()
            end

            vim.keymap.set("n", "<leader><C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Open Harpoon window" })
        end,
    },
}
