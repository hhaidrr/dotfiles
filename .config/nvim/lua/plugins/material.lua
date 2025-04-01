local vim = vim

return {
    'marko-cerovac/material.nvim',
    config=function ()
        require('material').setup({
            -- ... other settings
            disable = {
                -- ... other settings
                background = false,
            },
            high_visibility = {
                lighter = false, -- Enable higher contrast text for lighter style
                darker = true -- Enable higher contrast text for darker style
            },
            --custom_highlights = {
                -- LineNr = { bg = '#FF0000' },
                -- CursorLine = { fg = colors.editor.constrast , underline = true },

                -- Dynamically override highlight groups with functions to ensure colors are
                -- updated when changing styles at runtime
               -- TabLine = function(colors, _)
               --     return {
               --         fg = colors.main.gray,
               --         italic = true,
               --     }
               -- end,
               -- TabLineSel = function(_, highlights)
               --     return vim.tbl_extend(
               --     "force",
               --     highlights.main_highlights.editor()["TabLineSel"],
               --     { bold = true }
               --     )
               -- end,

                -- This is a list of possible values
        --        YourHighlightGroup = {
        --            fg = "#SOME_COLOR", -- foreground color
        --            bg = "#SOME_COLOR", -- background color
        --            sp = "#SOME_COLOR", -- special color (for colored underlines, undercurls...)
        --            bold = false, -- make group bold
        --            italic = false, -- make group italic
        --            underline = false, -- make group underlined
        --            undercurl = false, -- make group undercurled
        --            underdot = false, -- make group underdotted
        --            underdash = false, -- make group underslashed
        --            striketrough = false, -- make group striked trough
        --            reverse = false, -- reverse the fg and bg colors
        --            link = "SomeOtherGroup" -- link to some other highlight group
        --        }
        --    },
        })
        vim.g.material_style = "deep ocean"
        vim.cmd 'colorscheme material'
    end
}

