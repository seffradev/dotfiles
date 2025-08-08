local set = vim.opt_local

set.linebreak = true
set.wrap = true

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "markdown",
        "markdown_inline",
    },
}
