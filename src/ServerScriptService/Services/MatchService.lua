--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local MatchService = {}

local currentState = Constants.MatchStates.Lobby
local currentWave = 0
local enemiesRemaining = 0
local matchRunning = false
local core: BasePart? = nil
local remotesFolder: Folder? = nil
local hudRemote: RemoteEvent? = nil
local stateRemote: RemoteEvent? = nil

local function getOrCreateRemote(name: string): RemoteEvent
	local folder = remotesFolder
	if not folder then
		folder = ReplicatedStorage:FindFirstChild(Constants.RemoteFolderName) :: Folder?
		if not folder then
			folder = Instance.new("Folder")
			folder.Name = Constants.RemoteFolderName
			folder.Parent = ReplicatedStorage
		end
		remotesFolder = folder
	end

	local remote = folder:FindFirstChild(name) :: RemoteEvent?
	if not remote then
		remote = Instance.new("RemoteEvent")
		remote.Name = name
		remote.Parent = folder
	end

	return remote
end

local function ensureCore(): BasePart
	local existing = Workspace:FindFirstChild(Constants.CoreName)
	local corePart: BasePart

	if existing and existing:IsA("BasePart") then
		corePart = existing
	elseif existing and existing:IsA("Model") then
		local primary = existing.PrimaryPart or existing:FindFirstChildWhichIsA("BasePart")
		if primary then
			corePart = primary
		else
			corePart = Instance.new("Part")
			corePart.Name = Constants.CoreName
			corePart.Parent = Workspace
		end
	else
		corePart = Instance.new("Part")
		corePart.Name = Constants.CoreName
		corePart.Size = Vector3.new(10, 12, 10)
		corePart.Position = Vector3.new(0, 6, 0)
		corePart.Anchored = true
		corePart.BrickColor = BrickColor.new("Bright blue")
		corePart.Material = Enum.Material.Neon
		corePart.Parent = Workspace
	end

	corePart:SetAttribute("MaxHealth", Constants.CoreMaxHealth)
	corePart:SetAttribute("Health", Constants.CoreMaxHealth)
	core = corePart
	return corePart
end

local function ensureSpawnPart()
	if Workspace:FindFirstChild(Constants.EnemySpawnName) then
		return
	end

	local spawnPart = Instance.new("Part")
	spawnPart.Name = Constants.EnemySpawnName
	spawnPart.Size = Vector3.new(8, 1, 8)
	spawnPart.Position = Vector3.new(0, 0.5, -80)
	spawnPart.Anchored = true
	spawnPart.Transparency = 0.4
	spawnPart.BrickColor = BrickColor.new("Really red")
	spawnPart.Parent = Workspace
end

local function fireHUDUpdate(player: Player?)
	local remote = hudRemote
	if not remote then
		return
	end

	local corePart = core or ensureCore()
	local payload = {
		CoreHealth = corePart:GetAttribute("Health") or 0,
		CoreMaxHealth = corePart:GetAttribute("MaxHealth") or Constants.CoreMaxHealth,
		WaveNumber = currentWave,
		TotalWaves = 3,
		EnemiesRemaining = enemiesRemaining,
		MatchState = currentState,
	}

	if player then
		remote:FireClient(player, payload)
	else
		remote:FireAllClients(payload)
	end
end

local function setState(newState: string)
	currentState = newState
	if stateRemote then
		stateRemote:FireAllClients(newState)
	end
	if hudRemote then
		fireHUDUpdate(nil)
	end
end

function MatchService.Init()
	print("[MatchService] Init")
	remotesFolder = ReplicatedStorage:FindFirstChild(Constants.RemoteFolderName) :: Folder?
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = Constants.RemoteFolderName
		remotesFolder.Parent = ReplicatedStorage
	end

	hudRemote = getOrCreateRemote(RemoteNames.HUDUpdate)
	stateRemote = getOrCreateRemote(RemoteNames.MatchStateUpdate)
	getOrCreateRemote(RemoteNames.RequestAttack)
	ensureCore()
	ensureSpawnPart()
end

function MatchService.Start()
	print("[MatchService] Start")
	Players.PlayerAdded:Connect(function(player)
		player:SetAttribute("Coins", player:GetAttribute("Coins") or 0)
		player:SetAttribute("XP", player:GetAttribute("XP") or 0)
		task.defer(function()
			fireHUDUpdate(player)
		end)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		player:SetAttribute("Coins", player:GetAttribute("Coins") or 0)
		player:SetAttribute("XP", player:GetAttribute("XP") or 0)
	end

	task.delay(2, function()
		if currentState == Constants.MatchStates.Lobby then
			MatchService.StartTestMatch()
		end
	end)
end

function MatchService.StartTestMatch()
	if matchRunning then
		return
	end

	matchRunning = true
	currentWave = 0
	enemiesRemaining = 0
	ensureCore():SetAttribute("Health", Constants.CoreMaxHealth)
	setState(Constants.MatchStates.Preparing)

	task.spawn(function()
		task.wait(1)
		local WaveService = require(script.Parent.WaveService)
		WaveService.RunTestWaves()
	end)
end

function MatchService.DamageCore(amount: number)
	if currentState == Constants.MatchStates.Defeat or currentState == Constants.MatchStates.Victory then
		return
	end

	local corePart = core or ensureCore()
	local health = corePart:GetAttribute("Health") or Constants.CoreMaxHealth
	local newHealth = math.max(0, health - math.max(0, amount))
	corePart:SetAttribute("Health", newHealth)
	fireHUDUpdate(nil)

	if newHealth <= 0 then
		MatchService.EndMatch("Defeat")
	end
end

function MatchService.GetCoreHealth(): (number, number)
	local corePart = core or ensureCore()
	return corePart:GetAttribute("Health") or 0, corePart:GetAttribute("MaxHealth") or Constants.CoreMaxHealth
end

function MatchService.GetCore(): BasePart
	return core or ensureCore()
end

function MatchService.GetState(): string
	return currentState
end

function MatchService.SetWaveStatus(waveNumber: number, remaining: number, state: string?)
	currentWave = waveNumber
	enemiesRemaining = remaining
	if state then
		setState(state)
	else
		fireHUDUpdate(nil)
	end
end

function MatchService.EndMatch(result: string)
	if currentState == Constants.MatchStates.Victory or currentState == Constants.MatchStates.Defeat then
		return
	end

	matchRunning = false
	local normalizedResult = if result == "Victory" then Constants.MatchStates.Victory else Constants.MatchStates.Defeat
	setState(normalizedResult)

	if normalizedResult == Constants.MatchStates.Victory then
		local RewardService = require(script.Parent.RewardService)
		RewardService.GrantVictoryRewards()
	end
end

return MatchService
