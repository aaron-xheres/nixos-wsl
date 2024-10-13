return {
  "rebelot/kanagawa.nvim",
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      commentStyle= { italic = true},
      functionStyle = {},
      keywordStyle = {},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,
      terminalColors = true,
      theme = "dragon",
    })

    vim.cmd("colorscheme kanagawa")
  end,
}
