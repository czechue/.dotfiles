-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Multiple cursors plugin (like IntelliJ's Ctrl-G)
  -- Commented out - not working well
  -- {
  --   'smoka7/multicursors.nvim',
  --   event = 'VeryLazy',
  --   dependencies = { 'nvimtools/hydra.nvim' },
  --   opts = {},
  --   keys = {
  --     {
  --       mode = { 'v', 'n' },
  --       '<C-g>',
  --       '<cmd>MCstart<cr>',
  --       desc = 'Create multiple cursors for selected text or word under cursor',
  --     },
  --   },
  -- },

  -- Markdown rendering plugin
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    ft = 'markdown',
    opts = {},
  },

  -- LazyGit integration
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  -- Harpoon 2 - Quick file navigation for working set
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>a', function() require('harpoon'):list():add() end, desc = 'Harpoon: Add file' },
      { '<leader>h', function()
        local harpoon = require('harpoon')
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, desc = 'Harpoon: Menu' },
      { '<leader>1', function() require('harpoon'):list():select(1) end, desc = 'Harpoon: File 1' },
      { '<leader>2', function() require('harpoon'):list():select(2) end, desc = 'Harpoon: File 2' },
      { '<leader>3', function() require('harpoon'):list():select(3) end, desc = 'Harpoon: File 3' },
      { '<leader>4', function() require('harpoon'):list():select(4) end, desc = 'Harpoon: File 4' },
      { '<leader>5', function() require('harpoon'):list():select(5) end, desc = 'Harpoon: File 5' },
    },
    config = function()
      require('harpoon'):setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })
    end,
  },

  -- Git worktree management
  {
    'ThePrimeagen/git-worktree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('git-worktree').setup({
        change_directory_command = 'cd',
        update_on_change = true,
        update_on_change_command = 'e .',
        clearjumps_on_change = true,
        autopush = false,
      })
      require('telescope').load_extension('git_worktree')
    end,
    keys = {
      {
        '<leader>gws',
        function()
          require('telescope').extensions.git_worktree.git_worktrees()
        end,
        desc = 'Git Worktree: Switch/Delete',
      },
      {
        '<leader>gwc',
        function()
          require('telescope').extensions.git_worktree.create_git_worktree()
        end,
        desc = 'Git Worktree: Create',
      },
    },
  },

  -- Flash.nvim - fast code navigation with search labels
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },

  -- Smear cursor - animated cursor trail showing movement direction
  {
    'sphamba/smear-cursor.nvim',
    opts = {},
  },

  -- Yazi file manager integration
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>e', '<cmd>Yazi<cr>', desc = 'Yazi: current file' },
      { '<leader>E', '<cmd>Yazi cwd<cr>', desc = 'Yazi: working directory' },
    },
    opts = {
      open_for_directories = false, -- keep neo-tree for directories
    },
  },

  -- Snacks.nvim - inline image rendering (Kitty graphics protocol via Ghostty)
  -- Opens PNG/JPG/GIF/WebP as real images; also renders images inline in markdown
  -- Requires: ImageMagick (brew install imagemagick), tmux allow-passthrough on
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    init = function()
      -- Inside tmux the terminal-version query snacks sends gets no reply, so Ghostty
      -- is never identified and image support silently stays off (endless "loading …"
      -- spinner). Identify the terminal via tmux instead and tell snacks directly.
      if vim.env.SNACKS_GHOSTTY then
        return
      end
      local term = vim.env.TERM_PROGRAM or ''
      if not term:find 'ghostty' and vim.env.TMUX then
        local ok, out = pcall(vim.fn.system, { 'tmux', 'display-message', '-p', '#{client_termname}' })
        term = ok and vim.trim(out) or ''
      end
      -- Herdr panes don't expose the outer terminal; herdr renders kitty
      -- graphics itself (config: [experimental] kitty_graphics = true), and the
      -- outer terminal here is always Ghostty.
      if term:find 'ghostty' or vim.env.HERDR_ENV then
        vim.env.SNACKS_GHOSTTY = '1'
      end
    end,
    opts = {
      image = { enabled = true },
    },
  },

  -- AI Autocompletion (Codeium) - toggleable with <leader>tc
  {
    'Exafunction/codeium.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    event = 'InsertEnter',
    config = function()
      require('codeium').setup({
        enable_chat = false, -- Disable chat UI (we only want completion)
      })
    end,
  },
}
