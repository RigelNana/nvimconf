-- 基础设置
vim.opt.encoding = "utf-8"          -- 文件编码为 UTF-8
vim.opt.fileencoding = "utf-8"      -- 文件保存时使用 UTF-8 编码

-- 光标滚动
vim.opt.scrolloff = 8               -- 光标距离顶部和底部的最小行数
vim.opt.sidescrolloff = 8           -- 水平滚动时光标距离左右的最小列数

-- 行号
vim.opt.number = true               -- 显示行号
vim.opt.relativenumber = true       -- 显示相对行号

-- 光标
vim.opt.cursorline = true           -- 高亮当前行

-- 指示列
vim.opt.signcolumn = "yes"          -- 始终显示左侧的指示列

-- 缩进
vim.opt.tabstop = 4                 -- 一个 Tab 显示为 4 个空格
vim.opt.softtabstop = 4             -- Tab 键行为等同于 4 个空格
vim.opt.shiftwidth = 4              -- 按 >> 或 << 时缩进的空格数
vim.opt.expandtab = true            -- 将 Tab 转换为空格
vim.opt.smartindent = true          -- 启用智能缩进
vim.opt.autoindent = true           -- 复制当前行的缩进到下一行

-- 搜索
vim.opt.ignorecase = true           -- 搜索时忽略大小写
vim.opt.smartcase = true            -- 如果包含大写字符，则搜索区分大小写
vim.opt.hlsearch = false            -- 禁用搜索高亮
vim.opt.incsearch = true            -- 边输入边搜索

-- 命令行高度
vim.opt.cmdheight = 1               -- 命令行高度设置为 1 行

-- 文件自动加载
vim.opt.autoread = true             -- 当文件被外部修改时自动加载

-- 折行
vim.opt.wrap = false                -- 禁用折行

-- 光标移动
vim.opt.whichwrap = "<,>,[,]"       -- 左右光标可跨行移动

-- Buffer 管理
vim.opt.hidden = true               -- 切换 buffer 时允许隐藏未保存的文件

-- 鼠标支持
vim.opt.mouse = "a"                 -- 启用鼠标支持

-- 文件备份
vim.opt.backup = false              -- 禁用备份文件
vim.opt.writebackup = false         -- 禁用写入时的备份
vim.opt.swapfile = false            -- 禁用交换文件

-- 性能优化
vim.opt.updatetime = 300            -- 更快的更新间隔（默认 4000ms）
vim.opt.timeoutlen = 500            -- 映射等待时间（默认 1000ms）

-- 窗口分割
vim.opt.splitbelow = true           -- 新窗口从下方打开
vim.opt.splitright = true           -- 新窗口从右侧打开

-- 自动补全
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- 更好的补全体验
vim.opt.pumheight = 10              -- 补全弹窗最多显示 10 行

-- 样式
vim.opt.termguicolors = true        -- 启用 24 位 RGB 颜色支持
vim.opt.background = "dark"         -- 使用暗色主题

-- 不可见字符
vim.opt.list = false                -- 默认不显示不可见字符
vim.opt.listchars = {               -- 配置不可见字符的显示方式
  space = "·",
  tab = "··",
}

-- 状态栏和 Tab 行
vim.opt.showtabline = 2             -- 始终显示 Tab 行
vim.opt.showmode = false            -- 禁用模式提示（增强状态栏后不需要）

-- 剪切板
vim.opt.clipboard = "unnamedplus"   -- 使用系统剪切板

-- 撤销
vim.opt.undofile = true             -- 启用持久化撤销

-- 扩展功能
vim.opt.wildmenu = true             -- 启用增强的补全菜单
