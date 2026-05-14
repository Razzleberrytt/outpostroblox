--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local Controllers = {
	HUDController = require(script.Controllers.HUDController),
	HeroSelectController = require(script.Controllers.HeroSelectController),
	BuildController = require(script.Controllers.BuildController),
	AbilityController = require(script.Controllers.AbilityController),
}

local controllerOrder = {
	"HUDController",
	"HeroSelectController",
	"BuildController",
	"AbilityController",
}

local function getCharacterRoot(): BasePart?
	local character = Players.LocalPlayer.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function getEnemyRoot(enemy: Instance): BasePart?
	if enemy:IsA("Model") then
		return enemy.PrimaryPart or enemy:FindFirstChildWhichIsA("BasePart")
	end
	if enemy:IsA("BasePart") then
		return enemy
	end
	return nil
end

local function findNearestEnemy(): Instance?
	local activeEnemies = Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName)
	local characterRoot = getCharacterRoot()
	if not activeEnemies or not characterRoot then
		return nil
	end

	local nearestEnemy: Instance? = nil
	local nearestDistance = math.huge
	for _, enemy in ipairs(activeEnemies:GetChildren()) do
		local root = getEnemyRoot(enemy)
		if root then
			local distance = (characterRoot.Position - root.Position).Magnitude
			if distance < nearestDistance then
				nearestEnemy = enemy
				nearestDistance = distance
			end
		end
	end

	return nearestEnemy
end

local function getMouseTargetEnemy(): Instance?
	local activeEnemies = Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName)
	if not activeEnemies then
		return nil
	end

	local mouse = Players.LocalPlayer:GetMouse()
	local target = mouse.Target
	if target and target:IsDescendantOf(activeEnemies) then
		return target:FindFirstAncestorWhichIsA("Model") or target
	end

	return nil
end

local function connectAttackInput()
	local remoteFolder = ReplicatedStorage:WaitForChild(Constants.RemoteFolderName)
	local attackRemote = remoteFolder:WaitForChild(RemoteNames.RequestAttack) :: RemoteEvent
	local mouse = Players.LocalPlayer:GetMouse()

	local function requestAttack()
		local target = getMouseTargetEnemy() or findNearestEnemy()
		if target then
			attackRemote:FireServer(target)
		end
	end

	mouse.Button1Down:Connect(requestAttack)
	UserInputService.TouchTap:Connect(function(_, gameProcessedEvent)
		if not gameProcessedEvent then
			requestAttack()
		end
	end)
end

print("[Outpost Legends] Client boot starting")

for _, controllerName in ipairs(controllerOrder) do
	Controllers[controllerName].Init()
end

for _, controllerName in ipairs(controllerOrder) do
	Controllers[controllerName].Start()
end

connectAttackInput()

print("[Outpost Legends] Client boot complete")
