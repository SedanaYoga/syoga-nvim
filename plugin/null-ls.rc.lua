local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })

local on_attach = function(client, _)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_clear_autocmds({ buffer = 0, group = augroup_format })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup_format,
			buffer = 0,
			callback = function()
				vim.lsp.buf.formatting_seq_sync()
			end,
		})
	end
end

local sources = {
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.prettier,
	null_ls.builtins.diagnostics.eslint.with({
		diagnostics_format = "[eslint] #{m}\n(#{c})",
	}),
}

null_ls.setup({
	on_attach = on_attach,
	sources = sources,
})
