--!strict

local MatchService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns match lifecycle, player readiness, intermissions, win/loss state, and remotes setup.

function MatchService.Init()
	print("[MatchService] Init")
end

function MatchService.Start()
	print("[MatchService] Start")
end

return MatchService
