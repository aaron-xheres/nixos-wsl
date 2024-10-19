return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- Default Langauge Servers (installable with default setup)
    local ensure_installed_ls = {
      "lua_ls",
      "nil_ls",
      "rust_analyzer",
      "ts_ls",
      "cssls",
      "tailwindcss",
    }

    -- Default Formatters (installable with default setup)
    local ensure_installed_fmt = {
      "stylua",
      "nixpkgs-fmt",
      "prettier",
      "eslint_d",
    }

    -- Check if specific bin exists, then ensure specific configs
    local function isCommandExitOk(cmd)
      vim.fn.system(cmd)
      return vim.v.shell_error == 0
    end

    -- Python
    if isCommandExitOk("python -V") then
      -- Langauge Server(s)
      table.insert(ensure_installed_ls, "pyright")
      -- Linter(s) / Formatter(s)
      table.insert(ensure_installed_fmt, "isort")
      table.insert(ensure_installed_fmt, "black")
      table.insert(ensure_installed_fmt, "pylint")
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
