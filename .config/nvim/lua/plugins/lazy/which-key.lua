return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<C-t>", group = "terminal", icon = "" },
        { "<leader>a", group = "ai", icon = "󱜙" },
        { "<leader>c", group = "clipboard", icon = "" },
        { "<leader>x", group = "execute", icon = "" },
        { "<leader>f", group = "find", icon = "󰈞" },
        { "<leader>g", group = "git", icon = "" },
        { "<leader>l", group = "lsp", icon = "" },
        { "<leader>s", group = "supermaven", icon = "" },
        { "<leader>b", group = "buffer", icon = "󰈔" },
        { "<leader>z", group = "Zen Mode", icon = "󱅻" },
        { "<leader>L", group = "Lazy", icon = "󰒲" },
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
