return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      --@type snacks.Config
      local opts = {
        zen = { enabled = true },
      }
      require("snacks").setup(opts)
      local keymap = vim.keymap.set
      keymap("n", "<leader>z", function() Snacks.zen() end, { silent = true, desc = "Zen Mode" })
    end,
  }
}
