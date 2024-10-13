return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    -- Header
    dashboard.section.header.val = {
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
    }


    -- Menu
    dashboard.section.buttons.val = {
      dashboard.button( "a", "  > New file" , "<cmd>ene<cr>"),
      dashboard.button( "e", "  > Open Explorer" , "<cmd>NvimTreeToggle<cr>"),
      dashboard.button( "f", "󰈞  > Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button( "s", "󱎸  > Find text"   , "<cmd>Telescope live_grep<cr>"),
      dashboard.button( "r", "  > Recent files" , "<cmd>Telescope oldfiles<cr>"),
      dashboard.button( "w", "  > Restore Session", "<cmd>SessionRestore<cr>"),
    }

    require("alpha").setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
