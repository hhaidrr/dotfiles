local vim = vim

-- Material Ocean
local light_green = "#c3e88d"
local cyan = "#16c5f5"
local blue = "#82aaff"
local red = "#f07178"
local deeper_red = "#ff5370"
local purple = "#c792ea"
local sea_green = "#00ccbb"
local green = "#00cc8f"
local cool_lilac = "#baa5e3"
local mid_red = "#ee5d65"
local orange_yellow = "#ffcc00"
local light_cyan = "#89ddff"
local blue_gray = "#717CB4"
local white_gray = "#c5cae0"
local white = "#eeffff"
local error = "#ff5370"

-- vim.treesitter.query.debug = true

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "c",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "typescript",
                "vim",
                "vimdoc"
            },
            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,


            highlight = {
                enable = true,
                --disable = function(lang, buf)
                --    local max_filesize = 100 * 1024 -- 100 KB
                --    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                --    if ok and stats and stats.size > max_filesize then
                --        return true
                --    end
                --end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        })

        -- todo: deduplicate highlights
        -- Global --------------------------------------------------------------
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1b2529" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "#3a5e62" })

        -- Python --------------------------------------------------------------
        vim.api.nvim_set_hl(0, "SelfReferenceParam", { fg = deeper_red, italic = true })
        vim.api.nvim_set_hl(0, "@selfReferenceParam.python", { link = "SelfReferenceParam" })

        vim.api.nvim_set_hl(0, "CustomKeyword", { fg = purple, italic = true })
        vim.api.nvim_set_hl(0, "@keyword.python", { link = "CustomKeyword" })

        vim.api.nvim_set_hl(0, "CustomOperator", { fg = light_cyan })
        vim.api.nvim_set_hl(0, "@operator.python", { link = "CustomOperator" })

        vim.api.nvim_set_hl(0, "CustomFunction", { fg = blue })
        vim.api.nvim_set_hl(0, "@function.python", { link = "CustomFunction" })

        vim.api.nvim_set_hl(0, "CustomType", { fg = cyan })
        vim.api.nvim_set_hl(0, "@type.python", { link = "CustomType" })

        vim.api.nvim_set_hl(0, "CustomParameter", { fg = green })
        vim.api.nvim_set_hl(0, "@variable.parameter.python", { link = "CustomParameter" })

        vim.api.nvim_set_hl(0, "CustomComment", { fg = blue_gray, italic = true })
        vim.api.nvim_set_hl(0, "@comment.python", { link = "CustomComment" })

        vim.api.nvim_set_hl(0, "CustomIdentifier", { fg = white_gray })
        vim.api.nvim_set_hl(0, "@identifier.python", { link = "CustomIdentifier" })

        vim.api.nvim_set_hl(0, "CustomVariable", { fg = white })
        vim.api.nvim_set_hl(0, "@variable.python", { link = "CustomVariable" })

        vim.api.nvim_set_hl(0, "CustomNumber", { fg = green })
        vim.api.nvim_set_hl(0, "@number.python", { link = "CustomNumber" })

        -- TYPESCRIPT --------------------------------------------------------------
        vim.api.nvim_set_hl(0, "CustomKeyword", { fg = purple, italic = true })
        vim.api.nvim_set_hl(0, "@keyword.typescript", { link = "CustomKeyword" })

        vim.api.nvim_set_hl(0, "SelfReferenceParam", { fg = deeper_red, italic = true })
        vim.api.nvim_set_hl(0, "@selfReferenceParam.typescript", { link = "SelfReferenceParam" })

        vim.api.nvim_set_hl(0, "CustomType", { fg = cyan })
        vim.api.nvim_set_hl(0, "@type.typescript", { link = "CustomType" })

        vim.api.nvim_set_hl(0, "CustomIdentifier", { fg = white_gray })
        vim.api.nvim_set_hl(0, "@identifier.typescript", { link = "CustomIdentifier" })

        vim.api.nvim_set_hl(0, "CustomFunction", { fg = blue })
        vim.api.nvim_set_hl(0, "@function.typescript", { link = "CustomFunction" })

        vim.api.nvim_set_hl(0, "CustomOperator", { fg = light_cyan })
        vim.api.nvim_set_hl(0, "@operator.typescript", { link = "CustomOperator" })

        vim.api.nvim_set_hl(0, "CustomNumber", { fg = green })
        vim.api.nvim_set_hl(0, "@number.typescript", { link = "CustomNumber" })

        vim.api.nvim_set_hl(0, "CustomComment", { fg = blue_gray, italic = true })
        vim.api.nvim_set_hl(0, "@comment.typescript", { link = "CustomComment" })

        vim.api.nvim_set_hl(0, "CustomParameter", { fg = green })
        vim.api.nvim_set_hl(0, "@variable.parameter.typescript", { link = "CustomParameter" })

        -- TYPESCRIPTREACT --------------------------------------------------------------
        vim.api.nvim_set_hl(0, "CustomKeyword", { fg = purple, italic = true })
        vim.api.nvim_set_hl(0, "@keyword.tsx", { link = "CustomKeyword" })

        vim.api.nvim_set_hl(0, "SelfReferenceParam", { fg = deeper_red, italic = true })
        vim.api.nvim_set_hl(0, "@selfReferenceParam.tsx", { link = "SelfReferenceParam" })

        vim.api.nvim_set_hl(0, "CustomType", { fg = cyan })
        vim.api.nvim_set_hl(0, "@type.tsx", { link = "CustomType" })

        vim.api.nvim_set_hl(0, "CustomIdentifier", { fg = white_gray })
        vim.api.nvim_set_hl(0, "@identifier.tsx", { link = "CustomIdentifier" })
        vim.api.nvim_set_hl(0, "@lsp.type.variable.typescriptreact", { link = "CustomIdentifier" })
        vim.api.nvim_set_hl(0, "@lsp.type.property.typescriptreact", { link = "CustomIdentifier" })


        vim.api.nvim_set_hl(0, "CustomVariable", { fg = white })
        vim.api.nvim_set_hl(0, "@variable.name.tsx", { link = "CustomVariable" })

        vim.api.nvim_set_hl(0, "CustomFunction", { fg = blue })
        vim.api.nvim_set_hl(0, "@function.tsx", { link = "CustomFunction" })

        vim.api.nvim_set_hl(0, "CustomOperator", { fg = light_cyan })
        vim.api.nvim_set_hl(0, "@operator.tsx", { link = "CustomOperator" })

        vim.api.nvim_set_hl(0, "CustomNumber", { fg = green })
        vim.api.nvim_set_hl(0, "@number.tsx", { link = "CustomNumber" })

        vim.api.nvim_set_hl(0, "CustomComment", { fg = blue_gray, italic = true })
        vim.api.nvim_set_hl(0, "@comment.tsx", { link = "CustomComment" })

        vim.api.nvim_set_hl(0, "CustomParameter", { fg = green })
        vim.api.nvim_set_hl(0, "@variable.parameter.tsx", { link = "CustomParameter" })
        vim.api.nvim_set_hl(0, "@lsp.type.parameter.typescriptreact", { link = "CustomParameter" })

        vim.api.nvim_set_hl(0, "@tag.delimiter.tsx", { link = "CustomIdentifier" })

        vim.api.nvim_set_hl(0, "CustomBuiltinTag", { fg = orange_yellow })
        vim.api.nvim_set_hl(0, "@tag.builtin.tsx", { link = "CustomBuiltinTag" })

        vim.api.nvim_set_hl(0, "CustomTag", { fg = mid_red })
        vim.api.nvim_set_hl(0, "@tag.tsx", { link = "CustomTag" })


        vim.api.nvim_set_hl(0, "@tag.attribute.tsx", { link = "CustomParameter" })


        -- javascript --------------------------------------------------------------
        vim.api.nvim_set_hl(0, "CustomKeyword", { fg = purple, italic = true })
        vim.api.nvim_set_hl(0, "@keyword.import.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.coroutine.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.function.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.return.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.operator.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.javascript", { link = "CustomKeyword" })
        vim.api.nvim_set_hl(0, "@keyword.type.javascript", { link = "CustomKeyword" })

        vim.api.nvim_set_hl(0, "SelfReferenceParam", { fg = deeper_red, italic = true })
        vim.api.nvim_set_hl(0, "@selfReferenceParam.javascript", { link = "SelfReferenceParam" })

        vim.api.nvim_set_hl(0, "CustomMember", { fg = sea_green })
        vim.api.nvim_set_hl(0, "@variable.member.javascript", { link = "CustomMember" })

        vim.api.nvim_set_hl(0, "CustomIdentifier", { fg = white_gray })
        vim.api.nvim_set_hl(0, "@identifier.javascript", { link = "CustomIdentifier" })

        vim.api.nvim_set_hl(0, "CustomFunction", { fg = blue })
        vim.api.nvim_set_hl(0, "@function.javascript", { link = "CustomFunction" })

        vim.api.nvim_set_hl(0, "CustomType", { fg = cyan })
        vim.api.nvim_set_hl(0, "@type.javascript", { link = "CustomType" })
        vim.api.nvim_set_hl(0, "@type.builtin.javascript", { link = "CustomType" })

        vim.api.nvim_set_hl(0, "CustomOperator", { fg = light_cyan })
        vim.api.nvim_set_hl(0, "@keyword.conditional.ternary.javascript", { link = "CustomOperator" })


        vim.api.nvim_set_hl(0, "CustomComment", { fg = blue_gray, italic = true })
        vim.api.nvim_set_hl(0, "@comment.javascript", { link = "CustomComment" })

        vim.api.nvim_set_hl(0, "CustomParameter", { fg = green })
        vim.api.nvim_set_hl(0, "@variable.parameter.javascript", { link = "CustomParameter" })
    end
}
