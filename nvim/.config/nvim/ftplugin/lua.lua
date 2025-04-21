---@diagnostic disable-next-line: missing-fields
require "mason-lspconfig".setup { ensure_installed = { "lua_ls" } }

local set = vim.opt_local

set.shiftwidth = 2
set.tabstop = 2

vim.lsp.enable("lua_ls")
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
          "${3rd}/busted/library",
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
