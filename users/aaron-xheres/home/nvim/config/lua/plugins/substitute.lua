return {
  "gbprod/substitute.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local substitute = require("substitute")
    substitute.setup()

    -- Keymaps
    local keymap = vim.keymap

    vim.keymap.set("n", "s", substitute.operator, { desc = "Substitute: Motion" })
    vim.keymap.set("n", "ss", substitute.line, { desc = "Substitute: Line" })
    vim.keymap.set("n", "S", substitute.eol, { desc = "Substitute: End of line" })
    vim.keymap.set("x", "s", substitute.visual, { desc = "Substitute: Visual Mode" })
  end
}
