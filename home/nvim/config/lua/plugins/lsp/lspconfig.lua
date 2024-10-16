return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    { "folke/neodev.nvim", opt = {} },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf, silent = true }

        -- Keymaps
        opts.desc = "LSP: Show references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<cr>", opts)

        opts.desc = "LSP: Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "LSP: Show definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", opts)

        opts.desc = "LSP: Show implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", opts)

        opts.desc = "LSP: Show type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", opts)

        opts.desc = "LSP: Available Code Actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "LSP: Smart Rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "LSP: Show cursor documentation"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "LSP: Restart"
        keymap.set("n", "<leader>rs", "<cmd>LspRestart<cr>", opts)

        opts.desc = "Diagnostics: Buffer"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<cr>", opts)

        opts.desc = "Diagnostics: Line"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Diagnostics: Next"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

        opts.desc = "Diagnostics: Previous"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      end,
    })

    -- LSp Auto-completion
    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup_handlers({
      -- Default handler
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
