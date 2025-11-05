return {
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
      "saghen/blink.cmp"
    },
    ft = { "markdown", "codecompanion" },
    config = function()
      require("markview").setup({
        preview = {
          icon_provider = "devicons",
          filetypes = {
            "md",
            "markdown",
            "latex",
            "vimwiki",
            "typst",
            "codecompanion",
          },
          ignore_buftypes = {},
          condition = function(buffer)
            local ft, bt = vim.bo[buffer].ft, vim.bo[buffer].bt;

            if bt == "nofile" and ft == "codecompanion" then
              return true;
            elseif bt == "nofile" then
              return false;
            else
              return true;
            end
          end
        },
      })

      local keymap = vim.keymap.set
      keymap("n", "<leader>m", "<cmd>Markview toggle<CR>", { silent = true, desc = "Toggle Preview" })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'codecompanion',
        command = 'Markview attach',
      })
    end
  }
};
