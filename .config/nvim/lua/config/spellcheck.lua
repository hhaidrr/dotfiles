local vim = vim

 vim.api.nvim_create_augroup("FileTypeConfig", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = "FileTypeConfig",   -- Specify the group name
    pattern = {"*.md", "*.txt"}, -- Add the filetypes here
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en" -- Set the spellcheck language
    end,
})
