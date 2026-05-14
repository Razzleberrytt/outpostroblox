--!strict

local EnemyConfig = {
	Grunt = {
		DisplayName = "Grunt",
		Health = 60,
		Speed = 10,
		RewardScrap = 5,
		Threat = "Baseline melee attacker",
	},
	Runner = {
		DisplayName = "Runner",
		Health = 35,
		Speed = 18,
		RewardScrap = 6,
		Threat = "Fast pressure unit",
	},
	Tank = {
		DisplayName = "Tank",
		Health = 220,
		Speed = 6,
		RewardScrap = 18,
		Threat = "Slow high-health bruiser",
	},
	Bomber = {
		DisplayName = "Bomber",
		Health = 80,
		Speed = 9,
		RewardScrap = 12,
		Threat = "Explodes near defenses",
	},
	Flyer = {
		DisplayName = "Flyer",
		Health = 50,
		Speed = 14,
		RewardScrap = 10,
		Threat = "Bypasses ground chokepoints",
	},
}

return table.freeze(EnemyConfig)
