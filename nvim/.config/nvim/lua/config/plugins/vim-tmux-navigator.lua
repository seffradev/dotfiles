return {
  'christoomey/vim-tmux-navigator',
  enabled = true,
  lazy = false,
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigateProcessList",
  },
  keys = {
    { "<c-h>",  ":TmuxNavigateLeft<cr>" },
    { "<c-j>",  ":TmuxNavigateDown<cr>" },
    { "<c-k>",  ":TmuxNavigateUp<cr>" },
    { "<c-l>",  ":TmuxNavigateRight<cr>" },
    { "<c-\\>", ":TmuxNavigatePrevious<cr>" },
  },
}
