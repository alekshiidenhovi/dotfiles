local state = {
  terminal = {
    buf = -1,
    win = -1,
    mode = "",
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
  local win_config = nil
  if mode == "floating" then
    win_config = create_floating_terminal_config()
  elseif mode == "bottom" then
    win_config = create_bottom_terminal_config()
  else
    print("Invalid terminal mode: " .. mode)
    return
  end

  local buf = state.terminal.buf
  if not vim.api.nvim_buf_is_valid(buf) then
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Window closed --> open window in the specified mode
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    local win = vim.api.nvim_open_win(buf, true, win_config)
    if vim.bo[buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end

    state.terminal = {
      win = win,
      buf = buf,
      mode = mode,
    }
    vim.cmd("startinsert")
    return
  end

  -- Window open with equal mode --> close terminal
  if mode == state.terminal.mode then
    vim.api.nvim_win_hide(state.terminal.win)
    state.terminal = { win = -1, buf = state.terminal.buf, mode = "", }
    return
  end

  -- Window open with different mode --> switch terminal
  vim.api.nvim_win_close(state.terminal.win, true)
  local win = vim.api.nvim_open_win(buf, true, win_config)
  state.terminal.win = win
  state.terminal.mode = mode
  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("ToggleTerminal", function(opts)
  local default_mode = "bottom"
  if opts.args then
    toggle_terminal(opts.args)
  else
    toggle_terminal(default_mode)
  end
end, { nargs = "?" })
