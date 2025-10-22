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

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", { silent = true, desc = "Next Buffer" })
keymap("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Previous Buffer" })

-- Insert --
keymap("i", "jk", "<ESC>", { silent = true, desc = "Switch To Normal Mode" })
keymap("i", "<A-BS>", "<C-w>", { silent = true, desc = "Delete Word Before Cursor" })


-- Execute --
keymap("n", "<leader>xf", "<cmd>source %<CR>", { silent = false, desc = "Source The File" })
keymap("n", "<leader>xx", ":.lua<CR>", { silent = false, desc = "Execute The Line" })
keymap("v", "<leader>xx", ":lua<CR>", { silent = false, desc = "Execute Lines" })

-- Quickfix
keymap("n", "<A-j>", "<cmd>cnext<CR>", { silent = true, desc = "Next Quickfix" })
keymap("n", "<A-k>", "<cmd>cprev<CR>", { silent = true, desc = "Previous Quickfix" })
keymap("n", "<leader>Q", function() vim.diagnostic.setqflist({ open = true }) end,
  { silent = true, desc = "Quickfix" })

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", { silent = true, desc = "Indent Left" })
keymap("v", ">", ">gv", { silent = true, desc = "Indent Right" })
keymap("v", "<C-a>", "ggVG", { silent = true, desc = "Select All" })

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move Line(s) Down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move Line(s) Up" })
keymap("v", "p", '"_dP', { silent = true, desc = "Replace Text" })

-- Fast write
keymap("n", "<leader>w", "<cmd>:w<CR>", { silent = false, desc = "Save File" })
keymap("n", "<leader>q", "<cmd>:q<CR>", { silent = false, desc = "Quit File" })

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { silent = true, desc = "Move To Window Left" })
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { silent = true, desc = "Move To Window Below" })
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { silent = true, desc = "Move To Window Above" })
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { silent = true, desc = "Move To Window Right" })

keymap("t", "<C-Space>", "<C-\\><C-n>", { silent = true, desc = "Enter Normal Mode" })
