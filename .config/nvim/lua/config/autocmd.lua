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

-- vim.api.nvim_create_autocmd('BufWritePre', {
--   pattern = '*.go',
--   callback = function()
--     -- Format the file
--     vim.lsp.buf.format { async = false }
--
--     -- Organize imports via gopls code action
--     vim.lsp.buf.code_action {
--       context = { only = { 'source.organizeImports' }, diagnostics = {} },
--       apply = true,
--     }
--   end,
-- })

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' }, diagnostics = {} }

    local result = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 3000)
    for cid, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, vim.lsp.get_client_by_id(cid).offset_encoding)
        elseif action.command then
          vim.lsp.buf.execute_command(action.command)
        end
      end
    end

    -- Format after organizing imports
    vim.lsp.buf.format { async = false }
  end,
})
