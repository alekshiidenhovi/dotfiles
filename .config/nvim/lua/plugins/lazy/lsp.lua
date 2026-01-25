local function get_vue_ts_plugin_path()
  local handle = io.popen("command -v vue-language-server")
  local path = handle:read("*a"):gsub("%s+", "")
  handle:close()

  if path == "" then
    return nil
  end

  -- Nix usually installs the actual JS files relative to the binary:
  -- Binary: /nix/store/.../bin/vue-language-server
  -- Plugin: /nix/store/.../lib/node_modules/@vue/language-server
  return path:gsub("/bin/vue-language-server$", "/lib/node_modules/@vue/language-server")
end

local vue_ls_dir_path = get_vue_ts_plugin_path()

if not vue_ls_dir_path then
  vim.notify("vue-language-server not found in PATH. Ensure it is in systemPackages.", vim.log.levels.WARN)
end

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_ls_dir_path,
  languages = { "vue" },
  configNamespace = "typescript"
}

local vtsls_config = {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin }
      }
    }
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    opts = {
      servers = {
        biome = {},
        clangd = {},
        cmake = {},
        dartls = {},
        docker_language_server = {},
        gleam = {},
        jsonls = {},
        lua_ls = {},
        nixd = {},
        ruff = {},
        rust_analyzer = {},
        sqruff = {},
        svelte = {},
        tailwindcss = {},
        vtsls = vtsls_config,
        vue_ls = {},
      }
    },
    config = function(_, opts)
      -- Link capabilities between LSP and blink.cmp
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        if server == "clangd" then
          config.cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--enable-config", -- make clangd read your .clangd file
            "--completion-style=detailed",
            "--all-scopes-completion",
          }
        end
        vim.lsp.config(server, config)
      end

      vim.lsp.enable(vim.tbl_keys(opts.servers))

      -- Setup autoformatting on save
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          if not client then return end

          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
