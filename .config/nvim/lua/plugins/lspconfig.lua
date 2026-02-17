local servers = {
    "lua_ls",
    "pyright",
    "eslint",
    "ts_ls",
    -- "denols"
    -- enable deno manually from here when needed, need to fix deno attatching on non-deno node projects
}

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
            local config = {}

            if server == "denols" then
                config = {
                    root_markers        = { "deno.json", "deno.jsonc" },
                    single_file_support = false,
                    on_new_config       = function(new_config, new_root_dir)
                        if not new_root_dir then
                            -- If no root is found, disable the client for this buffer/project
                            new_config.enabled = false
                        end
                    end,

                }
            end

            vim.lsp.config(server, config)
            vim.lsp.enable(server)

            if server == "denols" then
                local active_clients = vim.lsp.get_clients({ name = "denols" })
                for _, client in ipairs(active_clients) do
                    client:stop()
                end
            end
        end

        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local opts = { buffer = args.buf }

                -- ONLY set things that Telescope ISN'T handling
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

                -- Keep these as standard LSP calls if you don't use Telescope for them
                vim.keymap.set('n', '<leader>cd', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<leader>cf', function() vim.lsp.buf.format({ async = true }) end, opts)
            end,
        })
    end
}
