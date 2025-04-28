return {
  'norcalli/nvim-colorizer.lua',
  opts = {},
  config = function()
    -- skip setup so it's disabled by default
    -- require('colorizer').setup()
    vim.keymap.set('n', '<leader>tc', ':ColorizerToggle<CR>', { desc = '[C]olorizer' })
  end,
}
