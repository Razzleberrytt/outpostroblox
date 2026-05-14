--!strict

-- Central list of RemoteEvent names used by Outpost Legends.
-- Server code is responsible for creating these instances and validating every request.
-- Clients must never be trusted for damage, rewards, inventory, currency, or wave state.

local Remotes = {
	SelectHero = "SelectHero",
	RequestAttack = "RequestAttack",
	RequestAbility = "RequestAbility",
	RequestBuild = "RequestBuild",
	RequestRepair = "RequestRepair",
	RequestRevive = "RequestRevive",
	HUDUpdate = "HUDUpdate",
	MatchStateUpdate = "MatchStateUpdate",
}

return Remotes
