return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Default Langauge Servers (without external dependencies)
    local ensure_installed_ls = {
      "lua_ls",
    }

    -- Default Formatters (without external dependencies)
    local ensure_installed_fmt = {
      "stylua",
    }

    -- Check if specific bin exists, then ensure specific configs
    -- NodeJS
    if vim.cmd("silent! node -v") == 0 then
      -- Langauge Server(s)
      table.insert(ensure_installed_ls, "ts_ls")
      table.insert(ensure_installed_ls, "cssls")
      table.insert(ensure_installed_ls, "tailwindcss")
      -- Linter(s) / Formatter(s)
      table.insert(ensure_installed_fmt, "prettier")
      table.insert(ensure_installed_fmt, "eslint_d")
    end

    if vim.cmd("silent! python -V") == 0 then
      -- Langauge Server(s)
      table.insert(ensure_installed_ls, "pyright")
      -- Linter(s) / Formatter(s)
      table.insert(ensure_installed_fmt, "isort")
      table.insert(ensure_installed_fmt, "black")
      table.insert(ensure_installed_fmt, "pylint")
    end

    if vim.cmd("silent! cargo -V") == 0 then
      -- Langauge Server(s)
      table.insert(ensure_installed_ls, "nil_ls")
      table.insert(ensure_installed_ls, "rust_analyzer")
      -- Linter(s) / Formatter(s)
      table.insert(ensure_installed_fmt, "nixpkgs-fmt")
      table.insert(ensure_installed_fmt, "rustfmt")
    end
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed_ls,
    })

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed_fmt,
    })
  end,
}
