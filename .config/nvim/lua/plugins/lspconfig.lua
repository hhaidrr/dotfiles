local vim = vim

-- Infers the full executable path based on shell command name
local read_exec_path = function(exec_name)
    local handle = io.popen("which " .. exec_name)
    local result = handle:read("*a"):gsub("\n", "")
    handle:close()
    return result
end

return {
    'neovim/nvim-lspconfig',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if (client.name == "typescript-tools") then
                    client.server_capabilities.semanticTokensProvider = nil
                end
                local bufopts = { noremap = true, silent = true, buffer = event.buf }
                -- vim.keymap.set("n", "[g", function()
                --     vim.cmd("DiagnosticsErrorJumpPrev")
                -- end, bufopts)
                -- vim.keymap.set("n", "]g", function()
                --     vim.cmd("DiagnosticsErrorJumpNext")
                -- end, bufopts)
                -- vim.keymap.set("n", "[G", function()
                --     vim.cmd("DiagnosticsJumpPrev")
                -- end, bufopts)
                -- vim.keymap.set("n", "]G", function()
                --     vim.cmd("DiagnosticsJumpNext")
                -- end, bufopts)
                vim.keymap.set("n", "<leader>dd", vim.diagnostic.setqflist, bufopts)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
                -- if not require("neoconf").get("lsp.keys.goto_definition.disable") then
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                -- end
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
                -- vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                -- vim.keymap.set("n", "L", vim.lsp.buf.hover, bufopts)
                -- vim.keymap.set("n", "<leader>di", function()
                -- local bufnr = event.buf
                -- local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                -- if enabled then
                --     vim.api.nvim_create_augroup("LSP_inlayHints", { clear = true })
                -- else
                --     require("config.lsp.autocmd").inlay_hints()(bufnr)
                -- end
                -- vim.lsp.inlay_hint.enable(not enabled, { bufnr = bufnr })
                -- require("notify").notify(
                -- string.format(
                -- "Inlay hints %s for buffer %d",
                -- not enabled and "enabled" or "disabled",
                -- bufnr
                -- ),
                -- vim.log.levels.info,
                -- ---@diagnostic disable-next-line: missing-fields
                -- {
                --     title = "LSP inlay hints",
                -- }
                -- )
                -- end, bufopts)
                -- vim.keymap.set("n", "<leader>dI", function()
                -- local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                -- vim.lsp.inlay_hint.enable(not enabled)
                -- require("notify").notify(
                -- string.format("Inlay hints %s globally", not enabled and "enabled" or "disabled"),
                -- vim.log.levels.info,
                -- ---@diagnostic disable-next-line: missing-fields
                -- {
                --     title = "LSP inlay hints",
                -- }
                -- )
                -- end, { noremap = bufopts.noremap, silent = bufopts.silent })
            end,
        })
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        require("mason-lspconfig").setup {
            ensure_installed = {
                "lua_ls",
                "pyright",
                "eslint"
            },
            handlers = {
                function(server_name)
                    -- todo: review whether we want to setup all servers right away, or lazy load by file type
                    -- Does doing it this way have a performance hit to have all of the servers loaded at the same time?
                    -- No I think its fine because the docs mention to statically call .setup on each lang server
                    require("lspconfig")[server_name].setup {
                        on_attatch = on_attatch,
                        capabilities = capabilities
                    }
                end
            }
        }

        -- After setting up mason-lspconfig you may set up servers via lspconfig
        -- require("lspconfig").lua_ls.setup {}
        -- require("lspconfig").rust_analyzer.setup {}
        -- ...
        require("lspconfig").pyright.setup {
            settings = {
                python = {
                    venvPath = "/home/hamzah/code/jetpay/api",
                    venv = ".venv",
                    pythonPath = read_exec_path("python"),
                },
            },
        }
    end
}
