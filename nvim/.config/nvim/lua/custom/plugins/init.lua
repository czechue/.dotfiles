-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Multiple cursors plugin (like IntelliJ's Ctrl-G)
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvimtools/hydra.nvim' },
    opts = {},
    keys = {
      {
        mode = { 'v', 'n' },
        '<C-g>',
        '<cmd>MCstart<cr>',
        desc = 'Create multiple cursors for selected text or word under cursor',
      },
    },
  },
}
