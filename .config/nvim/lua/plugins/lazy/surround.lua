return {
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = "<C-g>s",
          insert_line = false,
          normal = "<leader>ma",
          normal_cur = "<leader>mA",
          normal_line = false,
          normal_cur_line = false,
          visual = "<leader>mv",
          visual_line = false,
          delete = "<leader>md",
          change = "<leader>mc",
          change_line = false
        },
      })
    end
  }
}
