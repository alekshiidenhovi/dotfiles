local keymap = vim.keymap.set


--Remap space as leader key
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to window left" })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to window below" })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to window above" })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to window right" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Resize upwards" })
keymap("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Resize downwards" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize leftwards" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Resize rightwards" })

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Switch to next buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Switch to previous buffer" })

-- Insert --
keymap("i", "jk", "<ESC>", { silent = true, desc = "Switch to normal mode" })

-- Execute --
keymap("n", "<leader>xf", "<cmd>source %<CR>", { silent = false, desc = "Source the file" })
keymap("n", "<leader>xx", ":.lua<CR>", { silent = false, desc = "Execute the line" })
keymap("v", "<leader>xx", ":lua<CR>", { silent = false, desc = "Execute lines" })

-- Quickfix
keymap("n", "<A-j>", "<cmd>cnext<CR>", { silent = true, desc = "Move to next quickfix" })
keymap("n", "<A-k>", "<cmd>cprev<CR>", { silent = true, desc = "Move to previous quickfix" })
keymap("n", "<leader>Q", function() vim.diagnostic.setqflist({ open = true }) end,
  { silent = true, desc = "Add diagnostics to quickfix" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true, desc = "Indent left" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent right" })

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move line(s) down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move line(s) up" })
keymap("v", "p", '"_dP', { silent = true, desc = "Replace text" })

-- Fast write
keymap("n", "<leader>W", "<cmd>:w<CR>", { silent = false, desc = "Write" })

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, desc = "Move to window left" })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, desc = "Move to window below" })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, desc = "Move to window above" })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, desc = "Move to window right" })

keymap("t", "<leader><ESC>", "<C-\\><C-n>", { silent = true, desc = "Enter normal mode" })
