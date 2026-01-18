local servers = { "lua_ls", "pyright", "eslint", "ts_ls" }

return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = servers
        })

        vim.lsp.config("*", {
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        for _, server in ipairs(servers) do
            vim.lsp.enable(server)
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local opts = { buffer = args.buf }

                -- ONLY set things that Telescope ISN'T handling
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)

                -- Keep these as standard LSP calls if you don't use Telescope for them
                vim.keymap.set('n', '<leader>cd', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
            end,
        })
    end
}
