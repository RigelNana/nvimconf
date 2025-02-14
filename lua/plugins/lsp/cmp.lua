return {

    -- "hrsh7th/nvim-cmp",
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        { "FelipeLema/cmp-async-path", url = "https://codeberg.org/FelipeLema/cmp-async-path" },
        "hrsh7th/cmp-cmdline",
        "dmitmel/cmp-cmdline-history",
        "saadparwaiz1/cmp_luasnip",
        "lukas-reineke/cmp-under-comparator",
        "onsails/lspkind.nvim",
    },
    event = { "CursorHold", "CursorHoldI" },
    config = function()
        local luasnip = require "luasnip"
        local cmp = require "cmp"
        cmp.setup {
            inlay_hints = { enabled = true },
            preselect = cmp.PreselectMode.None,
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            completion = {
                completeopt = vim.o.completeopt,
            },
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert {
                ["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-e>"] = cmp.mapping { i = cmp.mapping.close(), c = cmp.mapping.close() },
                ["<CR>"] = cmp.mapping.confirm { select = true },
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.jump(1)
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),

                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s", "c" }),
            },
            sources = {
                { name = "lazydev" },
                { name = "nvim_lsp" }, -- For nvim-lsp
                { name = "luasnip" }, -- For luasnip user
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                },
                { name = "async_path" },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format { mode = "symbol", maxwidth = 50 }(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    local menu = {
                        luasnip = "[SNP]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[VIM]",
                        buffer = "[BUF]",
                        async_path = "[PTH]",
                        calc = "[CLC]",
                        latex_symbols = "[TEX]",
                        orgmode = "[ORG]",
                    }
                    kind.kind = (strings[1] or "")
                    kind.menu = menu[entry.source.name]
                    return kind
                end,
            },
            sorting = {
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    require("cmp-under-comparator").under,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.kind,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        }
        cmp.setup.cmdline(":", {
            completion = {
                completeopt = "menu,menuone,noselect",
            },
            sources = cmp.config.sources({
                { name = "async_path" },
            }, {
                { name = "cmdline" },
            }, {
                { name = "cmdline_history" },
            }),
        })
    end,
}
