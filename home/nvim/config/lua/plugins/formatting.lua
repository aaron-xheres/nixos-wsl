return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- Shell
                sh = { "shfmt" },
                zsh = { "shfmt" },
                bash = { "shfmt" },
                -- Rust
                rust = { "rustfmt" },
                -- Nix
                nix = { "nixfmt" },
                -- Web Development Languages
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typeascriptreact = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                -- Lua
                lua = { "stylua" },
                -- Python
                python = { "isort", "black" },
                -- Object Languages
                json = { "prettier" },
                yaml = { "prettier" },
                -- Markdown
                markdown = { "prettier" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format: File or Visual Selection" })
    end,
}
