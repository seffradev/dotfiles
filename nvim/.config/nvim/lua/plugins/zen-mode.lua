return {
    "folke/zen-mode.nvim",
    dependencies = {
        "folke/twilight.nvim",
    },
    opts = {
        window = {
            width = 90,
            backdrop = 1,
            options = {
                signcolumn = "no",  -- disable signcolumn
                number = true,     -- disable number column
                relativenumber = false, -- disable relative numbers
                cursorline = false, -- disable cursorline
                cursorcolumn = false, -- disable cursor column
                foldcolumn = "0",   -- disable fold column
                list = false,       -- disable whitespace characters
            },
        },
    },
}
