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

function R.show_diagnostic_float()
  local float_opts = {
    focus = false,
    border = 'single',
    scope = 'cursor',
  }
  local _, win = vim.diagnostic.open_float(nil, float_opts)

  if win then
    -- Close the diagnostic float when moving, leaving buffer, or entering insert
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'BufHidden', 'InsertEnter' }, {
      once = true,
      callback = function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end,
    })
  end
end

return R
