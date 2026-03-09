return {
	on_attach = function(client, bufnr)
		-- Enable format on save
		local augroup = vim.api.nvim_create_augroup("BiomeFormatting", { clear = false })
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				pcall(vim.lsp.buf.code_action, {
					context = { only = { "source.organizeImports.biome" } },
					apply = true,
				})
				vim.lsp.buf.format({
					bufnr = bufnr,
					async = false,
					timeout_ms = 3000,
					position_encoding = "utf-8",
					filter = function(c)
						return c.name == "biome"
					end,
				})
			end,
		})
	end,
	capabilities = {
		general = {
			positionEncodings = { "utf-8" },
		},
	},
	offset_encoding = "utf-8",
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"json",
		"jsonc",
	},
}
