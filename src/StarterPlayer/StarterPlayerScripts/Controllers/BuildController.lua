--!strict

local BuildController = {}

-- Public API:
-- Init() prepares UI references and local-only state.
-- Start() connects client input and presentation events.
-- Collects build placement intent and sends requests for server validation.

function BuildController.Init()
	print("[BuildController] Init")
end

function BuildController.Start()
	print("[BuildController] Start")
end

return BuildController
