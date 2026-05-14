--!strict

local EnemyService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns enemy spawning, tracking, movement orchestration, and cleanup.

function EnemyService.Init()
	print("[EnemyService] Init")
end

function EnemyService.Start()
	print("[EnemyService] Start")
end

return EnemyService
