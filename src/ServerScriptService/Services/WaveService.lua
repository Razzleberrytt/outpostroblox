--!strict

local WaveService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns server wave progression, spawn pacing, and match wave state.

function WaveService.Init()
	print("[WaveService] Init")
end

function WaveService.Start()
	print("[WaveService] Start")
end

return WaveService
