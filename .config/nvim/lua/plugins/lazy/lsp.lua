local function resolve_nix_path(command)
  local handle = io.popen("command -v " .. command)
  local path = handle:read("*a"):gsub("%s+", "")
  handle:close()

  if path == "" then return nil end

  -- Resolve symlink to the actual /nix/store path
  local real_path_handle = io.popen("readlink -f " .. path)
  local real_path = real_path_handle:read("*a"):gsub("%s+", "")
  real_path_handle:close()

  return real_path
end

-- local function get_vue_ts_plugin_path()
--   local real_path = resolve_nix_path("vue-language-server")
--   if not real_path then return nil end
--   vim.notify("vue-language-server path: " .. real_path)
--   return real_path:gsub("/bin/vue-language-server$", "/lib/language-tools/packages/typescript-plugin")
-- end
--
local function get_vue_ts_plugin_path()
  local binary_path = resolve_nix_path("vue-language-server")
  if not binary_path then
    vim.notify("vue-language-server not found in PATH. Ensure it is in systemPackages.", vim.log.levels.WARN)
    return nil
  end

  -- Use match to grab everything before /bin/ and append the library path
  -- This is more reliable than gsub for Nix store paths
  local root_path = binary_path:match("(.*)/bin/vue%-language%-server")
  if not root_path then
    vim.notify("Was unable to match vue-language-server path. Ensure it is in systemPackages.", vim.log.levels.WARN)
    return nil
  end

  return root_path .. "/lib/language-tools/packages/language-server"
end

local function get_typescript_server_path()
  local binary_path = resolve_nix_path("tsserver")
  if not binary_path then
    vim.notify("tsserver not found in PATH. Ensure it is in systemPackages.", vim.log.levels.WARN)
    return nil
  end

  local root_path = binary_path:match("(.*)/bin/tsserver")
  if not root_path then
    vim.notify("Was unable to match tsserver path. Ensure it is in systemPackages.", vim.log.levels.WARN)
  end

  return root_path .. "/lib/node_modules/typescript/lib"
end

local vue_ls_dir_path = get_vue_ts_plugin_path()
local ts_lib_path = get_typescript_server_path()

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
    },
    typescript = {
      tsdk = ts_lib_path,
    },
  },
}

local astro_config = {
  init_options = {
    typescript = {
      tsdk = ts_lib_path,
    },
  },
}

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
      'folke/lazydev.nvim',
    },
    opts = {
      servers = {
        astro = astro_config,
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
