return {
  {
    "ellisonleao/dotenv.nvim",
    config = function()
      require("dotenv").setup({
        enable_on_load = true,
        verbose = true,
        file_name = vim.fn.stdpath("config") .. "/.env"
      })
    end
  }
}
