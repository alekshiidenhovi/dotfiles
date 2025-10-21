local options = {
  backup = false,                                   -- Enables backup files
  clipboard = "",                                   -- Defines integrations with system clipboard
  cmdheight = 2,                                    -- Height of the command line prompt
  completeopt = { "menuone", "noselect", "fuzzy" }, -- Completion options
  conceallevel = 0,                                 -- Defines how text is concealed
  fileencoding = "utf-8",                           -- File-encoding type
  hlsearch = true,                                  -- Highlight previous search pattern matches
  ignorecase = true,                                -- Ignore letter casing with search patterns
  mouse = "a",                                      -- Defines which modes allow mouse usage
  pumheight = 10,                                   -- Maximum number of popup menu items shown
  showmode = true,                                  -- Display the current mode in command line
  showtabline = 1,                                  -- Defines when available tabs are shown
  smartcase = true,                                 -- Overrides ignorecase when uppercase is usedi
  smartindent = true,                               -- Use smart indenting when starting new lines
  splitbelow = true,                                -- Defines which direction horizontal splits are created
  splitright = true,                                -- Defines which direction vertical splits are created
  swapfile = false,                                 -- Whether swapfiles are used or not
  termguicolors = true,                             -- Allows color usage for TUI apps
  timeoutlen = 1000,                                -- Time in milliseconds for completing a keymap sequence
  undofile = true,                                  -- Defines if undofiles is used
  updatetime = 300,                                 -- Defines the time in milliseconds after which swap file is written to disk
  writebackup = true,                               -- Whether backup is created before overwriting a file
  expandtab = true,                                 -- Whether tabs are expanded to correct number of spaces
  shiftwidth = 2,                                   -- Number of spaces when indenting
  tabstop = 2,                                      -- Number of spaces that a <Tab> counts for
  smarttab = true,                                  -- Smart tab usage according to 'shiftwidth' and 'tabstop'
  cursorline = true,                                -- Highlight the cursor line
  number = true,                                    -- Print the line number before each line
  relativenumber = true,                            -- Print the relative distance from the cursor line
  numberwidth = 3,                                  -- Minimal number of columns used for the line number
  signcolumn = "yes",                               -- Options on how sign columns are displayed
  textwidth = 0,                                    -- Maximum width of text inserted, 0 disables this
  wrap = true,                                      -- Enables wrapping when text exceeds window size
  linebreak = true,                                 -- Enables wrapping at word level rather than character
  breakindent = true,                               -- Wrapped lines will continue visually indented
  scrolloff = 8,                                    -- Minimal number of screen lines above/below cursor line
  guifont = "monospace:h17",                        -- GUI font name used for GUI version of Vim
  shortmess = "ltToOcCF",                           -- Helps to avoid "hit-enter" prompts from file messages
  whichwrap =
  "b,s,h,l,<,>,[,]"                                 -- Comma-separated list of keys allowed to move upon wrap boundaries
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
