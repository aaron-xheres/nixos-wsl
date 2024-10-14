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
    if os.execute("command -v node") == 0 then
      table.insert(ensure_installed_ls, "ts_ls")
      table.insert(ensure_installed_ls, "cssls")
      table.insert(ensure_installed_ls, "tailwindcss")
      table.insert(ensure_installed_fmt, "prettier")
      table.insert(ensure_installed_fmt, "eslint_d")
    end

    if os.execute("command -v python") == 0 then
      table.insert(ensure_installed_ls, "pyright")
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
