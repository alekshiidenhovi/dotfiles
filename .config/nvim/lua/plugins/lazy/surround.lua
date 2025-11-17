return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = false,
          normal = "<leader>sa",
          normal_cur = "<leader>sA",
          normal_line = false,
          normal_cur_line = false,
          visual = "<leader>sv",
          visual_line = false,
          delete = "<leader>sd",
          change = "<leader>sc",
          change_line = false
        },
      })
    end
  }
}
