--[[

          _~
       _~ )_)_~
       )_))_))_)
       _!__!__!_
       \______t/
     ~~~~~~~~~~~~~
  
--]]

require 'config'
require('lazy').setup {
  require 'plugins',
}
require 'config.custom_colors'

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'markdown',
--   group = vim.api.nvim_create_augroup('CustomMarkdownColors', { clear = true }),
--   callback = function()
--     local colors = {
--       { fg = '#000000', bg = '#d0d0d0' }, -- Black
--       { fg = '#fc7b7b', bg = '#382f48' }, -- Bright Red
--       { fg = '#c3e88d', bg = '#32363f' }, -- Bright Green
--       { fg = '#ffc777', bg = '#38314d' }, -- Bright Yellow
--       { fg = '#82b3ff', bg = '#2c3043' }, -- Bright Blue
--       { fg = '#c099ff', bg = '#32304a' }, -- Bright Magenta
--       { fg = '#4fd6be', bg = '#273144' }, -- Bright Cyan
--       { fg = '#ffffff', bg = '#1a1a1a' }, -- White
--     }
--
--     for i = 0, 7 do
--       vim.cmd(string.format('syntax match mdColor%d /#%d\\s.*$/ contains=mdColor%dMarker', i, i, i))
--       vim.cmd(string.format('syntax match mdColor%dMarker /#%d\\s/ contained conceal', i, i))
--       vim.cmd(string.format('highlight mdColor%d guifg=%s guibg=%s gui=bold', i, colors[i + 1].fg, colors[i + 1].bg))
--     end
--   end,
-- })
