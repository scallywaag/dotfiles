--
-- Highlight todo, notes, etc in comments
return {
  'folke/todo-comments.nvim',
  enabled = enabled 'todo_comments',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
}

-- TODO:
-- HACK:
-- WARN:
-- NOTE:
-- INFO:
-- PERF:
-- TEST:
-- FIX:
-- BUG:
-- ISSUE:
