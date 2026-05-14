--!strict

local Constants = {
	GameName = "Outpost Legends",
	MaxPlayers = 4,
	StartingBaseHealth = 1000,
	CoreMaxHealth = 300,
	StartingScrap = 100,
	DefaultHeroId = "Vanguard",
	RemoteFolderName = "RemoteEvents",
	ActiveEnemiesFolderName = "ActiveEnemies",
	CoreName = "Core",
	EnemySpawnName = "EnemySpawn",
	MatchStates = {
		Lobby = "Lobby",
		Preparing = "Preparing",
		InWave = "InWave",
		WaveComplete = "WaveComplete",
		Victory = "Victory",
		Defeat = "Defeat",
	},
	Combat = {
		BasicAttackDamage = 10,
		BasicAttackRange = 55,
		BasicAttackCooldown = 0.35,
	},
	Rewards = {
		VictoryCoins = 100,
		VictoryXP = 50,
	},
}

return Constants
