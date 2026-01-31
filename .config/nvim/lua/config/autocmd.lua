-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
-- vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
--   command = "if mode() != 'c' | checktime | endif",
--   pattern = { '*' },
-- })
--
--

-- Triger `autoread` when files changes on disk
-- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mod
vim.o.autoread = true
vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'CursorHoldI' }, {
  pattern = '*',
  command = "if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})

vim.api.nvim_create_autocmd(
  { 'FileChangedShellPost' },
  { command = 'echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None', pattern = { '*' } }
)

-- Delete default lsp keymaps
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('CustomLspCleanup', { clear = true }),
  callback = function(args)
    vim.schedule(function()
      local buf = args.buf

      -- List of bindings to remove
      local to_delete = {
        { 'n', 'grn' },
        { 'n', 'gra' },
        { 'v', 'gra' },
        { 'n', 'grr' },
        { 'n', 'gri' },
        { 'n', 'grt' },
        { 'n', 'gO' },
        { 'v', 'an' },
        { 'v', 'in' },
      }

      for _, map in ipairs(to_delete) do
        local mode, lhs = unpack(map)
        pcall(vim.keymap.del, mode, lhs, { buffer = buf })
      end
    end)
  end,
})

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
