return {
    'folke/zen-mode.nvim',
    config = function()
        local toggle = function()
            require "zen-mode".toggle {
                window = {
                    width = 80,
                    options = {
                        signcolumn = "no",
                        number = false,
                        relativenumber = false,
                        cursorline = false,
                        cursorcolumn = false,
                        foldcolumn = "0",
                        list = false,
                    },
                },
                plugins = {
                    tmux = {
                        enabled = true,
                    },
                    kitty = {
                        enabled = true,
                    },
                },
            }
        end

        vim.keymap.set("n", "<leader>zm", toggle, { desc = "Toggle Zen Mode" })
    end
}
