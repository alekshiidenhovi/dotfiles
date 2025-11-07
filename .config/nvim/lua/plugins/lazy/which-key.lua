return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<C-t>", group = "terminal", icon = "" },
        { "<leader>a", group = "ai", icon = "󱜙" },
        { "<leader>b", group = "buffer", icon = "󰈔" },
        { "<leader>c", group = "clipboard", icon = "" },
        { "<leader>e", group = "execute", icon = "" },
        { "<leader>f", group = "find", icon = "󰈞" },
        { "<leader>g", group = "git", icon = "" },
        { "<leader>l", group = "lsp", icon = "" },
        { "<leader>L", group = "Lazy", icon = "󰒲" },
        { "<leader>s", group = "supermaven", icon = "" },
        { "<leader>x", group = "diagnostics/quickfix", icon = "󱖫" },
        { "<leader>z", group = "Zen Mode", icon = "󱅻" },
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
