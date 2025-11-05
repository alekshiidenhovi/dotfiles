return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "gemini",
            model = "gemini-2.0-flash-lite"
          },
          inline = {
            adapter = "gemini",
            model = "gemini-2.0-flash-lite"
          }
        },

        adapters = {
          http = {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = "cmd:op read op://Personal/Gemini/credential --no-newline",
                },
              })
            end
          }
        },


        display = {
          action_palette = {
            provider = "snacks"
          }
        },

        opts = {
          log_level = "DEBUG",
        },

      })

      vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>",
        { silent = true, desc = "Show Chat Command Palette" })
      vim.keymap.set({ "n", "v" }, "<leader>at", "<cmd>CodeCompanionChat Toggle<cr>",
        { silent = true, desc = "Toggle Chat" })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { silent = true, desc = "Add to Chat Buffer" })
    end
  },
}
