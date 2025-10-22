return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local bufferline = require('bufferline')

      bufferline.setup({
        options = {
          style_preset = {
            bufferline.style_preset.no_italic
          },
          indicator = {
            style = "underline"
          },
          show_buffer_close_icons = false,
          show_close_icon = false,
          diagnostics = "nvim_lsp",
          sort_by = function(buffer_a, buffer_b)
            local function get_sort_keys(buffer)
              local extension = buffer.extension or ''
              local filename = vim.fn.fnamemodify(buffer.name, ':t') or ''
              local path = buffer.path or ''
              return extension, filename, path
            end

            local ext_a, name_a, path_a = get_sort_keys(buffer_a)
            local ext_b, name_b, path_b = get_sort_keys(buffer_b)

            if ext_a ~= ext_b then
              return ext_a < ext_b
            elseif name_a ~= name_b then
              return name_a < name_b
            else
              return path_a < path_b
            end
          end,
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              separator = true,
              highlight = "Directory",
              text_align = "left"
            }
          }
        },
      })

      -- Navigate buffers
      local keymap = vim.keymap.set
      keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true, desc = "Next Buffer" })
      keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Buffer" })

      keymap("n", "<leader>b1", ":BufferLineGoToBuffer 1<CR>", { silent = true, desc = "Open Buffer 1" })
      keymap("n", "<leader>b2", ":BufferLineGoToBuffer 2<CR>", { silent = true, desc = "Open Buffer 2" })
      keymap("n", "<leader>b3", ":BufferLineGoToBuffer 3<CR>", { silent = true, desc = "Open Buffer 3" })
      keymap("n", "<leader>b4", ":BufferLineGoToBuffer 4<CR>", { silent = true, desc = "Open Buffer 4" })
      keymap("n", "<leader>b5", ":BufferLineGoToBuffer 5<CR>", { silent = true, desc = "Open Buffer 5" })
      keymap("n", "<leader>b6", ":BufferLineGoToBuffer 6<CR>", { silent = true, desc = "Open Buffer 6" })
      keymap("n", "<leader>b7", ":BufferLineGoToBuffer 7<CR>", { silent = true, desc = "Open Buffer 7" })
      keymap("n", "<leader>b8", ":BufferLineGoToBuffer 8<CR>", { silent = true, desc = "Open Buffer 8" })
      keymap("n", "<leader>b9", ":BufferLineGoToBuffer 9<CR>", { silent = true, desc = "Open Buffer 9" })
      keymap("n", "<leader>b0", ":BufferLineGoToBuffer -1<CR>", { silent = true, desc = "Open Last Buffer" })

      keymap("n", "<leader>bc", ":BufferLineCloseOthers<CR>", { silent = true, desc = "Close Other Buffers" })
    end

  }
}
