return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false,                    -- neo-tree will lazily load itself
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
      enable_git_status = true,
      enable_diagnostics = true,
      close_if_last_window = true,
    },
    keys = {
      { "<leader>e", "<cmd>Neotree action=show toggle=true<CR>", desc = "File-tree Explorer", mode = "n" }
    },
  }
}
