return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
		"LinArcX/telescope-changes.nvim",
		"nvim-telescope/telescope-github.nvim",
	},
	cmd = "Telescope",
	keys = {
		-- 文件相关
		{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
		{ "<leader>pr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
		{ "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },

		-- 搜索相关
		{ "<leader>pg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>ps", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in Buffer" },
		{ "<leader>pw", "<cmd>Telescope grep_string<cr>", desc = "Search Word" },

		-- Git 相关
		{ "<leader>pc", "<cmd>Telescope git_commits<cr>", desc = "Git Commits" },
		{ "<leader>pz", "<cmd>Telescope git_branches<cr>", desc = "Git Branches" },
		{ "<leader>pt", "<cmd>Telescope git_status<cr>", desc = "Git Status" },

		-- LSP 相关
		{ "<leader>gl", "<cmd>Telescope lsp_references<cr>", desc = "References" },
		{ "<leader>gi", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>gy", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },

		-- 其他
		{ "<leader>ch", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>pm", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = " ",
				selection_caret = " ",
				path_display = { "truncate" },
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				mappings = {
					i = {
						["<C-n>"] = actions.cycle_history_next,
						["<C-p>"] = actions.cycle_history_prev,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-c>"] = actions.close,
						["<CR>"] = actions.select_default,
						["<C-s>"] = actions.select_horizontal,
						["<C-v>"] = actions.select_vertical,
						["<C-t>"] = actions.select_tab,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
					},
					n = {
						["<esc>"] = actions.close,
						["q"] = actions.close,
						["<CR>"] = actions.select_default,
						["s"] = actions.select_horizontal,
						["v"] = actions.select_vertical,
						["t"] = actions.select_tab,
						["<Tab>"] = actions.toggle_selection + actions.move_selection_next,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_previous,
						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.preview_scrolling_down,
					},
				},
			},
			pickers = {
				find_files = {
					hidden = true,
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		-- 加载扩展
		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		telescope.load_extension("changes")
		telescope.load_extension("gh")
	end,
}

