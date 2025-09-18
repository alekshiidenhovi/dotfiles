return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    opts = {},
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory", mode = "n" }
    },
    lazy = false,
  }
}
