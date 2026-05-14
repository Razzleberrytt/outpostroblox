--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local HUDController = {}

local label: TextLabel? = nil
local lastPayload = {
	CoreHealth = 0,
	CoreMaxHealth = Constants.CoreMaxHealth,
	WaveNumber = 0,
	TotalWaves = 3,
	EnemiesRemaining = 0,
	MatchState = Constants.MatchStates.Lobby,
}

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

	label.Text = string.format(
		"Core HP: %d / %d\nWave: %d / %d\nEnemies: %d\nState: %s",
		coreHealth,
		coreMaxHealth,
		waveNumber,
		totalWaves,
		enemiesRemaining,
		matchState
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
		textLabel.Size = UDim2.fromOffset(260, 120)
		textLabel.BackgroundTransparency = 0.25
		textLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
		textLabel.BorderSizePixel = 0
		textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		textLabel.TextXAlignment = Enum.TextXAlignment.Left
		textLabel.TextYAlignment = Enum.TextYAlignment.Top
		textLabel.TextScaled = false
		textLabel.TextSize = 20
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
		lastPayload = payload
		render()
	end)

	stateRemote.OnClientEvent:Connect(function(newState)
		if typeof(newState) ~= "string" then
			return
		end
		lastPayload.MatchState = newState
		render()
	end)
end

return HUDController
