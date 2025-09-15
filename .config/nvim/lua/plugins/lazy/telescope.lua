return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require("telescope").setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require("telescope").load_extension("fzf")
      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>frg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope manual pages' })

      vim.keymap.set('n', '<leader>fgc', builtin.git_commits, { desc = 'Telescope git commits' })
      vim.keymap.set('n', '<leader>fgb', builtin.git_branches, { desc = 'Telescope git branches' })
      vim.keymap.set('n', '<leader>fgs', builtin.git_status, { desc = 'Telescope git statuses' })

      vim.keymap.set('n', '<leader>flr', builtin.lsp_references, { desc = 'Telescope LSP references' })
      vim.keymap.set('n', '<leader>fli', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
      vim.keymap.set('n', '<leader>fld', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })


      vim.keymap.set("n", "<leader>fc", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
