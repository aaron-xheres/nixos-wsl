return {
    "simrat39/rust-tools.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local rust_tools = require("rust-tools")
        rust_tools.setup({
            server = {
                on_attach = function(_, bufnr)
                    vim.keymap.set(
                        "n",
                        "<C-Space>",
                        rust_tools.hover_actions.hover_actions,
                        { buffer = bufnr, desc = "Rust: Hover Actions" }
                    )
                end,
            },
        })
    end,
}
