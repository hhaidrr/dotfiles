return {
    'hrsh7th/nvim-cmp',
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        "hrsh7th/cmp-nvim-lua",
        'hrsh7th/cmp-cmdline',
    },
    config = function()
        local cmp = require("cmp")

        -- global setup
        cmp.setup({
            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
            }, {
                { name = 'buffer' }
            })
        })

        -- '/' command line setup
        cmp.setup.cmdline('/', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }

        })

        -- ':' command line setup
        cmp.setup.cmdline(':', {
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })

        -- Setup lspconfig.
        --        require'lspconfig'.lua_ls.setup {
        --           capabilities = capabilities
        --        }
    end
}
