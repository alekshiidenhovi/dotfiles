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
-- Better window management
keymap("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move To Window Left" })
keymap("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move To Window Below" })
keymap("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move To Window Above" })
keymap("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move To Window Right" })
keymap("n", "<leader>|", "<C-w>v", { silent = true, desc = "Split Window Right" })
keymap("n", "<leader>-", "<C-w>s", { silent = true, desc = "Split Window Bottom" })

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Resize Upwards" })
keymap("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Resize Downwards" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize Leftwards" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Resize Rightwards" })

-- Insert --
keymap("i", "jk", "<ESC>", { silent = true, desc = "Switch To Normal Mode" })
keymap("i", "<A-BS>", "<C-w>", { silent = true, desc = "Delete Word Before Cursor" })
keymap('i', '<A-b>', '<C-o>b', { desc = 'Move word backward' })
keymap('i', '<A-f>', '<C-o>w', { desc = 'Move word forward' })

-- Clipboard --
keymap("n", "<leader>cy", "\"+y", { silent = true, desc = "Yank Line" })
keymap("n", "<leader>cc", "\"+yggyG", { silent = true, desc = "Copy Buffer" })
keymap("n", "<leader>cp", "\"+p", { silent = true, desc = "Paste" })

-- Execute --
keymap("n", "<leader>ef", "<cmd>source %<CR>", { silent = false, desc = "Source The File" })
keymap("n", "<leader>ex", ":.lua<CR>", { silent = false, desc = "Execute The Line" })
keymap("v", "<leader>ex", ":lua<CR>", { silent = false, desc = "Execute Lines" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true, desc = "Indent Left" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent Right" })

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Line(s) Down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Line(s) Up" })
keymap("v", "p", '"_dP', { silent = true, desc = "Replace Text" })

-- Fast write
keymap("n", "<leader>w", "<cmd>:w<CR>", { silent = false, desc = "Save File" })

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, desc = "Move To Window Left" })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, desc = "Move To Window Below" })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, desc = "Move To Window Above" })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, desc = "Move To Window Right" })

keymap("t", "<C-Space>", "<C-\\><C-n>", { silent = true, desc = "Enter Normal Mode" })
