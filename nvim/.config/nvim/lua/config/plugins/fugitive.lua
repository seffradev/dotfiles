return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<space>gs", "<cmd>Git<CR>", { desc = "Git status" })
    end,
  },
}
