return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    config = function ()
        local ibl = require("ibl")
        local hooks = require("ibl.hooks")

        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IblScope", { fg = "#84ffff"})

        end)

        ibl.setup {
            indent = { char = "▏" , highlight = "IblIndent" },
            scope = {highlight = "IblScope", show_start=false, show_end=false }
        }
    end
}


