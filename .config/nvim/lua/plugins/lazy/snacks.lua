return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      --@type snacks.Config
      local opts = {
        zen = { enabled = true },
        bufdelete = { enabled = true },
      }
      require("snacks").setup(opts)
      local keymap = vim.keymap.set
      keymap("n", "<leader>z", function() Snacks.zen() end, { silent = true, desc = "Zen Mode" })

      keymap("n", "<leader>bc", function() Snacks.bufdelete.delete() end,
        { silent = true, desc = "Delete current buffer" })
      keymap("n", "<leader>bfc", function() Snacks.bufdelete.delete({ force = true }) end,
        { silent = true, desc = "Force delete current buffer" })
      keymap("n", "<leader>bo", function() Snacks.bufdelete.other() end, { silent = true, desc = "Delete other buffers" })
      keymap("n", "<leader>ba", function() Snacks.bufdelete.all() end, { silent = true, desc = "Delete all buffers" })
    end,
  }
}
