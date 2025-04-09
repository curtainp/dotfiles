local servers = require("modules.lsp.servers")

vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
local i = "●"
vim.diagnostic.config({
	signs = {
		text = { i, i, i, i },
	},
})

local on_attach = function(client, _)
	vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
	client.server_capabilities.semanticTokensProvider = nil
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

for server, conf in pairs(servers) do
	require("lspconfig")[server].setup(vim.tbl_deep_extend("force", {
		on_attach = on_attach,
		capabilities = capabilities,
	}, conf))
end

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
	local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
	local bufnr = vim.api.nvim_get_current_buf()
	vim.diagnostic.reset(ns, bufnr)
	return true
end
