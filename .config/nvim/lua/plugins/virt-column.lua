return {
    "lukas-reineke/virt-column.nvim",
    config = function ()
        local virt = require("virt-column")
        virt.setup({ char="│", virtcolumn = "120", exclude = {
            filetypes = {
                "netrw"
            }
        }})
    end
}
