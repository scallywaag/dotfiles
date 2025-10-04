return {
  'norcalli/nvim-colorizer.lua',
  enabled = enabled 'colorizer',
  opts = {},
  config = function()
    -- skip setup so it's disabled by default
    -- require('colorizer').setup()
    vim.keymap.set('n', '<leader>tc', ':ColorizerToggle<CR>', { desc = 'Colorizer' })
  end,
}
