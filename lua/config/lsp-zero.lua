local lsp_zero = require("lsp-zero").preset({})

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	local default_opts = { buffer = bufnr }
	lsp_zero.default_keymaps(default_opts)
	vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", default_opts)
	vim.keymap.set("n", "<leader>d", "<cmd> lua vim.diagnostic.goto_next()<cr>", default_opts)
	vim.keymap.set("n", "<leader>D", "<cmd> lua vim.diagnostic.goto_prev()<cr>", default_opts)
	vim.keymap.set("n", "<leader>r", "<cmd> lua vim.lsp.buf.rename()<cr>", default_opts)
	vim.keymap.set("n", "<leader>cf", "<cmd> lua vim.lsp.buf.format()<cr>", default_opts)
	vim.keymap.set({ "n", "v" }, "<leader><space>", "<cmd>lua vim.lsp.buf.code_action()<cr>", default_opts)
	lsp_zero.buffer_autoformat()

	local auto_save_format = vim.api.nvim_create_augroup("auto_save_format", { clear = true })
	vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
		buffer = bufnr,
		group = auto_save_format,
		desc = "formats the buffer on save",
		callback = function()
			vim.lsp.buf.format()
			vim.cmd("w")
		end,
	})

	-- Enable code lense everywhere by default
	-- pcall(vim.lsp.codelens.refresh)
	--
	-- local codelens_cmds = vim.api.nvim_create_augroup("codelens_cmds", { clear = true })
	-- vim.api.nvim_create_autocmd("BufWritePost", {
	-- 	buffer = bufnr,
	-- 	group = codelens_cmds,
	-- 	desc = "refresh codelens",
	-- 	callback = function()
	-- 		pcall(vim.lsp.codelens.refresh)
	-- 	end,
	-- })
end)

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

cmp.setup({
	sources = {
		name = "spell",
		option = {
			keep_all_entries = false,
			enable_in_context = function()
				return true
			end
		}
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp_action.luasnip_supertab(),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" })
	}),
	preselect = "item",
	completion = {
		completeopt = "menu,menuone,noinsert"
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = require("lspkind").cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
		})
	}
})

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require("mason").setup({})
require("mason-lspconfig").setup({
	handlers = {
		lsp_zero.default_setup,
	},
	ensure_installed = {
		"angularls",
		"bashls",
		"clangd",
		"cmake",
		"cssls",
		"dockerls",
		"docker_compose_language_service",
		"eslint",
		"golangci_lint_ls",
		"gopls",
		"graphql",
		"html",
		"helm_ls",
		"jsonls",
		"tsserver",
		"lua_ls",
		"marksman",
		"spectral",
		"pyright",
		"sqlls",
		"lemminx",
		"vimls",
		"yamlls"
	}
})