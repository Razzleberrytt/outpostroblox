--!strict

local WaveConfig = {
	Waves = {
		{ WaveNumber = 1, EnemyGroups = { { EnemyId = "Grunt", Count = 10 } }, IntermissionSeconds = 20 },
		{ WaveNumber = 2, EnemyGroups = { { EnemyId = "Grunt", Count = 14 }, { EnemyId = "Runner", Count = 4 } }, IntermissionSeconds = 20 },
		{ WaveNumber = 3, EnemyGroups = { { EnemyId = "Runner", Count = 10 }, { EnemyId = "Tank", Count = 2 } }, IntermissionSeconds = 25 },
		{ WaveNumber = 4, EnemyGroups = { { EnemyId = "Grunt", Count = 18 }, { EnemyId = "Bomber", Count = 4 } }, IntermissionSeconds = 25 },
		{ WaveNumber = 5, EnemyGroups = { { EnemyId = "Runner", Count = 12 }, { EnemyId = "Tank", Count = 4 }, { EnemyId = "Flyer", Count = 6 } }, IntermissionSeconds = 30 },
	},
	BossWave = {
		WaveNumber = 6,
		BossId = "WastelandBehemoth",
		EnemyGroups = { { EnemyId = "Grunt", Count = 12 }, { EnemyId = "Bomber", Count = 6 } },
		IntermissionSeconds = 45,
	},
}

return table.freeze(WaveConfig)
