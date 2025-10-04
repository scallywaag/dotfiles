return {
  -- autocompletion
  require 'plugins.autocompletion.blink-cmp',
  require 'plugins.autocompletion.nvim-cmp',

  -- debug
  require 'plugins.debug.debug',

  -- formatting
  require 'plugins.formatting.autoformat',
  require 'plugins.formatting.autopairs',
  require 'plugins.formatting.splitjoin',

  -- fzf
  require 'plugins.fzf.fzf-lua',
  require 'plugins.fzf.telescope',

  -- git
  require 'plugins.git.diffview',
  require 'plugins.git.gitsigns',
  require 'plugins.git.vim-fugitive',

  -- indentation
  require 'plugins.indentation.guess-indent', -- faster than sleuth but buggy atm
  require 'plugins.indentation.indent-line',
  require 'plugins.indentation.vim-sleuth', -- detect tabstop and shiftwidth automatically

  -- linting
  require 'plugins.linting.lint',

  -- lsp
  require 'plugins.lsp.lazydev',
  require 'plugins.lsp.lsp',
  require 'plugins.lsp.lsp-signature',
  require 'plugins.lsp.trouble',

  -- misc
  require 'plugins.misc.colorizer',
  require 'plugins.misc.luvit-meta',
  require 'plugins.misc.mini', -- statusline, better around/inside obj, surround
  require 'plugins.misc.flash',
  require 'plugins.misc.peek', -- markdown preview
  require 'plugins.misc.todo-comments',
  require 'plugins.misc.which-key',

  -- syntax
  require 'plugins.syntax.treesitter',

  -- themes
  require 'plugins.themes.tokyo',

  -- ui
  require 'plugins.ui.explorer.neo-tree',
  require 'plugins.ui.explorer.nvim-tree',
  require 'plugins.ui.oil',
  require 'plugins.ui.zen-mode',

  --
  -- plugins I plan on trying out - not integrated in config yet
  require 'plugins.experimental.undotree',
  require 'plugins.experimental.love',
}
