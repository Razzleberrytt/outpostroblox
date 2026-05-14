--!strict

local BuildService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns validated build placement, repair requests, and buildable lifecycle.

function BuildService.Init()
	print("[BuildService] Init")
end

function BuildService.Start()
	print("[BuildService] Start")
end

return BuildService
