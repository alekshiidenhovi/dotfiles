return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = {
              name = "gemini",
              model = "gemini-3-flash-preview",
            }
          },
          inline = {
            adapter = {
              name = "gemini",
              model = "gemini-3-flash-preview",
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
      local inline_comment = require("utils.inline-comment")
      local keymap = vim.keymap.set
      local function doc_scope(scope)
        return function()
          local prompt = inline_comment.construct_docstring_generation_prompt(inline_comment.get_filetype(), scope)
          if not prompt then
            return
          end

          if inline_comment.ts_visually_select_scope(scope) then
            companion.inline({ args = prompt })
          end
        end
      end

      keymap({ "n", "v" }, "<leader>ap", companion.actions,
        { silent = true, desc = "Show Chat Command Palette" })
      keymap({ "n", "v" }, "<leader>at", companion.toggle,
        { silent = true, desc = "Toggle Chat" })
      keymap("v", "ga", companion.add, { silent = true, desc = "Add to Chat Buffer" })

      keymap("n", "<leader>acf", doc_scope("function"), { silent = true, desc = "Function" })
      keymap("n", "<leader>acc", doc_scope("class"), { silent = true, desc = "Class" })
      keymap("n", "<leader>ac{", doc_scope("block"), { silent = true, desc = "Block" })
      keymap("n", "<leader>acl", doc_scope("line"), { silent = true, desc = "Line" })
      keymap("n", "<leader>acb", doc_scope("buffer"), { silent = true, desc = "Buffer" })
    end
  },
}
