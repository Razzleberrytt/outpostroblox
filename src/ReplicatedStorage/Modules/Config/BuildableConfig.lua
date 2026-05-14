--!strict

local BuildableConfig = {
	Wall = {
		DisplayName = "Wall",
		Cost = 35,
		MaxHealth = 300,
		Description = "Blocks and redirects enemy movement.",
	},
	Turret = {
		DisplayName = "Turret",
		Cost = 90,
		MaxHealth = 160,
		Description = "Server-controlled defensive damage source.",
	},
	SpikeTrap = {
		DisplayName = "Spike Trap",
		Cost = 50,
		MaxHealth = 100,
		Description = "Damages enemies that cross its trigger zone.",
	},
}

return table.freeze(BuildableConfig)
