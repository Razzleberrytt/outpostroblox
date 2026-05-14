--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local AbilityController = {}

-- Public API:
-- Init() prepares UI references and local-only state.
-- Start() connects client input and presentation events.
-- Collects attack and ability intent without calculating authoritative results.

local reviveRemote: RemoteEvent? = nil

local function getRootPart(player: Player): BasePart?
	local character = player.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function findNearestDownedTeammate(): Player?
	local localPlayer = Players.LocalPlayer
	if localPlayer:GetAttribute("IsDowned") == true then
		return nil
	end

	local localRoot = getRootPart(localPlayer)
	if not localRoot then
		return nil
	end

	local nearestPlayer: Player? = nil
	local nearestDistance = Constants.Survival.ReviveRange
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= localPlayer and player:GetAttribute("IsDowned") == true then
			local root = getRootPart(player)
			if root then
				local distance = (localRoot.Position - root.Position).Magnitude
				if distance <= nearestDistance then
					nearestPlayer = player
					nearestDistance = distance
				end
			end
		end
	end

	return nearestPlayer
end

local function requestRevive()
	local remote = reviveRemote
	if not remote then
		return
	end

	local target = findNearestDownedTeammate()
	if target then
		remote:FireServer(target)
	end
end

function AbilityController.Init()
	print("[AbilityController] Init")
end

function AbilityController.Start()
	print("[AbilityController] Start")
	local remoteFolder = ReplicatedStorage:WaitForChild(Constants.RemoteFolderName)
	reviveRemote = remoteFolder:WaitForChild(RemoteNames.RequestRevive) :: RemoteEvent

	UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
		if gameProcessedEvent then
			return
		end
		if input.KeyCode == Enum.KeyCode.E or input.KeyCode == Enum.KeyCode.ButtonX then
			requestRevive()
		end
	end)
end

return AbilityController
