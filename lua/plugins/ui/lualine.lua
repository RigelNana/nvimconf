return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {

            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = true,
            refresh = {
                statusline = 100,
                tabline = 100,
                winbar = 100,
            },
        },
        sections = {
            lualine_a = {
                {
                    function()
                        if vim.bo.modified then
                            return " "
                        else
                            return " 󰄳"
                        end
                    end,
                    separator = { left = "", right = "" },
                    padding = { left = 0, right = 0 },
                },
                {
                    function()
                        local mode_map = {
                            n = "󰊠 NORMAL",
                            i = "󰞇 INSERT",
                            v = "󰈈 VISUAL",
                            V = "󰈈 V-LINE",
                            [""] = "󰈈 V-BLOCK",
                            c = "󰘳 COMMAND",
                            s = "󰞇 SELECT",
                            S = "󰞇 S-LINE",
                            R = "󰒰 REPLACE",
                            t = "󰈚 TERMINAL",
                        }
                        return mode_map[vim.fn.mode()] or "󰊠 UNKNOWN"
                    end,
                    separator = { left = "", right = "" }, -- 包裹模式的分隔符
                    padding = { left = 1, right = 1 },
                },
            },
            lualine_b = {
                "branch",
                "diff",
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                },
            },
            lualine_c = {
                { "filename" },
                function()
                    if vim.bo.readonly then
                        return " "
                    else
                        return ""
                    end
                end,
            },
            lualine_x = {
                { "encoding", fmt = string.upper },
                {
                    "fileformat",
                    symbols = {
                        unix = "",
                        dos = "",
                        mac = "",
                    },
                },
                {
                    function()
                        local clients = vim.lsp.get_active_clients { bufnr = 0 }
                        if #clients == 0 then
                            return "No LSP"
                        end
                        local names = {}
                        for _, client in ipairs(clients) do
                            table.insert(names, client.name)
                        end
                        return " [" .. table.concat(names, ", ") .. "]"
                    end,
                },
                "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {
            "neo-tree",
            "lazy",
            "mason",
            "toggleterm",
            "nvim-dap-ui",
        },
    },
}
