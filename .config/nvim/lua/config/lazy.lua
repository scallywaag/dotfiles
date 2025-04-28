local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true },

  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-fugitive',
  'folke/zen-mode.nvim',

  require 'custom.plugins.autocompletion',
  require 'custom.plugins.autoformat',
  require 'custom.plugins.colorizer',
  require 'custom.plugins.explorer-nvim-tree',
  require 'custom.plugins.fzf-telescope',
  -- require 'custom.plugins.fzf-lua',
  require 'custom.plugins.lsp',
  require 'custom.plugins.mini', -- contains statusline
  require 'custom.plugins.motion-flash',
  require 'custom.plugins.oil',
  require 'custom.plugins.peek',
  -- require 'custom.plugins.splitjoin',
  require 'custom.plugins.theme-tokyo',
  require 'custom.plugins.todo-comments',
  require 'custom.plugins.treesitter',
  require 'custom.plugins.trouble',
  -- require 'custom.plugins.undotree',
  require 'custom.plugins.which-key',
  -- require 'custom.plugins.lsp-signature',

  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
}
