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
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash",
            }
          },
          inline = {
            adapter = {
              name = "gemini",
              model = "gemini-2.5-flash-lite",
            }
          }
        },

        adapters = {
          http = {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = vim.fn.getenv("GEMINI_API_KEY")
                },
              })
            end
          }
        },


        display = {
          action_palette = {
            provider = "snacks"
          },
          chat = {
            show_settings = true,
          }
        },

        opts = {
          log_level = "DEBUG",
        },

      })

      local companion = require("codecompanion")

      vim.keymap.set({ "n", "v" }, "<leader>ap", companion.actions,
        { silent = true, desc = "Show Chat Command Palette" })
      vim.keymap.set({ "n", "v" }, "<leader>at", companion.toggle,
        { silent = true, desc = "Toggle Chat" })
      vim.keymap.set("v", "ga", companion.add, { silent = true, desc = "Add to Chat Buffer" })
    end
  },
}
