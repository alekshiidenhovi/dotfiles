return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      spec = {
        { "<leader>t", group = "terminal", icon = "" },
        { "<leader>x", group = "execute", icon = "" },
        { "<leader>f", group = "find", icon = "󰈞" },
        { "<leader>g", group = "git", icon = "" },
        { "<leader>l", group = "lsp", icon = "" },
        { "<leader>s", group = "supermaven", icon = "" },

      }
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  }
}
