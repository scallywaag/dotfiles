return {
  'ibhagwan/fzf-lua',
  enabled = enabled 'fzf_lua',
  event = 'VimEnter',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = 'horizontal',
          horizontal = 'right:60%',
        },
      },
      fzf_opts = {
        -- space-separated AND matching
        ['--ansi'] = '',
        ['--info'] = 'inline',
        ['--layout'] = 'default',
        ['--multi'] = '',
        ['--reverse'] = '',
        ['--marker'] = '>',
        ['--prompt'] = '❯ ',
      },
      files = {
        prompt = 'Files❯ ',
        fd_opts = '--color=never --type f --hidden --follow --exclude .git',
      },
      grep = {
        prompt = 'Grep❯ ',
        rg_opts = '--color=never --no-heading --with-filename --line-number --column --smart-case',
      },
    }

    -- Keymaps (Telescope -> fzf-lua equivalents)
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[F]iles' })
    vim.keymap.set('n', '<leader>sa', function()
      fzf.files { fd_opts = '--color=never --type f --hidden --follow --no-ignore --exclude .git' }
    end, { desc = '[A]ll Files (no ignore)' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep_native, { desc = '[G]rep' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Grep Current [W]ord' })
    vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]elect FZF-Lua Picker' })
    vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[H]elp Tags' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[K]eymaps' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[R]esume' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = 'Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find Buffers' })

    vim.keymap.set('n', '<leader>/', function()
      fzf.blines { prompt = 'Buffer❯ ', winopts = { preview = { hidden = 'hidden' } } }
    end, { desc = '[/] Search in Current Buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      fzf.live_grep_glob { prompt = 'Grep Open Files❯ ', grep_open_files = true }
    end, { desc = '[/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[N]eovim config files' })
  end,
}
