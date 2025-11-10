return {
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,

    ---@type snacks.Config
    opts = {
      ---@class snacks.zen.Config
      zen = {
        enabled = true
      },

      ---@class snacks.bufdelete.Opts
      bufdelete = {
        enabled = true
      },

      ---@class snacks.dashboard.Config
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys",     gap = 1,            padding = 2 },
          { section = "projects", title = "Projects", indent = 2, padding = 3 },
          { section = "startup" },
        },
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files', {hidden = true})" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep' , {hidden = true})" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles', {hidden = true})" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', { hidden = true, cwd = vim.fn.stdpath('config') })" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        }
      },

      ---@class snacks.git.Config
      git = {
        enabled = true,
      },

      ---@class snacks.statuscolumn.Config
      statuscolumn = {
        enabled = true
      },

      ---@class snacks.dim.Config
      dim = {
        enabled = true,
      },

      ---@class snacks.explorer.Config
      explorer = {
        enabled = true
      },

      ---@class snacks.picker.Config
      picker = {
        sources = {
          explorer = {
            hidden = true,
            win = {
              input = {
                keys = {
                  ["<C-t>"] = false
                },
              },
              list = {
                keys = {
                  ["<C-t>"] = false
                },
              },
            },
          },
          gh_issue = {},
          gh_pr = {}
        },
      },

      ---@class snacks.gh.Config
      gh = {
        enabled = true
      },

      ---@class snacks.bigfile.Config
      bigfile = {
        enabled = true
      },

      ---@class snacks.gitbrowse.Config
      gitbrowse = {
        enabled = true
      },

      ---@class snacks.quickfile.Config
      quickfile = {
        enabled = true
      },

      ---@class snacks.scroll.Config
      scroll = {
        enabled = false,
      },

      ---@class snacks.words.Config
      words = {
        enabled = true
      },

      ---@class snacks.indent.Config
      indent = {
        enabled = true,
        animate = {
          enabled = false
        }
      },

      ---@class snacks.input.Config
      input = {
        enabled = true
      },

      ---@class snacks.rename.Config
      rename = {
        enabled = true
      }
    },

    keys = {
      -- Pickers
      { "<leader><space>", function() require("snacks").picker.smart({ hidden = true }) end,                                 desc = "Smart Find Files" },
      { "<leader>,",       function() require("snacks").picker.buffers({ hidden = true }) end,                               desc = "Buffers" },
      { "<leader>/",       function() require("snacks").picker.grep({ hidden = true }) end,                                  desc = "Grep" },
      { "<leader>:",       function() require("snacks").picker.command_history({ hidden = true }) end,                       desc = "Command History" },
      { "<leader>e",       function() require("snacks").explorer({ hidden = true }) end,                                     desc = "File-tree Explorer" },
      -- find
      { "<leader>fb",      function() require("snacks").picker.buffers({ hidden = true }) end,                               desc = "Buffers" },
      { "<leader>fc",      function() require("snacks").picker.files({ hidden = true, cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff",      function() require("snacks").picker.files({ hidden = true }) end,                                 desc = "Find Files" },
      { "<leader>fg",      function() require("snacks").picker.git_files({ hidden = true }) end,                             desc = "Find Git Files" },
      { "<leader>fp",      function() require("snacks").picker.projects({ hidden = true }) end,                              desc = "Projects" },
      { "<leader>fr",      function() require("snacks").picker.recent({ hidden = true }) end,                                desc = "Recent" },
      -- git
      { "<leader>gb",      function() require("snacks").picker.git_branches({ hidden = true }) end,                          desc = "Git Branches" },
      { "<leader>gl",      function() require("snacks").picker.git_log({ hidden = true }) end,                               desc = "Git Log" },
      { "<leader>gL",      function() require("snacks").picker.git_log_line({ hidden = true }) end,                          desc = "Git Log Line" },
      { "<leader>gs",      function() require("snacks").picker.git_status({ hidden = true }) end,                            desc = "Git Status" },
      { "<leader>gS",      function() require("snacks").picker.git_stash({ hidden = true }) end,                             desc = "Git Stash" },
      { "<leader>gd",      function() require("snacks").picker.git_diff({ hidden = true }) end,                              desc = "Git Diff (Hunks)" },
      { "<leader>gf",      function() require("snacks").picker.git_log_file({ hidden = true }) end,                          desc = "Git Log File" },
      -- gh
      { "<leader>gi",      function() require("snacks").picker.gh_issue({ hidden = true }) end,                              desc = "GitHub Issues (open)" },
      { "<leader>gI",      function() require("snacks").picker.gh_issue({ hidden = true, state = "all" }) end,               desc = "GitHub Issues (all)" },
      { "<leader>gp",      function() require("snacks").picker.gh_pr({ hidden = true }) end,                                 desc = "GitHub Pull Requests (open)" },
      { "<leader>gP",      function() require("snacks").picker.gh_pr({ hidden = true, state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
      -- Grep
      { "<leader>sb",      function() require("snacks").picker.lines({ hidden = true }) end,                                 desc = "Buffer Lines" },
      { "<leader>sB",      function() require("snacks").picker.grep_buffers({ hidden = true }) end,                          desc = "Grep Open Buffers" },
      { "<leader>sg",      function() require("snacks").picker.grep({ hidden = true }) end,                                  desc = "Grep" },
      { "<leader>sw",      function() require("snacks").picker.grep_word({ hidden = true }) end,                             desc = "Visual selection or word",   mode = { "n", "x" } },
      -- search
      { '<leader>s"',      function() require("snacks").picker.registers({ hidden = true }) end,                             desc = "Registers" },
      { '<leader>s/',      function() require("snacks").picker.search_history({ hidden = true }) end,                        desc = "Search History" },
      { "<leader>sa",      function() require("snacks").picker.autocmds({ hidden = true }) end,                              desc = "Autocmds" },
      { "<leader>sb",      function() require("snacks").picker.lines({ hidden = true }) end,                                 desc = "Buffer Lines" },
      { "<leader>sc",      function() require("snacks").picker.command_history({ hidden = true }) end,                       desc = "Command History" },
      { "<leader>sC",      function() require("snacks").picker.commands({ hidden = true }) end,                              desc = "Commands" },
      { "<leader>sd",      function() require("snacks").picker.diagnostics({ hidden = true }) end,                           desc = "Diagnostics" },
      { "<leader>sD",      function() require("snacks").picker.diagnostics_buffer({ hidden = true }) end,                    desc = "Buffer Diagnostics" },
      { "<leader>sh",      function() require("snacks").picker.help({ hidden = true }) end,                                  desc = "Help Pages" },
      { "<leader>sH",      function() require("snacks").picker.highlights({ hidden = true }) end,                            desc = "Highlights" },
      { "<leader>si",      function() require("snacks").picker.icons({ hidden = true }) end,                                 desc = "Icons" },
      { "<leader>sj",      function() require("snacks").picker.jumps({ hidden = true }) end,                                 desc = "Jumps" },
      { "<leader>sk",      function() require("snacks").picker.keymaps({ hidden = true }) end,                               desc = "Keymaps" },
      { "<leader>sl",      function() require("snacks").picker.loclist({ hidden = true }) end,                               desc = "Location List" },
      { "<leader>sm",      function() require("snacks").picker.marks({ hidden = true }) end,                                 desc = "Marks" },
      { "<leader>sM",      function() require("snacks").picker.man({ hidden = true }) end,                                   desc = "Man Pages" },
      { "<leader>sp",      function() require("snacks").picker.lazy({ hidden = true }) end,                                  desc = "Search for Plugin Spec" },
      { "<leader>sq",      function() require("snacks").picker.qflist({ hidden = true }) end,                                desc = "Quickfix List" },
      { "<leader>sR",      function() require("snacks").picker.resume({ hidden = true }) end,                                desc = "Resume" },
      { "<leader>su",      function() require("snacks").picker.undo({ hidden = true }) end,                                  desc = "Undo History" },
      { "<leader>uc",      function() require("snacks").picker.colorschemes({ hidden = true }) end,                          desc = "Colorschemes" },
      { "gd",              function() require("snacks").picker.lsp_definitions({ hidden = true }) end,                       desc = "Goto Definition" },
      { "gD",              function() require("snacks").picker.lsp_declarations({ hidden = true }) end,                      desc = "Goto Declaration" },
      { "gr",              function() require("snacks").picker.lsp_references({ hidden = true }) end,                        desc = "References",                 nowait = true, },
      { "gI",              function() require("snacks").picker.lsp_implementations({ hidden = true }) end,                   desc = "Goto Implementation" },
      { "gy",              function() require("snacks").picker.lsp_type_definitions({ hidden = true }) end,                  desc = "Goto T[y]pe Definition" },
      { "gai",             function() require("snacks").picker.lsp_incoming_calls({ hidden = true }) end,                    desc = "C[a]lls Incoming" },
      { "gao",             function() require("snacks").picker.lsp_outgoing_calls({ hidden = true }) end,                    desc = "C[a]lls Outgoing" },
      { "<leader>ss",      function() require("snacks").picker.lsp_symbols({ hidden = true }) end,                           desc = "LSP Symbols" },
      { "<leader>sS",      function() require("snacks").picker.lsp_workspace_symbols({ hidden = true }) end,                 desc = "LSP Workspace Symbols" },

      -- Buffers
      { "<leader>bc",      function() require("snacks").bufdelete.delete() end,                                              desc = "Delete current buffer" },
      { "<leader>bfc",     function() require("snacks").bufdelete.delete({ force = true }) end,                              desc = "Force delete current buffer" },
      { "<leader>bo",      function() require("snacks").bufdelete.other() end,                                               desc = "Delete other buffers" },
      { "<leader>ba",      function() require("snacks").bufdelete.all() end,                                                 desc = "Delete all buffers" },

      -- Other
      { "<leader>gb",      function() require("snacks").git.blame_line() end,                                                desc = "Git Blame" },
      { "<leader>gB",      function() require("snacks").gitbrowse() end,                                                     desc = "Git Browse",                 mode = { "n", "v" } },
      { "]]",              function() require("snacks").words.jump(vim.v.count1) end,                                        desc = "Next LSP Reference",         mode = { "n", "t" } },
      { "[[",              function() require("snacks").words.jump(-vim.v.count1) end,                                       desc = "Prev LSP Reference",         mode = { "n", "t" } },
      { "<leader>z",       function() require("snacks").zen() end,                                                           desc = "Zen Mode" },
      { "<leader>cR",      function() require("snacks").rename.rename_file() end,                                            desc = "Rename File" },
    }
  }
}
