local cmp = require("cmp")
local luasnip = require("luasnip")

local system = require("utils.system")

local has_words_before = function()
	local current_buffer = vim.fn.bufnr("%")
	if vim.api.nvim_get_option_value("buftype", { buf = current_buffer }) == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

local copilot_comparators_prioritize
if not system.is_work_device then
	copilot_comparators_prioritize = ("copilot_cmp.comparators").prioritize
end

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-j>"] = cmp.mapping.select_next_item({ behavior = "select" }),
		["<C-k>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
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
		completeopt = "menu,menuone,noinsert",
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
			symbol_map = { Copilot = "" },
		}),
	},
	sources = {
		-- Copilot Source
		{ name = "copilot", group_index = 2 },
		-- Other Sources
		{ name = "nvim_lsp", group_index = 2 },
		{ name = "path", group_index = 2 },
		{ name = "buffer", group_index = 2 },
		{ name = "luasnip", group_index = 2 },
		{ name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
	},
})
