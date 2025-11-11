return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@class wk.Opts
    opts = {
      preset = "modern",
      spec = {
        { "<C-t>", group = "terminal", icon = "" },

        { "<leader>a", group = "ai", icon = "󱜙" },
        { "<leader>ac", group = "inline/comment", icon = "󰅺" },
        { "<leader>acb", icon = "" },
        { "<leader>acc", icon = "" },
        { "<leader>acf", icon = "󰊕" },
        { "<leader>acl", icon = "" },
        { "<leader>ac{", icon = "󰅩" },
        { "<leader>as", group = "supermaven", icon = "" },

        { "<leader>b", group = "buffer", icon = "" },
        { "<leader>c", group = "code", icon = "" },
        { "<leader>e", icon = "󰙅" },
        { "<leader>f", group = "files", icon = "󰈞" },
        { "<leader>g", group = "git", icon = "" },
        { "<leader>L", group = "Lazy", icon = "󰒲" },
        { "<leader>p", group = "clipboard", icon = "" },
        { "<leader>s", group = "search", icon = "" },
        { "<leader>u", group = "ui", icon = "󰨇" },
        { "<leader>x", group = "diagnostics/quickfix", icon = "󱖫" },
        { "<leader>z", icon = "󱅻" },
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
