return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 图标支持
    event = "VeryLazy", -- 延迟加载，优化启动性能
    config = function()
        vim.diagnostic.config {
            update_in_insert = true, -- 在插入模式下更新诊断信息
        }
            vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "切换到下一个 buffer" })
            vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "切换到上一个 buffer" })
            vim.keymap.set("n", "<leader>bc", ":bdelete!<CR>", { desc = "关闭当前 buffer" })
                require("bufferline").setup {
            options = {
                mode = "buffers", -- 使用 buffer 模式（可以改为 "tabs" 切换标签页）
                numbers = "ordinal", -- 不显示 buffer 编号，可以改为 "ordinal" 或 "buffer_id"
                close_command = "bdelete! %d", -- 使用 `bdelete!` 关闭 buffer
                right_mouse_command = "bdelete! %d", -- 右键关闭
                indicator = {
                    icon = "▎", -- 当前 buffer 指示符样式
                    style = "icon",
                },
                buffer_close_icon = "󰅗", -- 关闭 buffer 的图标
                modified_icon = "●", -- 已修改 buffer 的标记
                close_icon = "", -- bufferline 的关闭图标
                left_trunc_marker = "", -- 左侧省略号
                right_trunc_marker = "", -- 右侧省略号
                max_name_length = 18, -- buffer 名称最大长度
                max_prefix_length = 15, -- buffer 前缀最大长度
                tab_size = 18, -- 每个 tab 的宽度
                diagnostics = "nvim_lsp", -- 显示 LSP 诊断信息
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    local icon = level:match "error" and " " or " "
                    return " " .. icon .. count
                end,
                offsets = {
                    {
                        filetype = "neo-tree", -- 如果使用了 Neotree，可以改为 "neo-tree"
                        text = "Files", -- 偏移区的标题
                        text_align = "center", -- 标题居中
                        separator = true, -- 是否显示分隔符
                    },
                },
                show_buffer_icons = true, -- 显示 buffer 图标
                show_buffer_close_icons = true, -- 显示关闭图标
                show_close_icon = true, -- 显示 bufferline 的关闭图标
                show_tab_indicators = true, -- 显示 tab 指示符
                persist_buffer_sort = true, -- 保持 buffer 排序
                separator_style = "slant", -- 分隔符样式（可选： "slant", "thick", "thin"）
                enforce_regular_tabs = false, -- 是否强制所有 tabs 的宽度相等
                always_show_bufferline = true, -- 始终显示 bufferline
                hover = {
                    enabled = true, -- 启用悬停行为
                    delay = 200, -- 悬停延迟
                    reveal = { "close" }, -- 悬停时显示关闭按钮
                },
                sort_by = "insert_after_current", -- 按插入顺序排序 buffer
            },
            highlights = require("catppuccin.groups.integrations.bufferline").get(), -- 如果你使用了 catppuccin 的配色
        }
         vim.g.transparent_groups = vim.list_extend(vim.g.transparent_groups or {},
          vim.tbl_map(function(v)
            return v.hl_group
          end, 
          vim.tbl_values(require('bufferline.config').highlights)))
          require('transparent').clear_prefix('BufferLine')
        require('transparent').clear_prefix('plenary')
        require('transparent').clear_prefix('nvim-web-devicons')

    end,
}
