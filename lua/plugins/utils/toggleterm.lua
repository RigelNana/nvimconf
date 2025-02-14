return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
		{ "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
		{ "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
	},
	config = function()
		require("toggleterm").setup({
			-- 终端基本配置
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,

			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,

			-- 浮动终端配置
			float_opts = {
				border = "curved",
				winblend = 0,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},

			-- 智能终端处理
			on_open = function(term)
				-- 终端模式下的快捷键
				vim.api.nvim_buf_set_keymap(
					term.bufnr,
					"t",
					"<C-h>",
					[[<C-\><C-n><C-W>h]],
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(
					term.bufnr,
					"t",
					"<C-j>",
					[[<C-\><C-n><C-W>j]],
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(
					term.bufnr,
					"t",
					"<C-k>",
					[[<C-\><C-n><C-W>k]],
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(
					term.bufnr,
					"t",
					"<C-l>",
					[[<C-\><C-n><C-W>l]],
					{ noremap = true, silent = true }
				)
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
			end,
		})

		-- 创建常用终端实例
		local Terminal = require("toggleterm.terminal").Terminal

		-- 创建 lazygit 终端
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "double",
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		-- 创建 htop 终端
		local htop = Terminal:new({
			cmd = "htop",
			direction = "float",
			float_opts = {
				border = "double",
			},
			on_open = function(term)
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
		})

		-- 创建 python 终端
		local python = Terminal:new({
			cmd = "python",
			direction = "horizontal",
			close_on_exit = false,
		})

		-- 添加自定义命令
		vim.api.nvim_create_user_command("LazyGit", function()
			lazygit:toggle()
		end, {})
		vim.api.nvim_create_user_command("Htop", function()
			htop:toggle()
		end, {})
		vim.api.nvim_create_user_command("Python", function()
			python:toggle()
		end, {})

		-- 添加快捷键
		vim.keymap.set("n", "<leader>tg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
		vim.keymap.set("n", "<leader>tp", "<cmd>Python<cr>", { desc = "Python REPL" })
		vim.keymap.set("n", "<leader>tm", "<cmd>Htop<cr>", { desc = "Htop" })
	end,
}

