---@alias InlineComment.Scope '"function"' | '"class"' | '"block"' | '"line"' | '"buffer"'
---@alias InlineComment.TSScope '"function"' | '"class"' | '"block"'
---@alias InlineComment.Filetype string


---@class InlineComment.LanguageConfig
---@field language_rules string
---@field docstring_locations string[]


---@class InlineComment
---@field get_filetype function
---@field construct_docstring_generation_prompt function
---@field visually_select_scope function
local M = {}


--- Table mapping filetypes to their configuration
---@type table<InlineComment.Filetype, InlineComment.LanguageConfig>
local language_configs = {
  python = {
    language_rules = [[
- Use NumPy-style docstrings
- Include 'Parameters', 'Returns', and 'Examples' sections where relevant.
- Use triple double quotes for multi-line docstrings.
]],
    docstring_locations = {
      "functions",
      "classes",
      "methods",
      "modules",
    },
  },

  lua = {
    language_rules = [[
- Use LuaDoc-style comments starting with three hyphens (---).
- Document function parameters and return values using @param and @return tags.
]],
    docstring_locations = {
      "functions",
      "modules",
    },
  },

  javascript = {
    language_rules = [[
- Use JSDoc-style comments with /** ... */.
- Document function arguments with @param and return value with @returns.
]],
    docstring_locations = {
      "functions",
      "classes",
      "methods",
    },
  },

  dart = {
    language_rules = [[
- Use DartDoc-style comments starting with three slashes (///).
- Document function parameters and return values using @param and @return tags."
]],
    docstring_locations = {
      "functions",
      "classes",
      "methods",
      "constructors",
      "fields",
      "enums",
    },
  }
}


---@type table<InlineComment.Scope, string>
local scope_instructions = {
  ["line"] = "Add a docstring for highlighted line only.",
  ["function"] = "Add a docstring for the highlighted function only.",
  ["class"] =
  "Add a docstring the highlighted class and all of its public and private fields, constructors, and methods.",
  ["block"] = "Add a docstring for all relevant code elements within the highlighted block.",
  ["buffer"] = "Add a docstring for all relevant code elements within the entire file.",
}


---@type table<InlineComment.TSScope, string>
local ts_scope_map = {
  ["function"] = "@function.outer",
  ["class"] = "@class.outer",
  ["block"] = "@block.outer",
}


local prompt_template = [[
Role:
- You are an expert in documenting code by adding helpful docstrings.

Programming language:
- The filetype of the file you need to modify is %s.

General rules:
- Do not modify existing code
- Do not add new code
- Only add comments to specified places.

Language-specific rules:
%s

Scope:
%s - %s
‰s
Task:
- Follow the general and language-specific documentation rules, and add documentation/docstrings to the defined scope.
]]


--- Format a table of strings as bullet list lines
---@param items string[]
---@return string
local function format_bullet_list(items)
  local formatted = {}
  for _, item in ipairs(items or {}) do
    table.insert(formatted, "- " .. item)
  end
  return table.concat(formatted, "\n")
end


---@return string
function M.get_filetype()
  return vim.bo.filetype
end

--- Construct a docstring generation prompt from template
---@param filetype InlineComment.Filetype
---@param scope InlineComment.Scope
---@return string | nil
function M.construct_docstring_generation_prompt(filetype, scope)
  local config = language_configs[filetype]

  if not config then
    vim.notify("Invalid filetype: " .. filetype, vim.log.levels.ERROR)
    return nil
  end

  local scope_instruction = scope_instructions[scope]
  if not scope_instruction then
    vim.notify("Invalid tree-sitter scope" .. scope, vim.log.levels.ERROR)
    return nil
  end

  local scope_rule_list = "\n"
  if scope == "block" or scope == "buffer" then
    scope_rule_list = scope_rule_list .. format_bullet_list(config.docstring_locations)
  end

  return string.format(
    prompt_template,
    filetype,
    config.language_rules,
    scope,
    scope_instruction,
    scope_rule_list
  )
end

--- Visually select the scope with Tree-sitter
---@param scope InlineComment.Scope
---@return boolean
function M.ts_visually_select_scope(scope)
  if scope == "line" then
    vim.cmd("normal! V")    -- visual select current line
  elseif scope == "buffer" then
    vim.cmd("normal! ggVG") -- select entire buffer
  elseif ts_scope_map[scope] then
    vim.cmd("normal! V")
    vim.cmd("TSTextobjectSelect " .. ts_scope_map[scope])
  else
    vim.notify("Invalid tree-sitter scope: " .. scope, vim.log.levels.ERROR)
    return false
  end

  return true
end

return M
