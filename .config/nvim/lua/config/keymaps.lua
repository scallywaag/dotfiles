local funcs = require 'config.functions'

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Toggle line numbering
vim.keymap.set('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Relative line numbering' })

-- Zen mode
vim.keymap.set('n', '<leader>mz', ':Zen<CR>', { desc = 'Zen Mode' })

vim.keymap.set('n', '<leader>l', funcs.simple_log_insert, { desc = 'Log Message' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
