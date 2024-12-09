return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"

      configs.setup {
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "vim",
          "vimdoc",
        },

        sync_install = false,
        auto_install = false,
        ignore_install = {},
        modules = {},

        highlight = {
          enable = true,

          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            ---@diagnostic disable-next-line: undefined-field
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          additional_vim_regex_highlighting = false,
        }
      }
    end
  },
}
