return {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")

        -- Keymaps
        local keymap = vim.keymap

        keymap.set("n", "]t", function()
            todo_comments.jump_next()
        end, { desc = "Todo: Next" })

        keymap.set("n", "[t", function()
            todo_comments.jump_prev()
        end, { desc = "Todo: Previous" })

        todo_comments.setup()
    end,
}
