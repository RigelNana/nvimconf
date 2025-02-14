return {
    "Civitasv/cmake-tools.nvim",
    cmd = { "CMakeGenerate", "CMakeBuild", "CMakeRun", "CMakeClean", "CMakeDebug" },
    config = function()
        local osys = require "cmake-tools.osys"
        require("cmake-tools").setup {
            cmake_command = "cmake", -- this is used to specify cmake command path
            ctest_command = "ctest", -- this is used to specify ctest command path
            cmake_use_preset = true,
            cmake_regenerate_on_save = true, -- auto generate when save CMakeLists.txt
            cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
            cmake_build_options = {}, -- this will be passed when invoke `CMakeBuild`
            cmake_build_directory = function()
                if osys.iswin32 then
                    return "out\\${variant:buildType}"
                end
                return "out/${variant:buildType}"
            end, -- specify the generate directory for cmake
            cmake_soft_link_compile_commands = true, -- automatically make a soft link from compile commands file to project root dir
            cmake_compile_commands_from_lsp = false, -- set compile commands file location using lsp
            cmake_kits_path = nil, -- specify global cmake kits path
            cmake_variants_message = {
                short = { show = true },
                long = { show = true, max_length = 40 },
            },
            cmake_dap_configuration = { -- debug settings for cmake
                name = "cpp",
                type = "codelldb",
                request = "launch",
                stopOnEntry = false,
                runInTerminal = true,
                console = "integratedTerminal",
            },
            cmake_executor = { -- executor to use
                name = "toggleterm", -- Use toggleterm as the executor
                opts = {
                    direction = "horizontal", -- Use a floating terminal
                    close_on_exit = false, -- Keep terminal open after command runs
                    auto_scroll = true, -- Automatically scroll to the bottom
                    singleton = true, -- Use a single terminal instance
                    hide_numbers = true, -- Hide line numbers in the terminal
                },
            },
            cmake_runner = { -- runner to use
                name = "toggleterm", -- Use toggleterm as the runner
                opts = {
                    direction = "horizontal", -- Use a floating terminal for running tasks
                    close_on_exit = false,
                    auto_scroll = true,
                    singleton = true,
                    hide_numbers = true,
                },
            },
            cmake_notifications = {
                runner = { enabled = false },
                executor = { enabled = false },
                spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
                refresh_rate_ms = 100,
            },
            cmake_statusline = {
                enabled = false, -- Completely disable status line updates
            },
        }
    end,
}
