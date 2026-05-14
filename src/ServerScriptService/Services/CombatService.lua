--!strict

local CombatService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns authoritative damage, healing, threat checks, and combat validation.

function CombatService.Init()
	print("[CombatService] Init")
end

function CombatService.Start()
	print("[CombatService] Start")
end

return CombatService
