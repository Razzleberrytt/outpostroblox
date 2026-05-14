--!strict

local HeroService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns hero selection, hero state, abilities, and server-side cooldown validation.

function HeroService.Init()
	print("[HeroService] Init")
end

function HeroService.Start()
	print("[HeroService] Start")
end

return HeroService
