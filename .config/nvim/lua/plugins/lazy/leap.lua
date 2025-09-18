return {
  {
    "ggandor/leap.nvim",
    dependencies = {
      "tpope/vim-repeat"
    },
    lazy = false,
    config = function()
      require("leap").add_default_mappings()
      require("leap").opts.case_sensitive = true
      require("leap").opts.preview_filter = function(ch0, ch1, ch2)
        return not (
          ch1:match('%s') or
          ch0:match('%a') and ch1:match('%a') and ch2:match('%a')
        )
      end
      require("leap").opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }
      require("leap.user").set_repeat_keys("<enter>", "<backspace>")
      vim.keymap.set({ 'n', 'x', 'o' }, 'gs', function()
        require('leap.remote').action()
      end)
    end,
  },
}
