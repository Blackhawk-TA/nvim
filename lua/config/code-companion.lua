local utils = require("utils")

if not utils.is_work_device() then
	return
end

-- Checks if a proxy server is reachable at the given host and port.
--
-- Attempts to establish a TCP connection to the specified host and port
-- using LuaSocket.
--
-- @param host string: The hostname or IP address of the proxy server.
-- @param port number: The port number of the proxy server.
-- @return boolean: True if the proxy is reachable, false otherwise.
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

-- Retrieves the HTTP proxy host and port from environment variables.
--
-- @return url (string|nil): The proxy host, or nil if not set.
-- @return port (number|nil): The proxy port, or nil if not set.
local function get_proxy_from_env()
	local proxy_env = os.getenv("HTTP_PROXY") or os.getenv("http_proxy")
	if not proxy_env then
		return nil, nil
	end

	local url = proxy_env:match("^https?://([^:/]+)")
	local port = tonumber(proxy_env:match(":(%d+)$"))
	return url, port
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
	local proxy_url, proxy_port = get_proxy_from_env()

	if proxy_url and proxy_port and is_proxy_reachable(proxy_url, proxy_port) then
		local proxy = string.format("http://%s:%d", proxy_url, proxy_port)
		proxy_settings = {
			allow_insecure = true,
			proxy = proxy,
		}
	end

	return proxy_settings
end

require("codecompanion").setup({
	adapters = {
		http = {
			opts = get_proxy_settings(),
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
