function OpenOrCreateNotes()
  local notes_path = './notes.md'
  if vim.fn.filereadable(notes_path) == 0 then
    vim.cmd('silent !touch ' .. notes_path)
    print('Created ' .. notes_path)
  end
  vim.cmd('e ' .. notes_path)
end

-- Open (create if necessary) a notes file in the cwd
vim.keymap.set('n', '<leader>n', OpenOrCreateNotes, { desc = 'Open [N]otes file', noremap = true, silent = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Toggle line numbering
vim.keymap.set('n', '<leader>tr', function()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = '[R]elative line numbering' })

-- Zen mode
vim.keymap.set('n', '<leader>mz', ':Zen<CR>', { desc = '[Z]en Mode' })
