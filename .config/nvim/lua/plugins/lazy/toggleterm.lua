return {
  {
    'akinsho/toggleterm.nvim',
    branch = "main",
    config = function()
      require("toggleterm").setup {
      }
      local keymap = vim.keymap.set
      local Terminal = require("toggleterm.terminal").Terminal

      local columns = vim.o.columns
      local lines = vim.o.lines
      local PERCENTAGE = 0.8

      local width = math.floor(columns * PERCENTAGE)
      local height = math.floor(lines * PERCENTAGE)
      local col = math.floor((columns - width) / 2)
      local row = math.floor((lines - height) / 2)

      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "rounded",
          width = width,
          height = height,
          col = col,
          row = row,
        }
      })

      -- Regular terminals
      keymap({ "n", "t" }, "<leader>tt", "<cmd>ToggleTermToggleAll<CR>", { silent = true, desc = "Toggle all terminals" })
      keymap({ "n", "t" }, "<leader>tn", "<cmd>TermNew direction=horizontal<CR>",
        { silent = true, desc = "Add new terminal" })
      keymap({ "n", "t" }, "<leader>ts", "<cmd>TermSelect<CR>", { silent = true, desc = "Select terminal" })
      keymap({ "n", "t" }, "<leader>td", function()
        local toggleterminal = require("toggleterm.terminal")
        local focusedTerminalId = toggleterminal.get_focused_id()

        if not focusedTerminalId then
          vim.notify("No terminal is focused, cannot perform a shutdown!", vim.log.levels.WARN)
          return
        end

        -- Get the terminal object for the focused terminal
        local term = toggleterminal.get(focusedTerminalId)
        if term then
          term:shutdown() -- kill the terminal process
          term:close()    -- close the window
          print("Closed terminal " .. term.name)
        else
          vim.notify("Could not find the terminal object", vim.log.levels.ERROR)
        end
      end, { silent = true, desc = "Close the current terminal" })

      -- Lazygit termina
      keymap({ "n", "t" }, "<leader>tl", function()
        lazygit:toggle()
      end, { silent = true, desc = "Toggle Lazygit" })
    end
  }
}
