local vim = vim

local python_path = "C:\\Users\\hamza\\AppData\\Local\\Programs\\Python\\Python312\\python.exe"
local group = vim.api.nvim_create_augroup("on_save", { clear = true })
--vim.api.nvim_create_autocmd("BufWritePost", {
--    pattern = "*.py",
--    callback = function()
--        vim.cmd("!" ..
--        python_path ..
--        " -m black --line-length 120 --target-version py39 % && " ..
--        python_path ..
--        " -m isort --profile pycharm % && " .. python_path .. " -m autoflake --remove-all-unused-imports --in-place %")
--    end,
--    group = group
--})
