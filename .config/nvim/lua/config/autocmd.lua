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
