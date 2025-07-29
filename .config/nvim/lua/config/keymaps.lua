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

local function simple_log_insert()
  local ft = vim.bo.filetype
  local statement

  if ft == 'go' then
    statement = 'fmt.Println()'
  elseif ft == 'javascript' or ft == 'typescript' then
    statement = 'console.log()'
  elseif ft == 'python' then
    statement = 'print()'
  else
    statement = 'print()'
  end

  -- Insert on new line below and place cursor inside ()
  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row, row, false, { statement })

  -- Position cursor inside the ()
  local col = #statement - 1 -- before the closing parenthesis
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
  vim.cmd 'startinsert'
end

vim.keymap.set('n', '<leader>l', simple_log_insert, { desc = 'Log Message' })
