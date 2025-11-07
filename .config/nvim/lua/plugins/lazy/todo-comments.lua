return {
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
    },
    config = function()
      require("todo-comments").setup({})
      local keymap = vim.keymap.set
      keymap("n", "<leader>st", "<cmd>Trouble todo toggle filter = { tag = { TODO } }<CR>",
        { silent = true, desc = "Todo" })
      keymap("n", "<leader>sT", "<cmd>Trouble todo toggle filter = { tag = { TODO,FIX,NOTE,HACK } }<CR>",
        { silent = true, desc = "Todo/Fix/Note/Hack" })
    end,
  }
}
