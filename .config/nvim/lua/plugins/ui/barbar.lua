return {
  'romgrk/barbar.nvim',
  enabled = enabled 'barbar',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  config = function()
    require('barbar').setup {
      auto_hide = false,
      animation = false,
      no_name_title = nil,
      sidebar_filetypes = {
        NvimTree = true,
      },
    }

    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
    map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)

    map('n', '<A-S-.>', '<Cmd>BufferMoveNext<CR>', opts)
    map('n', '<A-S-,>', '<Cmd>BufferMovePrevious<CR>', opts)

    map('n', '<A-q>', '<Cmd>BufferClose<CR>', opts)
    map('n', '<C-A-q>', '<Cmd>BufferCloseAllButCurrent<CR>', opts)
    map('n', '<C-A-,>', '<Cmd>BufferCloseBuffersLeft<CR>', opts)
    map('n', '<C-A-.>', '<Cmd>BufferCloseBuffersRight<CR>', opts)

    -- map('n', '<leader>ad', '<Cmd>BufferPickDelete<CR>', opts)
    -- map('n', '<leader>aj', '<Cmd>BufferNext<CR>', opts)
    -- map('n', '<leader>ak', '<Cmd>BufferPrevious<CR>', opts)

    -- When entering insert mode or saving file, mark buffer as edited once
    vim.api.nvim_create_autocmd({ 'InsertEnter', 'BufWritePost' }, {
      callback = function(args)
        vim.api.nvim_buf_set_var(args.buf, 'edited_once', true)
        vim.api.nvim_set_option_value('buflisted', true, { scope = 'local', buf = args.buf })
      end,
    })

    -- When leaving buffer, check if it was ever edited
    vim.api.nvim_create_autocmd('BufLeave', {
      callback = function(args)
        local bufnr = args.buf
        local edited_once = false
        -- try to get the var safely
        local ok, val = pcall(vim.api.nvim_buf_get_var, bufnr, 'edited_once')
        if ok then
          edited_once = val
        end

        if not edited_once then
          vim.api.nvim_set_option_value('buflisted', false, { scope = 'local', buf = bufnr })
        else
          vim.api.nvim_set_option_value('buflisted', true, { scope = 'local', buf = bufnr })
        end
      end,
    })
  end,
  version = '^1.0.0',
}
