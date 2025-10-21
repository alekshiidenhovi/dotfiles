return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Assignment Outer" },
              ["i="] = { query = "@assignment.inner", desc = "Assignment Inner" },

              ["af"] = { query = "@function.outer", desc = "Function Outer" },
              ["if"] = { query = "@function.inner", desc = "Function Inner" },

              ["ac"] = { query = "@class.outer", desc = "Class Outer" },
              ["ic"] = { query = "@class.inner", desc = "Class Inner" },

              ["ai"] = { query = "@conditional.outer", desc = "Conditional Outer" },
              ["ii"] = { query = "@conditional.inner", desc = "Conditional Inner" },

              ["al"] = { query = "@loop.outer", desc = "Loop Outer" },
              ["il"] = { query = "@loop.inner", desc = "Loop Inner" },

              ["aa"] = { query = "@parameter.outer", desc = "Parameter Outer" },
              ["ia"] = { query = "@parameter.inner", desc = "Parameter Inner" },

              ["ab"] = { query = "@block.outer", desc = "Block Outer" },
              ["ib"] = { query = "@block.inner", desc = "Block Inner" },

              ["ar"] = { query = "@return.outer", desc = "Return Outer" },
              ["ir"] = { query = "@return.inner", desc = "Return Inner" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = { query = "@parameter.inner", desc = "Swap Next Parameter" },

            },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "Swap Previous Parameter" },
            },
          },
        }
      }
    end
  }
}
