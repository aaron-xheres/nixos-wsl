-- Consts
local opt = vim.opt

-- ###

-- Vim Commands
vim.cmd("let g:netrw_liststyle = 3")

-- Line Numbers
opt.number = true

-- Tabs and Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.backspace = "indent,eol,start"

-- Search Settings
opt.ignorecase = true
opt.smartcase = true

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Appearance
opt.wrap = false
opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Split Windows
opt.splitright = true
opt.splitbelow = true
