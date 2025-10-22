return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
    config = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>m", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview Toggle" })
    end
  }
}
