return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "<C-t>", group = "terminal", icon = "" },
        { "<leader>a", group = "ai", icon = "󱜙" },
        { "<leader>b", group = "buffer", icon = "" },
        { "<leader>c", group = "clipboard", icon = "" },
        { "<leader>e", icon = "󰙅" },
        { "<leader>f", group = "files", icon = "󰈞" },
        { "<leader>g", group = "git", icon = "" },
        { "<leader>L", group = "Lazy", icon = "󰒲" },
        { "<leader>s", group = "search", icon = "" },
        { "<leader>t", group = "supermaven", icon = "" },
        { "<leader>u", group = "ui", icon = "󰨇" },
        { "<leader>x", group = "diagnostics/quickfix", icon = "󱖫" },
        { "<leader>z", icon = "󱅻" },
        { "<leader>Z", icon = "󱅻" },
        { "<leader>,", icon = "" },
        { "<leader>/", icon = "󱎸" },
        { "<leader>:", icon = "" },
        { "<leader><space>", icon = "" },
      },
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
