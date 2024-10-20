return {
    "rmagatti/auto-session",
    config = function()
        require("auto-session").setup({
            auto_restore_enabled = false,
            auto_session_suppress_dirs = { "~/" },
        })

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>wr", "<cmd>SessionRestore<cr>", { desc = "Session: Restore" })
        keymap.set("n", "<leader>ws", "<cmd>SessionSave<cr>", { desc = "Session: Save" })
    end,
}
