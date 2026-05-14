--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local HUDController = {}

type HUDPayload = {
	CoreHealth: number,
	CoreMaxHealth: number,
	WaveNumber: number,
	TotalWaves: number,
	EnemiesRemaining: number,
	MatchState: string,
	PlayerHealth: number?,
	PlayerMaxHealth: number?,
	IsDowned: boolean?,
	DeathCount: number?,
	ReviveProgress: number?,
	RespawnRemaining: number?,
	DownedTeammates: { string }?,
}

local label: TextLabel? = nil
local lastPayload: HUDPayload = {
	CoreHealth = 0,
	CoreMaxHealth = Constants.CoreMaxHealth,
	WaveNumber = 0,
	TotalWaves = 3,
	EnemiesRemaining = 0,
	MatchState = Constants.MatchStates.Lobby,
	PlayerHealth = Constants.Survival.DefaultMaxHealth,
	PlayerMaxHealth = Constants.Survival.DefaultMaxHealth,
	IsDowned = false,
	DeathCount = 0,
	ReviveProgress = 0,
	RespawnRemaining = 0,
	DownedTeammates = {},
}

local function getRootPart(player: Player): BasePart?
	local character = player.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function findNearbyDownedTeammateName(): string?
	local localPlayer = Players.LocalPlayer
	if localPlayer:GetAttribute("IsDowned") == true then
		return nil
	end

	local localRoot = getRootPart(localPlayer)
	if not localRoot then
		return nil
	end

	local nearestName: string? = nil
	local nearestDistance = Constants.Survival.ReviveRange
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player:GetAttribute("IsDowned") == true then
			local root = getRootPart(player)
			if root then
				local distance = (localRoot.Position - root.Position).Magnitude
				if distance <= nearestDistance then
					nearestDistance = distance
					nearestName = player.Name
				end
			end
		end
	end

	return nearestName
end

local function joinNames(names: { string }?): string
	if not names or #names == 0 then
		return "None"
	end
	return table.concat(names, ", ")
end

local function render()
	if not label then
		return
	end

	local coreHealth = lastPayload.CoreHealth or 0
	local coreMaxHealth = lastPayload.CoreMaxHealth or Constants.CoreMaxHealth
	local waveNumber = lastPayload.WaveNumber or 0
	local totalWaves = lastPayload.TotalWaves or 3
	local enemiesRemaining = lastPayload.EnemiesRemaining or 0
	local matchState = lastPayload.MatchState or Constants.MatchStates.Lobby
	local playerHealth = lastPayload.PlayerHealth or Players.LocalPlayer:GetAttribute("Health") or 0
	local playerMaxHealth = lastPayload.PlayerMaxHealth or Players.LocalPlayer:GetAttribute("MaxHealth") or Constants.Survival.DefaultMaxHealth
	local isDowned = lastPayload.IsDowned == true or Players.LocalPlayer:GetAttribute("IsDowned") == true
	local reviveProgress = math.floor((lastPayload.ReviveProgress or Players.LocalPlayer:GetAttribute("ReviveProgress") or 0) * 100)
	local respawnRemaining = lastPayload.RespawnRemaining or Players.LocalPlayer:GetAttribute("RespawnRemaining") or 0
	local downedTeammates = lastPayload.DownedTeammates or {}
	local nearbyDownedName = findNearbyDownedTeammateName()

	local downedLine = if isDowned then string.format("DOWNED - Revive: %d%% | Respawn: %ds", reviveProgress, respawnRemaining) else "Status: Alive"
	local reviveLine = if nearbyDownedName then string.format("Press E / X to revive %s", nearbyDownedName) else "Revive: no teammate in range"

	label.Text = string.format(
		"Core HP: %d / %d\nPlayer HP: %d / %d\n%s\nWave: %d / %d\nEnemies: %d\nState: %s\nDowned team: %s\n%s",
		coreHealth,
		coreMaxHealth,
		playerHealth,
		playerMaxHealth,
		downedLine,
		waveNumber,
		totalWaves,
		enemiesRemaining,
		matchState,
		joinNames(downedTeammates),
		reviveLine
	)
end

local function createHUD()
	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	local gui = playerGui:FindFirstChild("VerticalSliceHUD") :: ScreenGui?
	if not gui then
		gui = Instance.new("ScreenGui")
		gui.Name = "VerticalSliceHUD"
		gui.ResetOnSpawn = false
		gui.Parent = playerGui
	end

	local textLabel = gui:FindFirstChild("StatusLabel") :: TextLabel?
	if not textLabel then
		textLabel = Instance.new("TextLabel")
		textLabel.Name = "StatusLabel"
		textLabel.AnchorPoint = Vector2.new(0, 0)
		textLabel.Position = UDim2.fromOffset(16, 16)
		textLabel.Size = UDim2.fromOffset(360, 210)
		textLabel.BackgroundTransparency = 0.25
		textLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		textLabel.BorderSizePixel = 0
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextYAlignment = Enum.TextYAlignment.Top
		textLabel.TextScaled = false
		textLabel.TextSize = 18
		textLabel.Font = Enum.Font.GothamBold
		textLabel.Parent = gui
	end

	label = textLabel
	render()
end

function HUDController.Init()
	print("[HUDController] Init")
	createHUD()
end

function HUDController.Start()
	print("[HUDController] Start")
	local remoteFolder = ReplicatedStorage:WaitForChild(Constants.RemoteFolderName)
	local hudRemote = remoteFolder:WaitForChild(RemoteNames.HUDUpdate) :: RemoteEvent
	local stateRemote = remoteFolder:WaitForChild(RemoteNames.MatchStateUpdate) :: RemoteEvent

	hudRemote.OnClientEvent:Connect(function(payload)
		if typeof(payload) ~= "table" then
			return
		end
		lastPayload = payload :: HUDPayload
		render()
	end)

	stateRemote.OnClientEvent:Connect(function(newState)
		if typeof(newState) ~= "string" then
			return
		end
		lastPayload.MatchState = newState
		render()
	end)

	RunService.RenderStepped:Connect(function()
		render()
	end)
end

return HUDController
