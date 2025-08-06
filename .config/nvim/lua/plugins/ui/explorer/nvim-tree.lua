return {
  'nvim-tree/nvim-tree.lua',
  enabled = enabled 'nvim_tree',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },

  config = function()
    require('nvim-tree').setup {
      update_focused_file = {
        enable = true,
      },
    }
  end,

  vim.keymap.set('n', '<leader>te', ':NvimTreeToggle<CR>', { desc = 'Explorer' }),
}
