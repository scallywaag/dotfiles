-- [[ Define enabled plugins ]]
local plugin_enabled = {
  -- autocompletion
  blink_cmp = true,
  nvim_cmp = false,

  -- debug
  debug = false,

  -- formatting
  autoformat = true,
  autopairs = false,
  splitjoin = false,

  -- fzf
  fzf_lua = false,
  telescope = true,

  -- git
  diffview = true,
  gitsigns = true,
  vim_fugitive = true,

  -- indentation
  guess_indent = false,
  indent_line = false,
  vim_sleuth = true,

  -- linting
  lint = false,

  -- lsp
  lazydev = true,
  lsp = true,
  lsp_signature = false,
  trouble = true,

  -- misc
  colorizer = true,
  luvit = true,
  mini = true,
  flash = true,
  peek = false,
  todo_comments = true,
  which_key = true,

  -- syntax
  treesitter = true,

  -- themes
  tokyonight = true,

  -- ui
  neo_tree = false,
  nvim_tree = true,
  barbar = false,
  oil = true,
  zenmode = true,

  --
  -- experimental
  undotree = false,
  love = true,
}

_G.plugin_enabled = plugin_enabled

function _G.enabled(name)
  return plugin_enabled[name] == true
end
