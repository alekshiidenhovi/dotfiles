return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp"
    },
    preview = {
      icon_provider = "devicons"
    },
    config = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>m", "<cmd>Markview toggle<CR>", { silent = true, desc = "Toggle Preview" })
    end
  }
};
