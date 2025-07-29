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
