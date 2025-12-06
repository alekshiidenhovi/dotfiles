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
- Follow Effective Dart guidelines: https://dart.dev/effective-dart/documentation.
]],
    docstring_locations = {
      "functions",
      "classes",
      "methods",
      "constructors",
      "fields",
      "enums",
    },
  },

  rust = {
    language_rules = [[
Documentation is generated using rustdoc.

# Syntax
The `///` syntax is used to document the item present after it, e.g. a function, trait, etc. The `//!` syntax is used to document the item it is present inside, e.g. the entire crate.

# Rules
All public items must be documented.

# #[doc] attribute

## Crates

Documenting a crate should begin with front-page documentation. Summarize the role of the crate with a single sentence without highly technical details. Then explain to readers why you want to use the crate.

After introducing the crate, provide examples of how to use the crate. Focus on the library's role in the examples, but provide working code, so users may copy and paste examples to get started.

## Components
Components, such as modules, structs, functions or macros, should be documented with a `///` block. It is recommended that each item's documentation follows this basic structure:

```
[short sentence explaining what the component does]

[more detailed explanation]

[at least one code example that users can copy/paste to try it]

[even more advanced explanations if necessary]
```

Have a dedicated arguments (h1) and returns (h1) sections to describe what the arguments and return values represent. Leave out the type signature from these sections, they are added automatically by rustdoc. In case of a result return type, describe the success criteria and each failure case with a single sentence.

```
/// One line summary of the core functionality of the function.
///
/// # Arguments
///
/// * `arg1`: One sentence description of the first argument.
/// * `arg2`: Another one sentence description of the second argument.
///
/// # Returns
///
/// A single sentence description of the success case.
/// - A single sentence description for each optional failure case.
///
/// # Examples
///
/// ```
fn example_function(arg1: Type1, arg2: Type2) -> Result<Type3, Error> {
    // code
}
```

A panic section is recommended every time edge cases in your code can be reached if known.

## Markdown
`rustdoc` uses the CommonMark Markdown specification. In addition to the standard CommonMark syntax, `rustdoc` support several extensions, such as strikethroughs, footnotes, tables, task lists, smart punctuation and warning blocks.

# Documentation tests
`rustdoc` supports executing documentation examples as tests.

The basic syntax is the following:
```rust
/// # Examples
///
/// ```
/// let x = 5;
/// assert_eq!(x, 5);
/// ````
```
Triple backticks start and end code blocks. By default, rustdoc assumes blocks to be Rust code, but you can specify your own language after the first backticks.

Write each test in a separate code block.

You may add lines that start with `#` to hide parts of the tested code. Use this to ensure that tests compile successfully, while maintaining easy readability of the tests.

`?` may be used to skip complete error handling in doc tests. You must ensure that the error type is disambiguated.

Attributes can be used to help `rustdoc` do the right thing when testing your code. `should_panic` tells that the code should compile correctly but panic during execution. `no_run` should be able to compile the code but not run it. `compile_fail` tells that the compilation ought to fail.
]],
    docstring_locations = {
      "functions",
      "modules",
      "structs",
      "traits",
      "enums",
      "constants",
      "crates",
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
[ROLE]
- You are an expert in documenting code by adding helpful docstrings.

[GENERAL RULES]
- Do not modify nor remove existing code.
- Do not add new code
- Only add comments/docstrings to specified places.

[LANGUAGE-SPECIFIC RULES (filetype: %s)]
%s

[SCOPE]
%s - %s
‰s
[TASK]
- Follow the general and language-specific documentation rules, and add/update docstrings to the defined scope.
- Include also the unmodified parts of the code in the output (imports, etc.).
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
