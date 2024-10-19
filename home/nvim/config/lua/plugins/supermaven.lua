return {
  "supermaven-inc/supermaven-nvim",
  config = function()
    require("supermaven-nvim").setup({
      keymaps = {
        accept_suggestion = "<Tab>",
        clear_suggestion = "<C-Tab>",
        accept_word = "<C-a>",
      },
      disable_inline_completion = true,
    })
  end,
}
