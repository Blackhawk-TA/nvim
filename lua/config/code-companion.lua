local utils = require("utils")

if not utils.is_work_device() then
	return
end

local function is_proxy_reachable(host, port)
	local ok, socket = pcall(require, "socket")
	if not ok then
		return false
	end

	local tcp = socket.tcp()
	if not tcp then
		return false
	end

	tcp:settimeout(0.5)
	local success = tcp:connect(host, port)
	tcp:close()

	if not success then
		return false
	end
	return true
end

local function get_proxy_from_env()
	local proxy_env = os.getenv("HTTP_PROXY") or os.getenv("http_proxy")
	if not proxy_env then
		return nil, nil
	end
	local url = proxy_env:match("^https?://([^:/]+)")
	local port = tonumber(proxy_env:match(":(%d+)$"))
	return url, port
end

local http_ops = {}
local proxy_url, proxy_port = get_proxy_from_env()
if proxy_url and proxy_port and is_proxy_reachable(proxy_url, proxy_port) then
	local proxy = string.format("http://%s:%d", proxy_url, proxy_port)
	http_ops = {
		allow_insecure = true,
		proxy = proxy,
	}
end

require("codecompanion").setup({
	adapters = {
		http = {
			opts = http_ops,
		},
	},
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
vim.keymap.set("v", "<leader>cx", function()
	local input = vim.fn.input("Inline prompt: ")
	if input ~= "" then
		vim.cmd("CodeCompanion " .. input)
	end
end)
