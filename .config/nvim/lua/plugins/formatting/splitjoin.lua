return {
  'Wansmer/treesj',
  enabled = enabled 'splitjoin',
  keys = { '<leader>m', '<leader>j', '<leader>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup {--[[ your config ]]
    }
  end,
}
