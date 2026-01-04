vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
    ensure_installed = {
        "cpp",
    },
}

-- local sonarlint = require "sonarlint"
-- sonarlint.setup {
--   server = {
--     cmd = {
--       'sonarlint-ls',
--       '-stdio',
--     },
--   },
--   filetypes = {
--     'cpp',
--   }
-- }
