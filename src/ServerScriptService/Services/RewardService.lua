--!strict

local RewardService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns authoritative reward grants for waves, enemies, objectives, and match results.

function RewardService.Init()
	print("[RewardService] Init")
end

function RewardService.Start()
	print("[RewardService] Start")
end

return RewardService
