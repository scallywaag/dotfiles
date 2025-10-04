local default_lsp_keys = {
  { 'n', 'grn' },
  { 'n', 'gra' },
  { 'v', 'gra' },
  { 'n', 'grr' },
  { 'n', 'gri' },
  { 'n', 'grt' },
  { 'n', 'gO' },
  { 'i', '<C-s>' },
  { 'v', 'an' },
  { 'v', 'in' },
}

for _, map in ipairs(default_lsp_keys) do
  local mode, lhs = unpack(map)
  pcall(vim.keymap.del, mode, lhs)
end
