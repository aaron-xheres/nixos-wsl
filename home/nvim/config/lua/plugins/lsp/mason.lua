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
      "nil_ls",
    }

    -- Default Formatters (without external dependencies)
    local ensure_installed_fmt = {
      "stylua",
      "nixpkgs-fmt",
    }

    -- Check if specific bin exists, then ensure specific configs
    local function isCommandExitOk(cmd)
      vim.fn.system(cmd)
      return vim.v.shell_error == 0
    end

    -- NodeJS
    if isCommandExitOk("node -v") then
      -- Langauge Server(s)
      table.insert(ensure_installed_ls, "ts_ls")
      table.insert(ensure_installed_ls, "cssls")
      table.insert(ensure_installed_ls, "tailwindcss")
      -- Linter(s) / Formatter(s)
      table.insert(ensure_installed_fmt, "prettier")
      table.insert(ensure_installed_fmt, "eslint_d")
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
