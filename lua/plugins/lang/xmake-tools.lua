return {
    "Mythos-404/xmake.nvim",
    version = "^3",
    lazy = true,
    event = "BufReadPost",
    config = true,
    opts = {
        on_save = {
        -- Reload project information
        reload_project_info = true,
        -- Configuration for generating `compile_commands.json`
        lsp_compile_commands = {
                enable = true,
                -- Directory name (relative path) for output file
                output_dir = ".",
            },
        },
    }
}
