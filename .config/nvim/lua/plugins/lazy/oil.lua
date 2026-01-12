return {
  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    opts = {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          if name:match("^%node_modules") then
            return true
          end

          local match = name:match("^%.")
          if match == nil then
            return false
          end

          if name:match("^%.gitignore") then
            return false
          end

          if name:match("^%.env") then
            return false
          end

          return true
        end
      }
    },
    keys = {
      { "-", "<cmd>Oil<CR>", desc = "Open parent directory", mode = "n" }
    },
    lazy = false,

  }
}
