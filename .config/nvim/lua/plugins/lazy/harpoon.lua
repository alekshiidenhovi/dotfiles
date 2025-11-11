return {
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      local harpoon = require("harpoon")
      local harpoon_extensions = require("harpoon.extensions")

      harpoon:setup()
      harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
    end,
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end,     desc = "Add to Harpoon", },
      {
        "<leader>hl",
        function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
        desc = "Harpoon quick menu",
      },
      { "<leader>h1", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1", },
      { "<leader>h2", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2", },
      { "<leader>h3", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3", },
      { "<leader>h4", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4", },
      { "<leader>h5", function() require("harpoon"):list():select(5) end, desc = "Harpoon to file 5", },
      { "<leader>h6", function() require("harpoon"):list():select(6) end, desc = "Harpoon to file 6", },
      { "<leader>h7", function() require("harpoon"):list():select(7) end, desc = "Harpoon to file 7", },
      { "<leader>h8", function() require("harpoon"):list():select(8) end, desc = "Harpoon to file 8", },
      { "<leader>h9", function() require("harpoon"):list():select(9) end, desc = "Harpoon to file 9", },
    },
  },
}
