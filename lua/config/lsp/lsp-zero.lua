---@diagnostic disable: 113
local lsp_zero = require("lsp-zero").preset({})
local utils = require("utils")

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
	vim.keymap.set("n", "<leader>k", "<cmd> lua vim.diagnostic.open_float()<cr>", default_opts)
	vim.keymap.set({ "n", "v" }, "<leader><space>", "<cmd>lua vim.lsp.buf.code_action()<cr>", default_opts)
	-- lsp_zero.buffer_autoformat()

	-- local auto_save_format = vim.api.nvim_create_augroup("auto_save_format", { clear = true })
	-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	-- 	buffer = bufnr,
	-- 	group = auto_save_format,
	-- 	desc = "formats the buffer on save",
	-- 	callback = function()
	-- 		vim.lsp.buf.format()
	-- 	end,
	-- })

	if client.supports_method("textDocument/inlayHint") and vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(true)
	end

	-- if client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
	-- 	pcall(vim.lsp.codelens.refresh)
	-- end
	--
	-- local codelens_cmds = vim.api.nvim_create_augroup("codelens_cmds", { clear = true })
	-- vim.api.nvim_create_autocmd("BufWritePost", {
	-- 	buffer = bufnr,
	-- 	group = codelens_cmds,
	-- 	desc = "refresh codelens",
	-- 	callback = function()
	-- 		if client.supports_method("textDocument/codeLens") and vim.lsp.codelens then
	-- 			pcall(vim.lsp.codelens.refresh)
	-- 		end
	-- 	end,
	-- })
end)

local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()

local has_words_before = function()
	local current_buffer = vim.fn.bufnr("%")
	if vim.api.nvim_get_option_value("buftype", { buf = current_buffer }) == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local copilot_comparators_prioritize
if not utils.is_work_device then
	copilot_comparators_prioritize = ("copilot_cmp.comparators").prioritize
end


cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false
		}),
		["<Tab>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			else
				fallback()
			end
		end),
		["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" })
	}),
	sorting = {
		priority_weight = 2,
		comparators = {
			copilot_comparators_prioritize,

			-- Below is the default comparator list and order for nvim-cmp
			cmp.config.compare.offset,
			-- cmp.config.compare.scopes, --this is commented in nvim-cmp too
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.recently_used,
			cmp.config.compare.locality,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
	preselect = cmp.PreselectMode.None, -- Ensure the first item is preselected
	completion = {
		completeopt = "menu,menuone,noinsert"
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		expandable_indicator = true,
		format = require("lspkind").cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = 50, -- prevent the popup from showing more than provided characters
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
			symbol_map = { Copilot = "" }
		})
	},
	sources = {
		-- Copilot Source
		{ name = "copilot",  group_index = 2 },
		-- Other Sources
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "path",     group_index = 2 },
		{ name = "buffer",   group_index = 2 },
	},
})

-- see :help lsp-zero-guide:integrate-with-mason-nvim
-- to learn how to use mason.nvim with lsp-zero
require("mason").setup()
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
		"gopls",
		"graphql",
		"html",
		"helm_ls",
		"jsonls",
		"ts_ls",
		"taplo",
		"typos_lsp",
		"lua_ls",
		"marksman",
		"pyright",
		"spectral",
		"sqlls",
		"lemminx",
		"vimls",
		"yamlls",
	}
})

local hint_sign = utils.get_hint_char()

-- Add icons for diagnostics
vim.diagnostic.config({
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = hint_sign
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.INFO] = "InfoMsg",
			[vim.diagnostic.severity.HINT] = "HintMsg"
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.INFO] = "InfoMsg",
			[vim.diagnostic.severity.HINT] = "HintMsg"
		}
	}
})
