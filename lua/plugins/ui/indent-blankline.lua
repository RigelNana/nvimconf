return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
        indent = {
            char = "│",
        },
        scope = {
            enabled = true,
        },
    },
    config = function(_, opts)
        require("ibl").setup(opts)

        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
}
