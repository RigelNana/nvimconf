return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- 图标支持
        "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    init = function()
        if vim.fn.argc(-1) == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree").setup {
                    filesystem = {
                        hijack_netrw_behavior = "open_current",
                    },
                }
            end
        end
    end,

    opts = {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
            diagnostics = {
                symbols = {
                    hint = "󰌵 ", -- 提示符号
                    info = " ", -- 信息符号
                    warn = " ", -- 警告符号
                    error = " ", -- 错误符号
                },
                highlights = {
                    hint = "DiagnosticHint",
                    info = "DiagnosticInfo",
                    warn = "DiagnosticWarn",
                    error = "DiagnosticError",
                },
            },
        },
        window = {
            position = "left", -- Neo-tree 窗口位置
            width = 40, -- 窗口宽度
            mappings = {
                ["<Space>"] = "toggle_node", -- 切换节点
                ["<Cr>"] = "open", -- 打开文件或目录
                ["o"] = "open",
                ["<Esc>"] = "revert_preview", -- 取消预览
                ["P"] = { "toggle_preview", config = { use_float = true } }, -- 浮动预览
                ["l"] = "focus_preview",
                ["s"] = "split_with_window_picker", -- 分屏打开
                ["v"] = "vsplit_with_window_picker", -- 垂直分屏打开
                ["t"] = "open_tabnew", -- 在新标签页中打开
                ["C"] = "close_node", -- 关闭节点
                ["z"] = "close_all_nodes", -- 关闭所有节点
                ["R"] = "refresh", -- 刷新树
                ["a"] = {
                    "add",
                    config = {
                        show_path = "relative",
                    },
                },
                ["A"] = "add_directory", -- 添加目录
                ["d"] = "delete", -- 删除文件或目录
                ["r"] = "rename", -- 重命名文件或目录
                ["c"] = "copy_to_clipboard", -- 复制到剪贴板
                ["x"] = "cut_to_clipboard", -- 剪切到剪贴板
                ["p"] = "paste_from_clipboard", -- 从剪贴板粘贴
                ["<leader>e"] = "close_window", -- 关闭 Neo-tree 窗口
            },
        },
        filesystem = {
            filtered_items = {
                visible = false, -- 默认隐藏过滤的文件
                hide_dotfiles = true, -- 隐藏以 "." 开头的文件
                hide_gitignored = true, -- 隐藏被 Git 忽略的文件
                hide_hidden = false, -- 隐藏隐藏文件（Unix 系统中以 "." 开头的文件）
                hide_by_name = {
                    "node_modules",
                },
                hide_by_pattern = { -- 使用通配符隐藏文件
                    "*.meta",
                    "*.class",
                },
                never_show = { -- 永远不显示的文件
                    ".DS_Store",
                    "thumbs.db",
                },
            },
            follow_current_file = {
                enabled = true, -- 自动跟随当前文件
                leave_dirs_open = false, -- 切换文件时关闭其他目录
            },
            hijack_netrw = true,
            group_empty_dirs = true, -- 将空文件夹分组
            hijack_netrw_behavior = "open_current", -- 替代 netrw 的行为
            use_libuv_file_watcher = true, -- 使用 libuv 文件系统监控
        },
        buffers = {
            follow_current_file = {
                enabled = true, -- 自动跟随当前缓冲区的文件
                leave_dirs_open = false, -- 切换缓冲区时关闭其他目录
            },
            group_empty_dirs = true, -- 将空缓冲区分组
        },
        git_status = {
            window = {
                position = "float", -- Git 状态窗口位置
                mappings = {
                    ["A"] = "git_add_all", -- 添加所有更改
                    ["u"] = "git_unstage_file", -- 取消暂存文件
                    ["a"] = "git_add_file", -- 添加文件到暂存区
                    ["r"] = "git_revert_file", -- 回滚文件修改
                    ["c"] = "git_commit", -- 提交更改
                    ["p"] = "git_push", -- 推送更改
                },
            },
        },
    },
}
