--!strict

local HUDController = {}

-- Public API:
-- Init() prepares UI references and local-only state.
-- Start() connects client input and presentation events.
-- Displays server-sent match, health, resource, and wave state.

function HUDController.Init()
	print("[HUDController] Init")
end

function HUDController.Start()
	print("[HUDController] Start")
end

return HUDController
