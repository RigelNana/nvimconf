return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = "LspInfo",
        keys = {
            { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
            { "gr", vim.lsp.buf.references, desc = "Go to references" },
            { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
            { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
            { "gt", vim.lsp.buf.type_definition, desc = "Go to type definition" },
            { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
            { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
            { "<leader>ca", vim.lsp.buf.code_action, desc = "Code actions" },
        },
        opts = {
            servers = {
                vtsls = {},
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                path = vim.split(package.path, ";")
                            },
                            diagnostics = {
                                globals = {"vim"}
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                    vim.fn.stdpath("config")
                                },
                            },
                        },
                    },
                },

                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--header-insertion=iwyu",
                        "--completion-style=detailed",
                        "--function-arg-placeholders",
                        "-j=12",
                        "--pretty",
                    },
                    init_options = {
                        compilationDatabasePath = "build",
                        fallbackFlags = {
                            "-std=c++23",
                            "-xc++",
                            "-Wall",
                            "-Wextra",
                            "-Wpedantic",
                            "-Wshadow",
                            "-Wcast-qual",
                            "-Wformat=2",
                            "-Wno-variadic-macros",
                        },
                    },
                    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "h", "hpp", "cc" },
                    root_dir = function(fname)
                        return require("lspconfig.util").root_pattern(
                            "compile_commands.json",
                            "compile_flags.txt",
                            "configure.ac",
                            ".git"
                        )(fname)
                    end,
                    single_file_support = true,
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                        textDocument = {
                            completion = {
                                completionItem = {
                                    snippetSupport = true,
                                    commitCharactersSupport = true,
                                    deprecatedSupport = true,
                                    preselectSupport = true,
                                    tagSupport = {
                                        valueSet = { 1 }, -- Deprecated
                                    },
                                    insertReplaceSupport = true,
                                    resolveSupport = {
                                        properties = {
                                            "documentation",
                                            "detail",
                                            "additionalTextEdits",
                                        },
                                    },
                                    insertTextModeSupport = {
                                        valueSet = { 1, 2 }, -- 1 = asIs, 2 = adjustIndentation
                                    },
                                    labelDetailsSupport = true,
                                },
                            },
                        },
                    },
                },
                pyright = {},
            },
        },
        config = function(_, opts)
            local lspconfig = require "lspconfig"
            for server, config in pairs(opts.servers) do
                lspconfig[server].setup(config)
            end
            local signs = {
                Error = "",
                Warn = "",
                Hint = "",
                Info = "",
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- 配置诊断显示
            vim.diagnostic.config {
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = true,
                severity_sort = true,
            }
        end,
    },
    {
        "Chaitanyabsprip/fastaction.nvim",
        event = "LspAttach",
        opts = {},
    },
}
