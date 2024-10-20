return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
        require("toggleterm").setup({
            size = 8,
            open_mapping = [[~]],
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            insert_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "single",
                title_pos = "left",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
    end,
}
