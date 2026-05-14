--!strict

local DataService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns player profile loading, saving, and server-side currency/progression state.

function DataService.Init()
	print("[DataService] Init")
end

function DataService.Start()
	print("[DataService] Start")
end

return DataService
