return {
  'catppuccin/nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.

  config = function()
    require('catppuccin').setup()
    -- vim.cmd.colorscheme 'catppuccin-macchiato'
    -- vim.cmd.colorscheme 'catppuccin-frappe'
    vim.cmd.colorscheme 'catppuccin-mocha'

    vim.cmd.hi 'Comment gui=none'
  end,
}
