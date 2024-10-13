return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
  opts = {},
  cmd = "Trouble",
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: Toggle List" },
    { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Trouble: Open document diagnostics" },
    { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>", desc = "Trouble: Open Quickfix list" },
    { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Trouble: Open location list" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Trouble: Open Todos list" },
  },
}
