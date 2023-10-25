-- Custom theme based on Horizon Dark

local palette = require("nxs.theme.palette")

vim.cmd("hi clear")

vim.o.background = 'dark'
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'horizon'

local hl = vim.api.nvim_set_hl;

-- Editor
hl(0, "Normal", { fg = palette.fg, bg = palette.bg })
hl(0, "SignColumn", { fg = 'NONE', bg = palette.bg })
hl(0, "MsgArea", { fg = palette.fg, bg = palette.bg })
hl(0, "ModeMsg", { fg = palette.fg, bg = palette.alt_bg })
hl(0, "MsgSeparator", { fg = palette.fg, bg = palette.bg })
hl(0, "SpellBad", { fg = 'NONE', bg = 'NONE', sp = palette.red, undercurl = true, })
hl(0, "SpellCap", { fg = 'NONE', bg = 'NONE', sp = palette.yellow, undercurl = true, })
hl(0, "SpellLocal", { fg = 'NONE', bg = 'NONE', sp = palette.yelloworange, underline = true, })
hl(0, "SpellRare", { fg = 'NONE', bg = 'NONE', sp = palette.purple, underline = true, })
hl(0, "NormalNC", { fg = palette.fg, bg = palette.bg })
hl(0, "Pmenu", { fg = palette.light_gray, bg = palette.alt_bg })
hl(0, "PmenuSel", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "WildMenu", { fg = palette.fg, bg = palette.ui2_blue })
hl(0, "CursorLineNr", { fg = palette.light_gray, bg = 'NONE', bold = true, })
hl(0, "Folded", { fg = palette.gray, bg = palette.alt_bg })
hl(0, "FoldColumn", { fg = palette.gray, bg = palette.alt_bg })
hl(0, "LineNr", { fg = palette.gray, bg = 'NONE' })
hl(0, "FloatBoder", { fg = palette.gray, bg = palette.alt_bg })
hl(0, "Whitespace", { fg = palette.bg, bg = 'NONE' })
hl(0, "VertSplit", { fg = palette.gray, bg = palette.bg })
hl(0, "CursorLine", { fg = 'NONE', bg = palette.dark_gray })
hl(0, "CursorColumn", { fg = 'NONE', bg = palette.alt_bg })
hl(0, "ColorColumn", { fg = 'NONE', bg = palette.alt_bg })
hl(0, "NormalFloat", { fg = 'NONE', bg = palette.alt_bg })
hl(0, "Visual", { fg = 'NONE', bg = palette.ui_blue })
hl(0, "VisualNOS", { fg = 'NONE', bg = palette.alt_bg })
hl(0, "WarningMsg", { fg = palette.error, bg = palette.bg })
hl(0, "DiffText", { fg = palette.alt_bg, bg = palette.sign_delete })
hl(0, "DiffAdd", { fg = palette.alt_bg, bg = palette.sign_add })
hl(0, "DiffChange", { fg = palette.alt_bg, bg = palette.sign_change, underline = true, })
hl(0, "DiffDelete", { fg = palette.alt_bg, bg = palette.sign_delete })
hl(0, "QuickFixLine", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "PmenuSbar", { fg = 'NONE', bg = palette.alt_bg })
hl(0, "PmenuThumb", { fg = 'NONE', bg = palette.gray })
hl(0, "MatchWord", { fg = 'NONE', bg = 'NONE', underline = true, })
hl(0, "MatchParen", { fg = palette.hint, bg = 'NONE', underline = true, })
hl(0, "MatchWordCur", { fg = 'NONE', bg = 'NONE', underline = true, })
hl(0, "MatchParenCur", { fg = 'NONE', bg = 'NONE', underline = true, })
hl(0, "Cursor", { fg = palette.cursor_fg, bg = palette.cursor_bg })
hl(0, "lCursor", { fg = palette.cursor_fg, bg = palette.cursor_bg })
hl(0, "CursorIM", { fg = palette.cursor_fg, bg = palette.cursor_bg })
hl(0, "TermCursor", { fg = palette.cursor_fg, bg = palette.cursor_bg })
hl(0, "TermCursorNC", { fg = palette.cursor_fg, bg = palette.cursor_bg })
hl(0, "Conceal", { fg = palette.gray, bg = 'NONE' })
hl(0, "Directory", { fg = palette.folder_blue, bg = 'NONE' })
hl(0, "SpecialKey", { fg = palette.red, bg = 'NONE', bold = true, })
hl(0, "ErrorMsg", { fg = palette.error, bg = palette.bg, bold = true, })
hl(0, "Search", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "IncSearch", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "Substitute", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "MoreMsg", { fg = palette.orange, bg = 'NONE' })
hl(0, "Question", { fg = palette.orange, bg = 'NONE' })
hl(0, "EndOfBuffer", { fg = palette.bg, bg = 'NONE' })
hl(0, "NonText", { fg = palette.bg, bg = 'NONE' })
hl(0, "TabLine", { fg = palette.light_gray, bg = palette.line })
hl(0, "TabLineSel", { fg = palette.fg, bg = palette.line })
hl(0, "TabLineFill", { fg = palette.line, bg = palette.line })

-- Code
hl(0, "Comment", { fg = palette.gray, bg = 'NONE' })
hl(0, "Variable", { fg = palette.red, bg = 'NONE' })
hl(0, "String", { fg = palette.yelloworange, bg = 'NONE' })
hl(0, "Character", { fg = palette.yelloworange, bg = 'NONE' })
hl(0, "Number", { fg = palette.orange, bg = 'NONE' })
hl(0, "Float", { fg = palette.orange, bg = 'NONE' })
hl(0, "Boolean", { fg = palette.orange, bg = 'NONE' })
hl(0, "Constant", { fg = palette.orange, bg = 'NONE' })
hl(0, "Type", { fg = palette.yellow, bg = 'NONE' })
hl(0, "Function", { fg = palette.cyan, bg = 'NONE' })
hl(0, "Keyword", { fg = palette.purple, bg = 'NONE' })
hl(0, "Conditional", { fg = palette.purple, bg = 'NONE' })
hl(0, "Repeat", { fg = palette.purple, bg = 'NONE' })
hl(0, "Operator", { fg = palette.fg, bg = 'NONE' })
hl(0, "PreProc", { fg = palette.purple, bg = 'NONE' })
hl(0, "Include", { fg = palette.purple, bg = 'NONE' })
hl(0, "Exception", { fg = palette.purple, bg = 'NONE' })
hl(0, "StorageClass", { fg = palette.yellow, bg = 'NONE' })
hl(0, "Structure", { fg = palette.yellow, bg = 'NONE' })
hl(0, "Typedef", { fg = palette.purple, bg = 'NONE' })
hl(0, "Define", { fg = palette.purple, bg = 'NONE' })
hl(0, "Macro", { fg = palette.purple, bg = 'NONE' })
hl(0, "Debug", { fg = palette.red, bg = 'NONE' })
hl(0, "Title", { fg = palette.yellow, bg = 'NONE', bold = true, })
hl(0, "Label", { fg = palette.fg, bg = 'NONE' })
hl(0, "SpecialChar", { fg = palette.yelloworange, bg = 'NONE' })
hl(0, "Delimiter", { fg = palette.fg, bg = 'NONE' })
hl(0, "SpecialComment", { fg = palette.fg, bg = 'NONE' })
hl(0, "Tag", { fg = palette.red, bg = 'NONE' })
hl(0, "Bold", { fg = 'NONE', bg = 'NONE', bold = true, })
hl(0, "Italic", { fg = 'NONE', bg = 'NONE', italic = true, })
hl(0, "Underlined", { fg = 'NONE', bg = 'NONE', underline = true, })
hl(0, "Ignore", { fg = palette.hint, bg = 'NONE', bold = true, })
hl(0, "Todo", { fg = palette.info, bg = 'NONE', bold = true, })
hl(0, "Error", { fg = palette.error, bg = 'NONE', bold = true, })
hl(0, "Statement", { fg = palette.purple, bg = 'NONE' })
hl(0, "Identifier", { fg = palette.fg, bg = 'NONE' })
hl(0, "PreCondit", { fg = palette.purple, bg = 'NONE' })
hl(0, "Special", { fg = palette.orange, bg = 'NONE' })

-- Treesitter
hl(0, "TSComment", { link = 'Comment' })
hl(0, "TSVariable", { link = 'Variable' })
hl(0, "TSString", { link = 'String' })
hl(0, "TSStringRegex", { link = 'String' })
hl(0, "TSStringEscape", { link = 'String' })
hl(0, "TSCharacter", { link = 'String' })
hl(0, "TSCharacterSpecial", { link = 'SpecialChar' })
hl(0, "TSNumber", { link = 'Number' })
hl(0, "TSFloat", { link = 'Float' })
hl(0, "TSBoolean", { link = 'Boolean' })
hl(0, "TSConstant", { link = 'Constant' })
hl(0, "TSConstBuiltin", { link = 'Constant' })
hl(0, "TSConstructor", { link = 'Type' })
hl(0, "TSType", { link = 'Type' })
hl(0, "TSInclude", { link = 'Include' })
hl(0, "TSException", { link = 'Exception' })
hl(0, "TSKeyword", { link = 'Keyword' })
hl(0, "TSKeywordReturn", { link = 'Keyword' })
hl(0, "TSKeywordOperator", { link = 'Keyword' })
hl(0, "TSKeywordFunction", { link = 'Keyword' })
hl(0, "TSFunction", { link = 'Function' })
hl(0, "TSFuncBuiltin", { link = 'Function' })
hl(0, "TSMethod", { link = 'Function' })
hl(0, "TSFuncMacro", { link = 'Function' })
hl(0, "TSConditional", { link = 'Conditional' })
hl(0, "TSRepeat", { link = 'Repeat' })
hl(0, "TSOperator", { link = 'Operator' })
hl(0, "TSPreProc", { link = 'PreProc' })
hl(0, "TSStorageClass", { link = 'StorageClass' })
hl(0, "TSStructure", { link = 'Structure' })
hl(0, "TSTypeDefinition", { link = 'Typedef' })
hl(0, "TSDefine", { link = 'Define' })
hl(0, "TSNote", { link = 'Comment' })
hl(0, "TSNone", { fg = palette.light_gray, bg = 'NONE' })
hl(0, "TSTodo", { link = 'Todo' })
hl(0, "TSDebug", { link = 'Debug' })
hl(0, "TSDanger", { link = 'Error' })
hl(0, "TSTitle", { link = 'Title' })
hl(0, "TSLabel", { link = 'Label' })
hl(0, "TSPunctDelimiter", { link = 'Delimiter' })
hl(0, "TSTagDelimiter", { fg = palette.red, bg = 'NONE' })
hl(0, "TSPunctBracket", { link = 'Delimiter' })
hl(0, "TSPunctSpecial", { link = 'Delimiter' })
hl(0, "TSTag", { link = 'Tag' })
hl(0, "TSStrong", { link = 'Bold' })
hl(0, "TSEmphasis", { link = 'Italic' })
hl(0, "TSUnderline", { link = 'Underline' })
hl(0, "TSStrike", { fg = 'NONE', bg = 'NONE', strikethrough = true, })
hl(0, "TSStringSpecial", { fg = palette.fg, bg = 'NONE' })
hl(0, "TSEnvironmentName", { fg = palette.cyan, bg = 'NONE' })
hl(0, "TSVariableBuiltin", { fg = palette.yellow, bg = 'NONE' })
hl(0, "TSConstMacro", { fg = palette.orange, bg = 'NONE' })
hl(0, "TSTypeBuiltin", { fg = palette.orange, bg = 'NONE' })
hl(0, "TSAnnotation", { fg = palette.cyan, bg = 'NONE' })
hl(0, "TSNamespace", { fg = palette.cyan, bg = 'NONE' })
hl(0, "TSSymbol", { fg = palette.fg, bg = 'NONE' })
hl(0, "TSField", { fg = palette.red, bg = 'NONE' })
hl(0, "TSProperty", { fg = palette.red, bg = 'NONE' })
hl(0, "TSParameter", { fg = palette.red, bg = 'NONE' })
hl(0, "TSParameterReference", { fg = palette.red, bg = 'NONE' })
hl(0, "TSAttribute", { fg = palette.red, bg = 'NONE' })
hl(0, "TSText", { fg = palette.alt_fg, bg = 'NONE' })
hl(0, "TSTagAttribute", { fg = palette.orange, bg = 'NONE', italic = true, })
hl(0, "TSError", { fg = palette.error, bg = 'NONE' })
hl(0, "TSWarning", { fg = palette.warn, bg = 'NONE' })
hl(0, "TSQueryLinterError", { fg = palette.error, bg = 'NONE' })
hl(0, "TSURI", { fg = palette.cyan, bg = 'NONE', underline = true, })
hl(0, "TSMath", { fg = palette.yellow, bg = 'NONE' })
hl(0, "TSLiteral", { fg = palette.orange, bg = 'NONE' })
hl(0, "@comment", { link = 'Comment' })
hl(0, "@variable", { link = 'Variable' })
hl(0, "@string", { link = 'String' })
hl(0, "@string.regex", { link = 'String' })
hl(0, "@string.escape", { link = 'String' })
hl(0, "@character", { link = 'String' })
hl(0, "@character.special", { link = 'SpecialChar' })
hl(0, "@number", { link = 'Number' })
hl(0, "@float", { link = 'Float' })
hl(0, "@boolean", { link = 'Boolean' })
hl(0, "@constant", { link = 'Constant' })
hl(0, "@constant.builtin", { link = 'Constant' })
hl(0, "@constructor", { link = 'Type' })
hl(0, "@type", { link = 'Type' })
hl(0, "@include", { link = 'Include' })
hl(0, "@exception", { link = 'Exception' })
hl(0, "@keyword", { link = 'Keyword' })
hl(0, "@keyword.return", { link = 'Keyword' })
hl(0, "@keyword.operator", { link = 'Keyword' })
hl(0, "@keyword.function", { link = 'Keyword' })
hl(0, "@function", { link = 'Function' })
hl(0, "@function.builtin", { link = 'Function' })
hl(0, "@method", { link = 'Function' })
hl(0, "@function.macro", { link = 'Function' })
hl(0, "@conditional", { link = 'Conditional' })
hl(0, "@repeat", { link = 'Repeat' })
hl(0, "@operator", { link = 'Operator' })
hl(0, "@preproc", { link = 'PreProc' })
hl(0, "@storageclass", { link = 'StorageClass' })
hl(0, "@structure", { link = 'Structure' })
hl(0, "@type.definition", { link = 'Typedef' })
hl(0, "@define", { link = 'Define' })
hl(0, "@note", { link = 'Comment' })
hl(0, "@none", { fg = palette.light_gray, bg = 'NONE' })
hl(0, "@todo", { link = 'Todo' })
hl(0, "@debug", { link = 'Debug' })
hl(0, "@danger", { link = 'Error' })
hl(0, "@title", { link = 'Title' })
hl(0, "@label", { link = 'Label' })
hl(0, "@punctuation.delimiter", { link = 'Delimiter' })
hl(0, "@tag.delimiter", { fg = palette.red, bg = 'NONE' })
hl(0, "@punctuation.bracket", { link = 'Delimiter' })
hl(0, "@punctuation.special", { link = 'Delimiter' })
hl(0, "@tag", { link = 'Tag' })
hl(0, "@strong", { link = 'Bold' })
hl(0, "@emphasis", { link = 'Italic' })
hl(0, "@underline", { link = 'Underline' })
hl(0, "@strike", { fg = 'NONE', bg = 'NONE', strikethrough = true, })
hl(0, "@string.special", { fg = palette.fg, bg = 'NONE' })
hl(0, "@environment.name", { fg = palette.cyan, bg = 'NONE' })
hl(0, "@variable.builtin", { fg = palette.yellow, bg = 'NONE' })
hl(0, "@const.macro", { fg = palette.orange, bg = 'NONE' })
hl(0, "@type.builtin", { fg = palette.orange, bg = 'NONE' })
hl(0, "@annotation", { fg = palette.cyan, bg = 'NONE' })
hl(0, "@namespace", { fg = palette.cyan, bg = 'NONE' })
hl(0, "@symbol", { fg = palette.fg, bg = 'NONE' })
hl(0, "@field", { fg = palette.red, bg = 'NONE' })
hl(0, "@property", { fg = palette.red, bg = 'NONE' })
hl(0, "@parameter", { fg = palette.red, bg = 'NONE' })
hl(0, "@parameter.reference", { fg = palette.red, bg = 'NONE' })
hl(0, "@attribute", { fg = palette.red, bg = 'NONE' })
hl(0, "@text", { fg = palette.alt_fg, bg = 'NONE' })
hl(0, "@tag.attribute", { fg = palette.orange, bg = 'NONE', italic = true, })
hl(0, "@error", { fg = palette.error, bg = 'NONE' })
hl(0, "@warning", { fg = palette.warn, bg = 'NONE' })
hl(0, "@query.linter.error", { fg = palette.error, bg = 'NONE' })
hl(0, "@uri", { fg = palette.cyan, bg = 'NONE', underline = true, })
hl(0, "@math", { fg = palette.yellow, bg = 'NONE' })


-- Whichkey
hl(0, "WhichKey", { fg = palette.purple, bg = 'NONE' })
hl(0, "WhichKeySeperator", { fg = palette.yellow, bg = 'NONE' })
hl(0, "WhichKeyGroup", { fg = palette.red, bg = 'NONE' })
hl(0, "WhichKeyDesc", { fg = palette.fg, bg = 'NONE' })
hl(0, "WhichKeyFloat", { fg = 'NONE', bg = palette.alt_bg })

-- Git
hl(0, "SignAdd", { fg = palette.sign_add, bg = 'NONE' })
hl(0, "SignChange", { fg = palette.sign_change, bg = 'NONE' })
hl(0, "SignDelete", { fg = palette.sign_delete, bg = 'NONE' })
hl(0, "GitSignsAdd", { fg = palette.sign_add, bg = 'NONE' })
hl(0, "GitSignsChange", { fg = palette.sign_change, bg = 'NONE' })
hl(0, "GitSignsDelete", { fg = palette.sign_delete, bg = 'NONE' })

-- LSP
hl(0, "DiagnosticHint", { fg = palette.hint, bg = 'NONE' })
hl(0, "DiagnosticInfo", { fg = palette.info, bg = 'NONE' })
hl(0, "DiagnosticWarn", { fg = palette.warn, bg = 'NONE' })
hl(0, "DiagnosticError", { fg = palette.error, bg = 'NONE' })
hl(0, "DiagnosticOther", { fg = palette.ui_purple, bg = 'NONE' })
hl(0, "DiagnosticSignHint", { link = 'DiagnosticHint' })
hl(0, "DiagnosticSignInfo", { link = 'DiagnosticInfo' })
hl(0, "DiagnosticSignWarn", { link = 'DiagnosticWarn' })
hl(0, "DiagnosticSignError", { link = 'DiagnosticError' })
hl(0, "DiagnosticSignOther", { link = 'DiagnosticOther' })
hl(0, "DiagnosticSignWarning", { link = 'DiagnosticWarn' })
hl(0, "DiagnosticFloatingHint", { link = 'DiagnosticHint' })
hl(0, "DiagnosticFloatingInfo", { link = 'DiagnosticInfo' })
hl(0, "DiagnosticFloatingWarn", { link = 'DiagnosticWarn' })
hl(0, "DiagnosticFloatingError", { link = 'DiagnosticError' })
hl(0, "DiagnosticUnderlineHint", { fg = 'NONE', bg = 'NONE', sp = palette.hint, undercurl = true, })
hl(0, "DiagnosticUnderlineInfo", { fg = 'NONE', bg = 'NONE', sp = palette.info, undercurl = true, })
hl(0, "DiagnosticUnderlineWarn", { fg = 'NONE', bg = 'NONE', sp = palette.warn, undercurl = true, })
hl(0, "DiagnosticUnderlineError", { fg = 'NONE', bg = 'NONE', sp = palette.error, undercurl = true, })
hl(0, "DiagnosticSignInformation", { link = 'DiagnosticInfo' })
hl(0, "DiagnosticVirtualTextHint", { fg = palette.hint, bg = palette.hint_bg })
hl(0, "DiagnosticVirtualTextInfo", { fg = palette.info, bg = palette.info_bg })
hl(0, "DiagnosticVirtualTextWarn", { fg = palette.warn, bg = palette.warn_bg })
hl(0, "DiagnosticVirtualTextError", { fg = palette.error, bg = palette.error_bg })
hl(0, "LspDiagnosticsError", { fg = palette.error, bg = 'NONE' })
hl(0, "LspDiagnosticsWarning", { fg = palette.warn, bg = 'NONE' })
hl(0, "LspDiagnosticsInfo", { fg = palette.info, bg = 'NONE' })
hl(0, "LspDiagnosticsInformation", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsHint", { fg = palette.hint, bg = 'NONE' })
hl(0, "LspDiagnosticsDefaultError", { link = 'LspDiagnosticsError' })
hl(0, "LspDiagnosticsDefaultWarning", { link = 'LspDiagnosticsWarning' })
hl(0, "LspDiagnosticsDefaultInformation", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsDefaultInfo", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsDefaultHint", { link = 'LspDiagnosticsHint' })
hl(0, "LspDiagnosticsVirtualTextError", { link = 'DiagnosticVirtualTextError' })
hl(0, "LspDiagnosticsVirtualTextWarning", { link = 'DiagnosticVirtualTextWarn' })
hl(0, "LspDiagnosticsVirtualTextInformation", { link = 'DiagnosticVirtualTextInfo' })
hl(0, "LspDiagnosticsVirtualTextInfo", { link = 'DiagnosticVirtualTextInfo' })
hl(0, "LspDiagnosticsVirtualTextHint", { link = 'DiagnosticVirtualTextHint' })
hl(0, "LspDiagnosticsFloatingError", { link = 'LspDiagnosticsError' })
hl(0, "LspDiagnosticsFloatingWarning", { link = 'LspDiagnosticsWarning' })
hl(0, "LspDiagnosticsFloatingInformation", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsFloatingInfo", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsFloatingHint", { link = 'LspDiagnosticsHint' })
hl(0, "LspDiagnosticsSignError", { link = 'LspDiagnosticsError' })
hl(0, "LspDiagnosticsSignWarning", { link = 'LspDiagnosticsWarning' })
hl(0, "LspDiagnosticsSignInformation", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsSignInfo", { link = 'LspDiagnosticsInfo' })
hl(0, "LspDiagnosticsSignHint", { link = 'LspDiagnosticsHint' })
hl(0, "NvimTreeLspDiagnosticsError", { link = 'LspDiagnosticsError' })
hl(0, "NvimTreeLspDiagnosticsWarning", { link = 'LspDiagnosticsWarning' })
hl(0, "NvimTreeLspDiagnosticsInformation", { link = 'LspDiagnosticsInfo' })
hl(0, "NvimTreeLspDiagnosticsInfo", { link = 'LspDiagnosticsInfo' })
hl(0, "NvimTreeLspDiagnosticsHint", { link = 'LspDiagnosticsHint' })
hl(0, "LspDiagnosticsUnderlineError", { link = 'DiagnosticUnderlineError' })
hl(0, "LspDiagnosticsUnderlineWarning", { link = 'DiagnosticUnderlineWarn' })
hl(0, "LspDiagnosticsUnderlineInformation", { link = 'DiagnosticUnderlineInfo' })
hl(0, "LspDiagnosticsUnderlineInfo", { link = 'DiagnosticUnderlineInfo' })
hl(0, "LspDiagnosticsUnderlineHint", { link = 'DiagnosticUnderlineHint' })
hl(0, "LspReferenceRead", { fg = 'NONE', bg = palette.reference })
hl(0, "LspReferenceText", { fg = 'NONE', bg = palette.reference })
hl(0, "LspReferenceWrite", { fg = 'NONE', bg = palette.reference })
hl(0, "LspCodeLens", { fg = palette.context, bg = 'NONE', italic = true, })
hl(0, "LspCodeLensSeparator", { fg = palette.context, bg = 'NONE', italic = true, })

-- Telescope
hl(0, "TelescopeSelection", { fg = 'NONE', bg = palette.ui2_blue })
hl(0, "TelescopeSelectionCaret", { fg = palette.red, bg = palette.ui2_blue })
hl(0, "TelescopeMatching", { fg = palette.yellow, bg = 'NONE', bold = true, italic = true, })
hl(0, "TelescopeBorder", { fg = palette.alt_fg, bg = 'NONE' })
hl(0, "TelescopeNormal", { fg = palette.light_gray, bg = palette.alt_bg })
hl(0, "TelescopePromptTitle", { fg = palette.orange, bg = 'NONE' })
hl(0, "TelescopePromptPrefix", { fg = palette.cyan, bg = 'NONE' })
hl(0, "TelescopeResultsTitle", { fg = palette.orange, bg = 'NONE' })
hl(0, "TelescopePreviewTitle", { fg = palette.orange, bg = 'NONE' })
hl(0, "TelescopePromptCounter", { fg = palette.red, bg = 'NONE' })
hl(0, "TelescopePreviewHyphen", { fg = palette.red, bg = 'NONE' })

-- StatusLine
hl(0, "StatusLine", { fg = palette.context, bg = palette.bg })
hl(0, "StatusLineNC", { fg = palette.line, bg = palette.bg })
hl(0, "StatusLineSeparator", { fg = palette.line, bg = 'NONE' })
hl(0, "StatusLineTerm", { fg = palette.line, bg = 'NONE' })
hl(0, "StatusLineTermNC", { fg = palette.line, bg = 'NONE' })

-- Cmp
hl(0, "CmpItemAbbrDeprecated", { fg = palette.gray, bg = 'NONE', strikethrough = true, })
hl(0, "CmpItemAbbrMatch", { fg = palette.ui3_blue, bg = 'NONE' })
hl(0, "CmpItemAbbrMatchFuzzy", { fg = palette.ui3_blue, bg = 'NONE' })
hl(0, "CmpItemKindFunction", { fg = palette.cyan, bg = 'NONE' })
hl(0, "CmpItemKindMethod", { fg = palette.cyan, bg = 'NONE' })
hl(0, "CmpItemKindConstructor", { fg = palette.yellow, bg = 'NONE' })
hl(0, "CmpItemKindClass", { fg = palette.yellow, bg = 'NONE' })
hl(0, "CmpItemKindEnum", { fg = palette.yellow, bg = 'NONE' })
hl(0, "CmpItemKindEvent", { fg = palette.red, bg = 'NONE' })
hl(0, "CmpItemKindInterface", { fg = palette.yellow, bg = 'NONE' })
hl(0, "CmpItemKindStruct", { fg = palette.yellow, bg = 'NONE' })
hl(0, "CmpItemKindVariable", { fg = palette.red, bg = 'NONE' })
hl(0, "CmpItemKindField", { fg = palette.red, bg = 'NONE' })
hl(0, "CmpItemKindProperty", { fg = palette.red, bg = 'NONE' })
hl(0, "CmpItemKindEnumMember", { fg = palette.orange, bg = 'NONE' })
hl(0, "CmpItemKindConstant", { fg = palette.orange, bg = 'NONE' })
hl(0, "CmpItemKindKeyword", { fg = palette.purple, bg = 'NONE' })
hl(0, "CmpItemKindModule", { fg = palette.yelloworange, bg = 'NONE' })
hl(0, "CmpItemKindValue", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindUnit", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindText", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindSnippet", { fg = palette.purple, bg = 'NONE' })
hl(0, "CmpItemKindFile", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindFolder", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindColor", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindReference", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindOperator", { fg = palette.fg, bg = 'NONE' })
hl(0, "CmpItemKindTypeParameter", { fg = palette.red, bg = 'NONE' })

-- Crates
hl(0, "CratesNvimLoading", { fg = palette.hint, bg = 'NONE' })
hl(0, "CratesNvimVersion", { fg = palette.hint, bg = 'NONE' })

-- Oil
hl(0, "OilDir", { fg = palette.folder_blue, bg = 'NONE' })
hl(0, "OilDirIcon", { fg = palette.folder_blue, bg = 'NONE' })
hl(0, "OilSocket", { fg = palette.cyan, bg = 'NONE' })
hl(0, "OilFile", { fg = palette.light_gray, bg = 'NONE' })
hl(0, "OilLink", { fg = palette.cyan, bg = 'NONE' })
