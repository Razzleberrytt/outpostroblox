--!strict

local UpgradeConfig = {
	Hero = {
		HealthTraining = { DisplayName = "Health Training", MaxLevel = 5, Stat = "MaxHealth", PerLevel = 10 },
		DamageTraining = { DisplayName = "Damage Training", MaxLevel = 5, Stat = "DamageMultiplier", PerLevel = 0.05 },
		AbilityFocus = { DisplayName = "Ability Focus", MaxLevel = 3, Stat = "CooldownReduction", PerLevel = 0.05 },
	},
	Base = {
		ReinforcedCore = { DisplayName = "Reinforced Core", MaxLevel = 5, Stat = "BaseHealth", PerLevel = 100 },
		RepairEfficiency = { DisplayName = "Repair Efficiency", MaxLevel = 3, Stat = "RepairMultiplier", PerLevel = 0.1 },
		BuildBudget = { DisplayName = "Build Budget", MaxLevel = 4, Stat = "StartingScrap", PerLevel = 25 },
	},
}

return table.freeze(UpgradeConfig)
