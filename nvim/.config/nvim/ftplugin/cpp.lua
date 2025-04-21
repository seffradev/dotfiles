---@diagnostic disable-next-line: missing-fields
require "mason-lspconfig".setup { ensure_installed = { "clangd" } }

vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

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
