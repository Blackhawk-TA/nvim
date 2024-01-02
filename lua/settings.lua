vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Search settings
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Indentation
vim.o.autoindent = true
vim.o.smartindent = true

-- Indentation visibility settings
vim.o.hidden = true
vim.o.list = true
vim.o.listchars = "tab:│ ,space:·"

-- Code folding
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false

-- Display settings
vim.o.ruler = true
vim.o.confirm = true
vim.o.laststatus = 2
vim.o.showmode = true
vim.o.showcmd = true

-- Tab settings
vim.o.tabstop = 4
vim.o.softtabstop = 0
vim.o.shiftwidth = 4
vim.o.smarttab = true

-- Encoding and file format
vim.o.encoding = "utf-8"
vim.o.fileformat = "unix"
vim.o.fileformats = "unix,dos"

-- Clipboard
vim.o.clipboard = "unnamed,unnamedplus"

-- Enable mouse features
vim.o.mouse = "a"

-- Save handling
vim.o.undofile = true
vim.o.autowrite = true

-- Spellcheck
vim.o.syntax = "enable"
vim.o.spelllang = "en,de"
vim.o.spell = true

