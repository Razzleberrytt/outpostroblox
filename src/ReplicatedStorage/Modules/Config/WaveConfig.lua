--!strict

local WaveConfig = {
	Waves = {
		{ WaveNumber = 1, EnemyGroups = { { EnemyId = "Grunt", Count = 5 } }, IntermissionSeconds = 2 },
		{ WaveNumber = 2, EnemyGroups = { { EnemyId = "Grunt", Count = 8 } }, IntermissionSeconds = 2 },
		{ WaveNumber = 3, EnemyGroups = { { EnemyId = "Grunt", Count = 12 } }, IntermissionSeconds = 2 },
	},
	SpawnDelaySeconds = 0.6,
}

return table.freeze(WaveConfig)
