return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
    end,
  },
}
