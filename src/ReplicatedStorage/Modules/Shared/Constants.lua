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
	Survival = {
		DefaultMaxHealth = 100,
		ReviveRange = 10,
		ReviveDuration = 3,
		DownedTimeout = 20,
		ReviveHealthPercent = 0.5,
		RespawnBaseDelay = 4,
		RespawnDelayPerDeath = 2,
		NormalWalkSpeed = 16,
		DownedWalkSpeed = 6,
		EnemyPlayerAggroRange = 28,
		EnemyPlayerHitRange = 5,
		EnemyPlayerAttackCooldown = 1.25,
	},
	Rewards = {
		VictoryCoins = 100,
		VictoryXP = 50,
	},
}

return Constants
