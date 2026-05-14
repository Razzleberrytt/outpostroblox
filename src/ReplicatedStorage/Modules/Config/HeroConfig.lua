--!strict

local HeroConfig = {
	Vanguard = {
		DisplayName = "Vanguard",
		Role = "Frontline defender",
		MaxHealth = 180,
		PrimaryStat = "Defense",
		AbilityIds = { "ShieldBash", "Fortify" },
	},
	Ranger = {
		DisplayName = "Ranger",
		Role = "Long-range damage",
		MaxHealth = 110,
		PrimaryStat = "Precision",
		AbilityIds = { "PiercingShot", "Volley" },
	},
	Engineer = {
		DisplayName = "Engineer",
		Role = "Buildable specialist",
		MaxHealth = 130,
		PrimaryStat = "Construction",
		AbilityIds = { "QuickRepair", "Overclock" },
	},
	Medic = {
		DisplayName = "Medic",
		Role = "Team sustain",
		MaxHealth = 120,
		PrimaryStat = "Support",
		AbilityIds = { "HealBurst", "ReviveBoost" },
	},
}

return table.freeze(HeroConfig)
