local system = require("utils.system")
local proxy = require("utils.proxy")

if not system.is_work_device() then
	return
end

-- Retrieves proxy settings from environment variables and checks if the proxy is reachable.
--
-- If a reachable proxy is found, it returns a table containing the proxy URL and an `allow_insecure` flag.
-- Otherwise, it returns an empty table.
--
-- @return table: A table with proxy settings (`proxy` and `allow_insecure`) if a reachable proxy is found,
-- otherwise an empty table.
local function get_proxy_settings()
	local proxy_settings = {}
	local proxy_url, proxy_port = proxy.get_from_env()

	if proxy_url and proxy_port and proxy.is_reachable(proxy_url, proxy_port) then
		local proxy_address = string.format("http://%s:%d", proxy_url, proxy_port)
		proxy_settings = {
			allow_insecure = true,
			proxy = proxy_address,
		}
	end

	return proxy_settings
end

-- Enable for debugging proxy settings
-- print("Code Companion: Proxy settings:", vim.inspect(get_proxy_settings()))

require("codecompanion").setup({
	adapters = {
		http = {
			opts = get_proxy_settings(),
		},
	},
	ignore_warnings = true, -- TODO: Remove once this is merged: https://github.com/olimorris/codecompanion.nvim/pull/2439
	display = {
		chat = {
			window = {
				width = 0.35,
				relative = "editor",
				position = "left",
			},
		},
	},
	strategies = {
		chat = {
			name = "copilot",
			model = "gpt-4.1",
		},
		inline = {
			keymaps = {
				accept_change = {
					modes = { n = "ca" },
					description = "Accept the suggested change",
				},
				reject_change = {
					modes = { n = "cr" },
					opts = { nowait = true },
					description = "Reject the suggested change",
				},
				always_accept = {
					modes = { n = "cay" },
				},
			},
		},
	},
})

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>")
vim.keymap.set({ "n", "v" }, "<leader>cf", "<cmd>CodeCompanionActions<cr>")

-- Keybind for inline prompt
vim.keymap.set({ "n", "v" }, "<leader>cx", function()
	local input = vim.fn.input("Inline prompt: ")
	if input ~= "" then
		vim.cmd("CodeCompanion " .. input)
	end
end)
