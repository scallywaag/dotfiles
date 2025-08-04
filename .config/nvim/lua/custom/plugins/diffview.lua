return {
  {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('diffview').setup {
        file_panel = {
          win_config = {
            position = 'left',
          },
        },
      }
    end,
  },
}
