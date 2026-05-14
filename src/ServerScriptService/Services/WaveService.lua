--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local WaveConfig = require(ReplicatedStorage.Modules.Config.WaveConfig)

local WaveService = {}

local running = false

local function getSpawnCFrame(waveNumber: number, spawnIndex: number): CFrame
	local spawnPart = Workspace:FindFirstChild(Constants.EnemySpawnName)
	local baseCFrame = if spawnPart and spawnPart:IsA("BasePart") then spawnPart.CFrame else CFrame.new(0, 1, -80)
	local offset = Vector3.new(((spawnIndex - 1) % 5 - 2) * 4, 3, math.floor((spawnIndex - 1) / 5) * -4)
	return baseCFrame + offset + Vector3.new(waveNumber * 1.5, 0, 0)
end

function WaveService.Init()
	print("[WaveService] Init")
end

function WaveService.Start()
	print("[WaveService] Start")
end

function WaveService.RunTestWaves()
	if running then
		return
	end

	running = true
	local MatchService = require(script.Parent.MatchService)
	local EnemyService = require(script.Parent.EnemyService)

	for _, wave in ipairs(WaveConfig.Waves) do
		if MatchService.GetState() == Constants.MatchStates.Defeat then
			break
		end

		MatchService.SetWaveStatus(wave.WaveNumber, EnemyService.GetAliveEnemyCount(), Constants.MatchStates.Preparing)
		task.wait(wave.IntermissionSeconds)

		if MatchService.GetState() == Constants.MatchStates.Defeat then
			break
		end

		MatchService.SetWaveStatus(wave.WaveNumber, 0, Constants.MatchStates.InWave)
		local spawnIndex = 0
		for _, group in ipairs(wave.EnemyGroups) do
			for _ = 1, group.Count do
				if MatchService.GetState() == Constants.MatchStates.Defeat then
					break
				end

				spawnIndex += 1
				EnemyService.SpawnEnemy(group.EnemyId, getSpawnCFrame(wave.WaveNumber, spawnIndex))
				MatchService.SetWaveStatus(wave.WaveNumber, EnemyService.GetAliveEnemyCount())
				task.wait(WaveConfig.SpawnDelaySeconds)
			end
		end

		while EnemyService.GetAliveEnemyCount() > 0 and MatchService.GetState() ~= Constants.MatchStates.Defeat do
			MatchService.SetWaveStatus(wave.WaveNumber, EnemyService.GetAliveEnemyCount())
			task.wait(0.25)
		end

		if MatchService.GetState() == Constants.MatchStates.Defeat then
			break
		end

		MatchService.SetWaveStatus(wave.WaveNumber, 0, Constants.MatchStates.WaveComplete)
		task.wait(1)
	end

	if MatchService.GetState() ~= Constants.MatchStates.Defeat then
		MatchService.SetWaveStatus(#WaveConfig.Waves, 0)
		MatchService.EndMatch("Victory")
	end

	running = false
end

return WaveService
