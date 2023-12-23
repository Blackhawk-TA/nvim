local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

-- Split window
keymap('n', 'ss', ':split<CR><C-w>w', default_opts)
keymap('n', 'sv', ':vsplit<CR><C-w>w', default_opts)

-- Move window
keymap('n', 'sh', '<C-w>h', default_opts)
keymap('n', 'sk', '<C-w>k', default_opts)
keymap('n', 'sj', '<C-w>j', default_opts)
keymap('n', 'sl', '<C-w>l', default_opts)

-- Resize window
keymap('n', 'si', '<C-w>+', default_opts)
keymap('n', 'su', '<C-w>-', default_opts)
keymap('n', 'so', '<C-w><', default_opts)
keymap('n', 'sp', '<C-w>>', default_opts)

