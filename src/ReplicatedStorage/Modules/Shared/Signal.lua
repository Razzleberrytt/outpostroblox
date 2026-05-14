--!strict

-- Lightweight placeholder signal for future shared code that needs local events.
-- Prefer Roblox RBXScriptSignal or BindableEvent where engine integration is required.

export type Connection = {
	Disconnect: (self: Connection) -> (),
}

export type Signal<T...> = {
	Connect: (self: Signal<T...>, callback: (T...) -> ()) -> Connection,
	Fire: (self: Signal<T...>, T...) -> (),
	Destroy: (self: Signal<T...>) -> (),
}

local Signal = {}
Signal.__index = Signal

function Signal.new<T...>(): Signal<T...>
	local self = setmetatable({
		_connections = {},
	}, Signal)
	return (self :: any) :: Signal<T...>
end

function Signal:Connect(callback)
	local connection = {
		_connected = true,
		_callback = callback,
	}

	function connection:Disconnect()
		self._connected = false
	end

	table.insert(self._connections, connection)
	return connection
end

function Signal:Fire(...)
	for _, connection in ipairs(self._connections) do
		if connection._connected then
			connection._callback(...)
		end
	end
end

function Signal:Destroy()
	table.clear(self._connections)
end

return Signal
