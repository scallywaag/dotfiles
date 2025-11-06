local funcs = require 'config.functions'

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Toggle line numbering
vim.keymap.set('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = 'Relative line numbering' })

-- Zen mode
vim.keymap.set('n', '<leader>mz', ':Zen<CR>', { desc = 'Zen Mode' })

vim.keymap.set('n', '<leader>ml', funcs.simple_log_insert, { desc = 'Log Message' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w>W', { desc = 'Move focus to the previous window' })
vim.keymap.set('n', '<C-l>', '<C-w>w', { desc = 'Move focus to the next window' })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<C-`>', '<Cmd>wincmd t<CR>', { desc = 'Go to first (top-left) window' })
vim.keymap.set('n', '<C-=>', '<Cmd>vertical resize +20<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-->', '<Cmd>vertical resize -20<CR>', { desc = 'Decrease window width' })

vim.keymap.set('n', '<leader>d', funcs.show_diagnostic_float, { desc = 'Show diagnostics float' })

-- Toggle cursorcolumn
vim.keymap.set('n', '<leader>tk', function()
  vim.opt.cursorcolumn = not vim.opt.cursorcolumn:get()
end, { desc = 'Toggle cursorcolumn' })

-- Toggle list (show whitespace characters)
vim.keymap.set('n', '<leader>tl', function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = 'Toggle listchars' })
