return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
      on_highlights = function(hl, c)
        hl.LineNr = { fg = c.blue }
        hl.LineNrAbove = { fg = c.blue }
        hl.LineNrBelow = { fg = c.blue }
        hl.CursorLineNr = { fg = c.orange, bold = true }
      end,
    })
    vim.cmd.colorscheme "tokyonight"
  end,
  enabled = true
}
