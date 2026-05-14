--!strict

local HeroSelectController = {}

-- Public API:
-- Init() prepares UI references and local-only state.
-- Start() connects client input and presentation events.
-- Requests hero selection through validated server remotes.

function HeroSelectController.Init()
	print("[HeroSelectController] Init")
end

function HeroSelectController.Start()
	print("[HeroSelectController] Start")
end

return HeroSelectController
