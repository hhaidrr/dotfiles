local ts_augroup = vim.api.nvim_create_augroup("TS_LSP_OnSave", { clear = true })

local on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = ts_augroup,
        buffer = bufnr,
        callback = function()
            local params = vim.lsp.util.make_range_params()
            params.context = {
                only = { "source.organizeImports", "source.removeUnused.ts" },
                diagnostics = {}
            }

            -- 1. This blocks the save until the LSP responds (timeout of 1s)
            local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, 1000)

            if not result or vim.tbl_isempty(result) then return end

            -- 2. Apply edits directly to the buffer
            for _, res in pairs(result) do
                for _, r in pairs(res.result or {}) do
                    if r.edit then
                        vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
                    elseif r.command then
                        vim.lsp.buf.execute_command(r.command)
                    end
                end
            end

            -- No 'write' or 'print' commands here.
            -- Neovim will now proceed to save the already-modified buffer.
        end,
    })
end

return {
    on_attach = on_attach,
    settings = {
        typescript = {
            preferences = {
                importModuleSpecifierPreference = "non-relative",
                quotePreference = "single",
            },
            format = {
                indentSize = 2,
            },
        },
        javascript = {
            preferences = {
                importModuleSpecifierPreference = "non-relative",
                quotePreference = "single",
            },
            format = {
                indentSize = 2,
            },
        },
    },
}
