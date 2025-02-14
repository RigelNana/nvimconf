return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local dap_virtual_text = require("nvim-dap-virtual-text")

        vim.o.switchbuf = 'useopen,uselast'

		-- 虚拟文本设置
		dap_virtual_text.setup({
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = true,
			show_stop_reason = true,
			commented = false,
			virt_text_pos = "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		})

		-- DAP UI 设置
		dapui.setup({
			icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
			mappings = {
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				edit = "e",
				repl = "r",
				toggle = "t",
			},
			layouts = {
				{
					elements = {
						{ id = "scopes", size = 0.25 },
						{ id = "breakpoints", size = 0.25 },
						{ id = "stacks", size = 0.25 },
						{ id = "watches", size = 0.25 },
					},
					size = 40,
					position = "left",
				},
				{
					elements = {
						{ id = "repl", size = 0.5 },
						{ id = "console", size = 0.5 },
					},
					size = 10,
					position = "bottom",
				},
			},
			floating = {
				max_height = nil,
				max_width = nil,
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			windows = { indent = 1 },
			render = {
				max_type_length = nil,
				max_value_lines = 100,
			},
		})

		-- C++ 调试器配置
		dap.adapters.codelldb = {
			type = "server",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
				args = { "--port", "${port}" },
			},
		}

		dap.adapters.cppdbg = {
			id = "cppdbg",
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
		}

		-- C++ 启动配置
		dap.configurations.cpp = {
			{
				name = "Launch file (codelldb)",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = function()
					local args_string = vim.fn.input("Arguments: ")
					return vim.split(args_string, " +")
				end,
				runInTerminal = false,
			},
			{
				name = "Attach to gdbserver (codelldb)",
				type = "codelldb",
				request = "attach",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Launch file (cppdbg)",
				type = "cppdbg",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopAtEntry = true,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
			{
				name = "Attach to gdbserver (cppdbg)",
				type = "cppdbg",
				request = "launch",
				MIMode = "gdb",
				miDebuggerServerAddress = "localhost:1234",
				miDebuggerPath = "/usr/bin/gdb",
				cwd = "${workspaceFolder}",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				setupCommands = {
					{
						text = "-enable-pretty-printing",
						description = "enable pretty printing",
						ignoreFailures = false,
					},
				},
			},
		}

		-- 为 C 语言添加相同的配置
		dap.configurations.c = dap.configurations.cpp

		-- 自动打开/关闭 DAP UI
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- 编译并调试的函数
		local function build_and_debug()
			-- 获取文件信息
			local current_file = vim.fn.expand("%:p")
			local output_file = vim.fn.expand("%:p:r")
			local file_type = vim.fn.expand("%:e")

			-- 根据文件类型选择编译器
			local compiler = file_type == "cpp" and "g++" or "gcc"

			-- 编译命令
			local compile_command = string.format("%s -g %s -o %s -std=c++20", compiler, current_file, output_file)

			-- 执行编译
			local compile_result = vim.fn.system(compile_command)

			-- 检查编译结果
			if vim.v.shell_error == 0 then
				-- 设置调试配置
				local config = {
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = output_file,
					cwd = vim.fn.getcwd(),
					stopOnEntry = false,
				}
				-- 启动调试
				dap.run(config)
			else
				-- 显示编译错误
				vim.notify("Compilation failed:\n" .. compile_result, vim.log.levels.ERROR)
			end
		end

		-- 键位映射
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
		end

		-- 调试控制
		map("n", "<F5>", dap.continue, "Debug: Continue")
		map("n", "<F10>", dap.step_over, "Debug: Step Over")
		map("n", "<F11>", dap.step_into, "Debug: Step Into")
		map("n", "<F12>", dap.step_out, "Debug: Step Out")

		-- 断点操作
		map("n", "<leader>db", dap.toggle_breakpoint, "Debug: Toggle Breakpoint")
		map("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Debug: Conditional Breakpoint")

		-- UI 控制
		map("n", "<leader>du", dapui.toggle, "Debug: Toggle UI")
		map("n", "<leader>de", function()
			dapui.eval(vim.fn.input("Expression: "))
		end, "Debug: Evaluate")

		-- 编译和调试
		map("n", "<leader>dc", build_and_debug, "Debug: Build and Debug")

		-- REPL
		map("n", "<leader>dr", dap.repl.open, "Debug: Open REPL")

		-- 结束调试
		map("n", "<leader>dx", dap.terminate, "Debug: Terminate")

		-- 自定义标志
		vim.fn.sign_define("DapBreakpoint", {
			text = "🛑",
			texthl = "DapBreakpoint",
			linehl = "DapBreakpointLine",
			numhl = "DapBreakpointNum",
		})
		vim.fn.sign_define("DapBreakpointCondition", {
			text = "🔍",
			texthl = "DapBreakpointCondition",
			linehl = "DapBreakpointConditionLine",
			numhl = "DapBreakpointConditionNum",
		})
		vim.fn.sign_define("DapStopped", {
			text = "⭐",
			texthl = "DapStopped",
			linehl = "DapStoppedLine",
			numhl = "DapStoppedNum",
		})

		-- 高亮设置
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#993939", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "#31353f" })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bg = "#31353f" })

		-- 自定义命令
		vim.api.nvim_create_user_command("CppDebug", build_and_debug, {})
	end,
	keys = {
		{ "<F5>", desc = "Debug: Continue" },
		{ "<F10>", desc = "Debug: Step Over" },
		{ "<F11>", desc = "Debug: Step Into" },
		{ "<F12>", desc = "Debug: Step Out" },
		{ "<leader>db", desc = "Debug: Toggle Breakpoint" },
		{ "<leader>dB", desc = "Debug: Conditional Breakpoint" },
		{ "<leader>dc", desc = "Debug: Build and Debug" },
		{ "<leader>du", desc = "Debug: Toggle UI" },
		{ "<leader>de", desc = "Debug: Evaluate" },
		{ "<leader>dr", desc = "Debug: Open REPL" },
		{ "<leader>dx", desc = "Debug: Terminate" },
	},
}

