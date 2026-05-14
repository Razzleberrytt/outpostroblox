--!strict

local AbilityController = {}

-- Public API:
-- Init() prepares UI references and local-only state.
-- Start() connects client input and presentation events.
-- Collects attack and ability intent without calculating authoritative results.

function AbilityController.Init()
	print("[AbilityController] Init")
end

function AbilityController.Start()
	print("[AbilityController] Start")
end

return AbilityController
