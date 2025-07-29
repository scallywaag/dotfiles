--[[

          _~
       _~ )_)_~
       )_))_))_)
       _!__!__!_
       \______t/
     ~~~~~~~~~~~~~
  
--]]

require 'config.autocmd'
require 'config.options'
require 'config.keymaps'

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
  require 'kickstart.plugins.lazydev',
  require 'kickstart.plugins.luvit-meta',
  require 'kickstart.plugins.gitsigns',
  require 'kickstart.plugins.vim-sleuth',
  require 'kickstart.plugins.vim-fugitive',
  require 'kickstart.plugins.autocompletion',
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.fzf-telescope',
  require 'kickstart.plugins.lsp',
  require 'kickstart.plugins.mini', -- contains statusline
  require 'kickstart.plugins.todo-comments',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.which-key',
  require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

  require 'custom.plugins.colorizer',
  require 'custom.plugins.explorer-nvim-tree',
  require 'custom.plugins.motion-flash',
  require 'custom.plugins.oil',
  require 'custom.plugins.peek',
  require 'custom.plugins.theme-tokyo',
  require 'custom.plugins.trouble',
  require 'custom.plugins.zen-mode',
  -- require 'custom.plugins.fzf-lua',
  -- require 'custom.plugins.splitjoin',
  -- require 'custom.plugins.undotree',
  -- require 'custom.plugins.lsp-signature',
}
