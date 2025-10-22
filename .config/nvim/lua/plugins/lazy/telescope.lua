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
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
            theme = "ivy",
            hidden = true
          },
          live_grep = {
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
            additional_args = function() return { "--hidden" } end
          },
        },
        extensions = {
          fzf = {}
        }
      }

      require("telescope").load_extension("fzf")
      local builtin = require('telescope.builtin')
      local keymap = vim.keymap.set

      keymap('n', '<leader>ff', builtin.find_files, { desc = 'Telescope Find Files (cwd)' })
      keymap('n', '<leader>fF', function() builtin.find_files { cwd = "~/repos" } end,
        { desc = 'Telescope Find Files (repos)' })
      keymap('n', "<leader>fc", function() builtin.find_files { cwd = "~/repos/dotfiles/.config/nvim" } end,
        { desc = 'Telescope Find Files (Nvim Config)' })

      keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live Grep (cwd)' })
      keymap('n', '<leader>fG', function() builtin.live_grep { cwd = "~/repos" } end,
        { desc = 'Telescope Live Grep (repos)' })
      keymap('n', '<leader>fr', builtin.registers, { desc = 'Telescope Registers' })

      keymap('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers' })
      keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope Help Tags' })
      keymap('n', '<leader>fm', builtin.man_pages, { desc = 'Telescope Manual Pages' })

      keymap('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope Git Commits' })
      keymap('n', '<leader>gb', builtin.git_branches, { desc = 'Telescope Git Branches' })
      keymap('n', '<leader>gs', builtin.git_status, { desc = 'Telescope Git Statuses' })

      keymap('n', '<leader>lr', builtin.lsp_references, { desc = 'Telescope LSP References' })
      keymap('n', '<leader>li', builtin.lsp_implementations, { desc = 'Telescope LSP Implementations' })
      keymap('n', '<leader>ld', builtin.lsp_definitions, { desc = 'Telescope LSP Definitions' })
    end
  }
}
