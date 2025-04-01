local vim = vim

return {
    'kvrohit/substrata.nvim',
    config = function ()
        -- Example config in lua
        -- substrata_italic_comments
        -- substrata_italic_keywords
        -- substrata_italic_booleans
        -- substrata_italic_booleans
        -- substrata_italic_variables
        -- substrata_transparent
        -- substrata_variant
        vim.g.substrata_italic_comments = true
        vim.g.substrata_variant = "default"
        -- Load the colorscheme
--        vim.cmd [[colorscheme substrata]]

    end
}
