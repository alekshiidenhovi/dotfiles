return {
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          accept_word = ">C-Tab>",
          clear_suggestion = "<C-q>"
        }
      })
      local keymap = vim.keymap.set
      local api = require("supermaven-nvim.api")
      keymap("n", "<leader>asr", api.restart, { desc = "Restart Supermaven" })
      keymap("n", "<leader>ast", function()
        if api.is_running() then
          api.stop()
          vim.notify("Supermaven stopped")
        else
          api.start()
          vim.notify("Supermaven started")
        end
      end, { desc = "Toggle Supermaven" })
      keymap("n", "<leader>asi", function()
        if api.is_running() then
          vim.notify("Supermaven is running")
        else
          vim.notify("Supermaven is not running")
        end
      end, { desc = "Supermaven Status" })
      keymap("n", "<leader>asl", api.show_log, { desc = "Show Supermaven Logs" })
      keymap("n", "<leader>asc", api.clear_log, { desc = "Clear Supermaven Logs" })
    end,
  },
}
