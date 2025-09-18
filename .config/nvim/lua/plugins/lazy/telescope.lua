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
      local keymap = vim.keymap.set

      keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      keymap('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      keymap('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope manual pages' })

      keymap('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })
      keymap('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope git branches' })
      keymap('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git statuses' })

      keymap('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope LSP references' })
      keymap('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
      keymap('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })

      keymap("n", "<leader>fc", function()
        builtin.find_files {
          cwd = vim.fn.stdpath("config")
        }
      end)
    end
  }
}
