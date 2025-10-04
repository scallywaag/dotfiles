return {
  'folke/tokyonight.nvim',
  enabled = enabled 'tokyonight',
  priority = 1000, -- Make sure to load this before all the other start plugins.

  init = function()
    -- vim.cmd.colorscheme 'tokyonight-night'
    -- vim.cmd.colorscheme 'tokyonight-storm'
    vim.cmd.colorscheme 'tokyonight-moon'

    vim.cmd.hi 'Comment gui=none'

    -- blend it in nicely
    vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#292e42' })
    -- vim.api.nvim_set_hl(0, 'ColorColumn', { bg = '#191924' })
  end,
}
