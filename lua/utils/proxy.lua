local proxy = {}

-- Checks if a proxy server is reachable at the given host and port.
--
-- Attempts to establish a TCP connection to the specified host and port
-- using LuaSocket.
--
-- @param host string: The hostname or IP address of the proxy server.
-- @param port number: The port number of the proxy server.
-- @return boolean: True if the proxy is reachable, false otherwise.
function proxy.is_reachable(host, port)
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
function proxy.get_from_env()
	local proxy_env = os.getenv("HTTP_PROXY") or os.getenv("http_proxy")
	if not proxy_env then
		return nil, nil
	end

	local url = proxy_env:match("^https?://([^:/]+)")
	local port = tonumber(proxy_env:match(":(%d+)$"))
	return url, port
end

return proxy
