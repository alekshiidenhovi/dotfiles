local state = {
  terminal = {
    buf = -1,
    win = -1,
  }
}

local function create_bottom_terminal_config()
  local height = 10
  local win_config = {
    relative = "editor",
    width = vim.o.columns,
    height = height,
    col = 0,
    row = vim.o.lines - height,
    style = "minimal",
    border = "bold"
  }
  return win_config
end

local function create_floating_terminal_config()
  local columns = vim.o.columns
  local lines = vim.o.lines

  local width = math.floor(columns * 0.8)
  local height = math.floor(lines * 0.8)

  local col = math.floor((columns - width) / 2)
  local row = math.floor((lines - height) / 2)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded"
  }
  return win_config
end

local function toggle_terminal(mode)
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    local buf = state.terminal.buf
    if not vim.api.nvim_buf_is_valid(buf) then
      buf = vim.api.nvim_create_buf(false, true)
    end

    local win_config = nil
    if mode == "floating" then
      win_config = create_floating_terminal_config()
    elseif mode == "bottom" then
      win_config = create_bottom_terminal_config()
    else
      print("Invalid terminal mode: " .. mode)
      return
    end

    local win = vim.api.nvim_open_win(buf, true, win_config)
    if vim.bo[buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end

    state.terminal = { win = win, buf = buf }
    vim.cmd("normal i")
  else
    vim.api.nvim_win_hide(state.terminal.win)
  end
end

vim.api.nvim_create_user_command("ToggleTerminal", function(opts)
  local default_mode = "bottom"
  if opts.args then
    toggle_terminal(opts.args)
  else
    toggle_terminal(default_mode)
  end
end, { nargs = "?" })
