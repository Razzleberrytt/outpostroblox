--!strict

local Services = {
	DataService = require(script.Services.DataService),
	MatchService = require(script.Services.MatchService),
	HeroService = require(script.Services.HeroService),
	WaveService = require(script.Services.WaveService),
	EnemyService = require(script.Services.EnemyService),
	CombatService = require(script.Services.CombatService),
	BuildService = require(script.Services.BuildService),
	RewardService = require(script.Services.RewardService),
}

local serviceOrder = {
	"DataService",
	"MatchService",
	"HeroService",
	"WaveService",
	"EnemyService",
	"CombatService",
	"BuildService",
	"RewardService",
}

print("[Outpost Legends] Server boot starting")

for _, serviceName in ipairs(serviceOrder) do
	print(("[Outpost Legends] Initializing %s"):format(serviceName))
	Services[serviceName].Init()
end

for _, serviceName in ipairs(serviceOrder) do
	print(("[Outpost Legends] Starting %s"):format(serviceName))
	Services[serviceName].Start()
end

print("[Outpost Legends] Server boot complete")
