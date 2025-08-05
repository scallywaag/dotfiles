return {
  'ray-x/lsp_signature.nvim',
  enabled = enabled 'lsp_signature',
  event = 'VeryLazy',
  opts = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    wrap = true,
    handler_opts = {
      border = 'single',
    },
    hint_enable = false,
    hi_parameter = 'LspSignatureActiveParameter',
    toggle_key = '<C-k>',
    toggle_key_flip_floatwin_setting = true,
  },
  config = function(_, opts)
    require('lsp_signature').setup(opts)
  end,
}
