return {

    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
        require('transparent').setup({
            -- 默认清除背景色的高亮组列表
            -- 你可以根据需要添加或删除组
            groups = {
              'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
              'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
              'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
              'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
              'EndOfBuffer',
              -- 可以尝试添加更多你希望透明的组, 例如:
              -- 'VertSplit', 'WinSeparator', 'Folded', 'Visual', 'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText'
            },
            -- 额外的需要清除背景色的组
            extra_groups = {
              -- 例如: 如果你的状态栏插件 (如 lualine) 使用了特定的高亮组
              -- 'StatusLineTerm', 'StatusLineTermNC'
              -- 如果你使用了 nvim-cmp (补全插件), 可能需要添加:
              "NormalFloat",
              "LspInlayHint",
              "DiagnosticError",
                "DiagnosticWarn",
                "DiagnosticInfo",
                "DiagnosticHint",
                "DiagnosticVirtualTextError",
                "DiagnosticVirtualTextWarn",
                "DiagnosticVirtualTextInfo",
                "DiagnosticVirtualTextHint",


              -- "Pmenu", "PmenuSel", "PmenuThumb"
            },
            -- 你不希望被清除背景色的组
            exclude_groups = {
              -- 例如: 如果你想保留 Visual 模式的背景色
              -- 'Visual'
            },
            -- 可选: 在清除高亮组后执行的函数
            -- on_clear = function()
            --   print("Transparent background applied!")
            -- end,
          })
  end
}
