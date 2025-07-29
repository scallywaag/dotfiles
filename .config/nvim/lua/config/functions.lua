local R = {}

function R.simple_log_insert()
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

return R
