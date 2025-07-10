local lsp_util = require("lsp/utils")
local root_files = {
	".git"
}

vim.lsp.config("yamlls", {
	name = "yamlls",
	cmd = { "yaml-language-server", "--stdio" },
	root_markers = root_files,
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.helm-values" },
	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = true
		lsp_util.default_on_attach(client, bufnr)
	end,
	settings = {
		redhat = {
			telemetry = {
				enabled = false
			}
		}
	}
})
