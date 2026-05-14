--!strict

local EnemyConfig = {
	Grunt = {
		DisplayName = "Grunt",
		Health = 30,
		Damage = 25,
		MoveSpeed = 8,
		CoreHitRange = 4,
		RewardCoins = 2,
		Threat = "Baseline melee attacker for the vertical slice",
	},
}

return table.freeze(EnemyConfig)
