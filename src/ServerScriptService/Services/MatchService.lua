--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local MatchService = {}

type ReviveState = {
	Reviver: Player,
	Token: number,
}

local currentState = Constants.MatchStates.Lobby
local currentWave = 0
local enemiesRemaining = 0
local matchRunning = false
local core: BasePart? = nil
local remotesFolder: Folder? = nil
local hudRemote: RemoteEvent? = nil
local stateRemote: RemoteEvent? = nil
local reviveRemote: RemoteEvent? = nil
local downedTokens: { [Player]: number } = {}
local activeRevives: { [Player]: ReviveState } = {}

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

local function getRootPart(player: Player): BasePart?
	local character = player.Character
	if not character then
		return nil
	end

	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function applyMovementState(player: Player)
	local character = player.Character
	if not character then
		return
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end

	local isDowned = player:GetAttribute("IsDowned") == true
	humanoid.WalkSpeed = if isDowned then Constants.Survival.DownedWalkSpeed else Constants.Survival.NormalWalkSpeed
	humanoid.JumpPower = if isDowned then 0 else 50
end

local function getDownedTeammateNames(forPlayer: Player): { string }
	local names = {}
	for _, teammate in ipairs(Players:GetPlayers()) do
		if teammate ~= forPlayer and teammate:GetAttribute("IsDowned") == true then
			table.insert(names, teammate.Name)
		end
	end
	return names
end

local function buildHUDPayload(player: Player)
	local corePart = core or ensureCore()
	return {
		CoreHealth = corePart:GetAttribute("Health") or 0,
		CoreMaxHealth = corePart:GetAttribute("MaxHealth") or Constants.CoreMaxHealth,
		WaveNumber = currentWave,
		TotalWaves = 3,
		EnemiesRemaining = enemiesRemaining,
		MatchState = currentState,
		PlayerHealth = player:GetAttribute("Health") or 0,
		PlayerMaxHealth = player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth,
		IsDowned = player:GetAttribute("IsDowned") == true,
		DeathCount = player:GetAttribute("DeathCount") or 0,
		ReviveProgress = player:GetAttribute("ReviveProgress") or 0,
		RespawnRemaining = player:GetAttribute("RespawnRemaining") or 0,
		DownedTeammates = getDownedTeammateNames(player),
	}
end

local function fireHUDUpdate(player: Player?)
	local remote = hudRemote
	if not remote then
		return
	end

	if player then
		remote:FireClient(player, buildHUDPayload(player))
		return
	end

	for _, currentPlayer in ipairs(Players:GetPlayers()) do
		remote:FireClient(currentPlayer, buildHUDPayload(currentPlayer))
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

local function ensureSurvivalAttributes(player: Player)
	if player:GetAttribute("MaxHealth") == nil then
		player:SetAttribute("MaxHealth", Constants.Survival.DefaultMaxHealth)
	end
	if player:GetAttribute("Health") == nil then
		player:SetAttribute("Health", player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth)
	end
	if player:GetAttribute("IsDowned") == nil then
		player:SetAttribute("IsDowned", false)
	end
	if player:GetAttribute("DeathCount") == nil then
		player:SetAttribute("DeathCount", 0)
	end
	if player:GetAttribute("ReviveProgress") == nil then
		player:SetAttribute("ReviveProgress", 0)
	end
	if player:GetAttribute("RespawnRemaining") == nil then
		player:SetAttribute("RespawnRemaining", 0)
	end
end

local function cancelRevive(target: Player)
	local state = activeRevives[target]
	if state then
		state.Token += 1
		activeRevives[target] = nil
	end
	target:SetAttribute("ReviveProgress", 0)
end

local function restorePlayer(player: Player, health: number)
	cancelRevive(player)
	downedTokens[player] = (downedTokens[player] or 0) + 1
	player:SetAttribute("Health", math.clamp(health, 1, player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth))
	player:SetAttribute("IsDowned", false)
	player:SetAttribute("ReviveProgress", 0)
	player:SetAttribute("RespawnRemaining", 0)
	applyMovementState(player)
	fireHUDUpdate(nil)
end

local function respawnDownedPlayer(player: Player)
	if player.Parent ~= Players and not Players:FindFirstChild(player.Name) then
		return
	end
	if player:GetAttribute("IsDowned") ~= true then
		return
	end

	cancelRevive(player)
	local newDeathCount = (player:GetAttribute("DeathCount") or 0) + 1
	player:SetAttribute("DeathCount", newDeathCount)
	local delaySeconds = Constants.Survival.RespawnBaseDelay + math.max(0, newDeathCount - 1) * Constants.Survival.RespawnDelayPerDeath
	for remaining = delaySeconds, 1, -1 do
		if player:GetAttribute("IsDowned") ~= true then
			player:SetAttribute("RespawnRemaining", 0)
			return
		end
		player:SetAttribute("RespawnRemaining", remaining)
		fireHUDUpdate(player)
		task.wait(1)
	end

	player:SetAttribute("RespawnRemaining", 0)
	player:LoadCharacter()
	local maxHealth = player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth
	restorePlayer(player, maxHealth)
end

local function enterDownedState(player: Player)
	if player:GetAttribute("IsDowned") == true then
		return
	end

	player:SetAttribute("Health", 0)
	player:SetAttribute("IsDowned", true)
	player:SetAttribute("ReviveProgress", 0)
	player:SetAttribute("RespawnRemaining", 0)
	applyMovementState(player)
	fireHUDUpdate(nil)

	local token = (downedTokens[player] or 0) + 1
	downedTokens[player] = token
	task.spawn(function()
		task.wait(Constants.Survival.DownedTimeout)
		if downedTokens[player] == token and player:GetAttribute("IsDowned") == true then
			respawnDownedPlayer(player)
		end
	end)
end

local function isAlivePlayer(player: Player): boolean
	return player.Parent == Players and player:GetAttribute("IsDowned") ~= true and (player:GetAttribute("Health") or 0) > 0
end

local function canRevive(reviver: Player, target: Player): boolean
	if reviver == target or not isAlivePlayer(reviver) then
		return false
	end
	if target.Parent ~= Players or target:GetAttribute("IsDowned") ~= true then
		return false
	end

	local reviverRoot = getRootPart(reviver)
	local targetRoot = getRootPart(target)
	if not reviverRoot or not targetRoot then
		return false
	end

	return (reviverRoot.Position - targetRoot.Position).Magnitude <= Constants.Survival.ReviveRange
end

local function startRevive(reviver: Player, target: Player)
	if activeRevives[target] then
		return
	end

	local state = { Reviver = reviver, Token = os.clock() }
	activeRevives[target] = state
	target:SetAttribute("ReviveProgress", 0)
	fireHUDUpdate(nil)

	task.spawn(function()
		local startTime = os.clock()
		while activeRevives[target] == state do
			local elapsed = os.clock() - startTime
			local progress = math.clamp(elapsed / Constants.Survival.ReviveDuration, 0, 1)
			target:SetAttribute("ReviveProgress", progress)
			fireHUDUpdate(nil)

			if progress >= 1 then
				local maxHealth = target:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth
				restorePlayer(target, maxHealth * Constants.Survival.ReviveHealthPercent)
				return
			end

			if not canRevive(reviver, target) then
				cancelRevive(target)
				fireHUDUpdate(nil)
				return
			end

			task.wait(0.2)
		end
	end)
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
	reviveRemote = getOrCreateRemote(RemoteNames.RequestRevive)
	getOrCreateRemote(RemoteNames.RequestAttack)
	getOrCreateRemote(RemoteNames.RequestAbility)
	getOrCreateRemote(RemoteNames.RequestBuild)
	ensureCore()
	ensureSpawnPart()
end

function MatchService.Start()
	print("[MatchService] Start")
	Players.PlayerRemoving:Connect(function(player)
		cancelRevive(player)
		downedTokens[player] = nil
		activeRevives[player] = nil
	end)

	Players.PlayerAdded:Connect(function(player)
		player:SetAttribute("Coins", player:GetAttribute("Coins") or 0)
		player:SetAttribute("XP", player:GetAttribute("XP") or 0)
		ensureSurvivalAttributes(player)
		player.CharacterAdded:Connect(function()
			task.defer(function()
				applyMovementState(player)
				fireHUDUpdate(player)
			end)
		end)
		task.defer(function()
			fireHUDUpdate(player)
		end)
	end)

	for _, player in ipairs(Players:GetPlayers()) do
		player:SetAttribute("Coins", player:GetAttribute("Coins") or 0)
		player:SetAttribute("XP", player:GetAttribute("XP") or 0)
		ensureSurvivalAttributes(player)
		player.CharacterAdded:Connect(function()
			task.defer(function()
				applyMovementState(player)
				fireHUDUpdate(player)
			end)
		end)
		applyMovementState(player)
	end

	if reviveRemote then
		reviveRemote.OnServerEvent:Connect(function(reviver, target)
			if typeof(target) ~= "Instance" or not target:IsA("Player") then
				return
			end
			if canRevive(reviver, target) then
				startRevive(reviver, target)
			end
		end)
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
	for _, player in ipairs(Players:GetPlayers()) do
		ensureSurvivalAttributes(player)
		restorePlayer(player, player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth)
	end
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

function MatchService.DamagePlayer(player: Player, amount: number, _source: Instance?): boolean
	ensureSurvivalAttributes(player)
	if currentState == Constants.MatchStates.Defeat or currentState == Constants.MatchStates.Victory then
		return false
	end
	if player:GetAttribute("IsDowned") == true then
		return false
	end

	local health = player:GetAttribute("Health") or player:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth
	local newHealth = math.max(0, health - math.max(0, amount))
	player:SetAttribute("Health", newHealth)
	if newHealth <= 0 then
		enterDownedState(player)
	else
		fireHUDUpdate(player)
	end
	return true
end

function MatchService.IsPlayerAlive(player: Player): boolean
	ensureSurvivalAttributes(player)
	return isAlivePlayer(player)
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
