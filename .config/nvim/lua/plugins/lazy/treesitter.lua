return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          "c",
          "cmake",
          "cpp",
          "css",
          "dockerfile",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "rust",
          "sql",
          "terraform",
          "typescript",
          "vim",
          "vimdoc",
          "vue",
          "yaml",
        },
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        sync_install = false,
        auto_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          -- Disable ighlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- Disable legacy VimScript regex-based highlighting
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  }
}
