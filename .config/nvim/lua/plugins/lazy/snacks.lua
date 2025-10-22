local dimEnabled = false
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      --@type snacks.Config
      local opts = {
        zen = { enabled = true },
        bufdelete = {
          enabled = true
        },
        dashboard = {
          enabled = true,
          sections = {
            { section = "header" },
            { section = "keys",     gap = 1,            padding = 2 },
            { section = "projects", title = "Projects", indent = 2, padding = 3 },

            { section = "startup" },
          }
        },
        git = {
          enabled = true
        },
        statuscolumn = {
          enabled = true
        },
        dim = {
          enabled = true,
        }
      }
      require("snacks").setup(opts)
      local keymap = vim.keymap.set
      keymap("n", "<leader>Z", function() Snacks.zen() end, { silent = true, desc = "Zen Mode Zoomed" })
      keymap("n", "<leader>z", function()
        if dimEnabled then
          Snacks.dim.disable()
          dimEnabled = false
        else
          Snacks.dim.enable()
          dimEnabled = true
        end
      end, { silent = true, desc = "Zen Mode" })

      keymap("n", "<leader>bc", function() Snacks.bufdelete.delete() end,
        { silent = true, desc = "Delete current buffer" })
      keymap("n", "<leader>bfc", function() Snacks.bufdelete.delete({ force = true }) end,
        { silent = true, desc = "Force delete current buffer" })
      keymap("n", "<leader>bo", function() Snacks.bufdelete.other() end, { silent = true, desc = "Delete other buffers" })
      keymap("n", "<leader>ba", function() Snacks.bufdelete.all() end, { silent = true, desc = "Delete all buffers" })

      keymap("n", "<leader>gbl", function() Snacks.git.blame_line() end, { silent = true, desc = "Git Blame" })
    end,
  }
}
