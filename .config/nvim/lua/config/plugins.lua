-- [[ Define enabled plugins ]]
local plugin_enabled = {
  -- kickstart
  lazydev = true, -- desc of what each does maybe
  luvit = true,
  gitsigns = true,
  vim_fugitive = true,
  blink_cmp = true,
  nvim_cmp = false,
  autoformat = true,
  fzf_telescope = true,
  lsp = true,
  mini = true,
  todo_comments = true,
  treesitter = true,
  which_key = true,
  debug = false,
  vim_sleuth = true, -- Detect tabstop and shiftwidth automatically
  guess_indent = false, -- Tabstops, faster but a more buggy than vim_sleuth
  indent_line = false, -- Add indentation guides even on blank lines
  lint = false,
  autopairs = false,
  neo_tree = false,

  -- custom
  colorizer = true,
  nvim_tree = true,
  flash = true,
  oil = true,
  peek = false,
  tokyonight = true,
  trouble = true,
  zenmode = true,
  diffview = true,
  fzf_lua = false,
  splitjoin = false,
  undotree = false,
  lsp_signature = false,
  barbar = false,
}

_G.plugin_enabled = plugin_enabled

function _G.enabled(name)
  return plugin_enabled[name] == true
end
