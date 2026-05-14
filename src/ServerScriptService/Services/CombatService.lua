--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local CombatService = {}

local lastAttackAt: { [Player]: number } = {}
local attackRemote: RemoteEvent? = nil

local function getRemote(): RemoteEvent
	local folder = ReplicatedStorage:WaitForChild(Constants.RemoteFolderName) :: Folder
	return folder:WaitForChild(RemoteNames.RequestAttack) :: RemoteEvent
end

local function getRootPart(player: Player): BasePart?
	local character = player.Character
	if not character then
		return nil
	end
	return character:FindFirstChild("HumanoidRootPart") :: BasePart?
end

local function getTargetRoot(target: Instance): BasePart?
	if target:IsA("Model") then
		return target.PrimaryPart or target:FindFirstChildWhichIsA("BasePart")
	end
	if target:IsA("BasePart") then
		return target
	end
	return nil
end

local function isValidEnemyTarget(target: Instance): boolean
	local activeFolder = Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName)
	return activeFolder ~= nil and target:IsDescendantOf(activeFolder)
end

function CombatService.Init()
	print("[CombatService] Init")
end

function CombatService.Start()
	print("[CombatService] Start")
	attackRemote = getRemote()
	attackRemote.OnServerEvent:Connect(function(player, requestedTarget)
		if typeof(requestedTarget) ~= "Instance" then
			return
		end

		local now = os.clock()
		if lastAttackAt[player] and now - lastAttackAt[player] < Constants.Combat.BasicAttackCooldown then
			return
		end

		if not isValidEnemyTarget(requestedTarget) then
			return
		end

		local playerRoot = getRootPart(player)
		local targetRoot = getTargetRoot(requestedTarget)
		if not playerRoot or not targetRoot then
			return
		end

		if (playerRoot.Position - targetRoot.Position).Magnitude > Constants.Combat.BasicAttackRange then
			return
		end

		local EnemyService = require(script.Parent.EnemyService)
		if not EnemyService.IsAliveEnemy(requestedTarget) then
			return
		end

		lastAttackAt[player] = now
		EnemyService.DamageEnemy(requestedTarget, Constants.Combat.BasicAttackDamage, player)
	end)

	Players.PlayerRemoving:Connect(function(player)
		lastAttackAt[player] = nil
	end)
end

return CombatService
