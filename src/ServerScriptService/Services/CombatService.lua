--!strict

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local CombatService = {}

local lastAttackAt: { [Player]: number } = {}
local attackRemote: RemoteEvent? = nil

local function getEnemyRoot(enemy: Instance): BasePart?
	if enemy:IsA("Model") then
		return enemy.PrimaryPart or enemy:FindFirstChildWhichIsA("BasePart")
	end
	if enemy:IsA("BasePart") then
		return enemy
	end
	return nil
end

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
	return getEnemyRoot(target)
end

local function isValidEnemyTarget(target: Instance): boolean
	local activeFolder = Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName)
	return activeFolder ~= nil and target:IsDescendantOf(activeFolder)
end

local function findClosestAlivePlayer(enemyRoot: BasePart): (Player?, number)
	local MatchService = require(script.Parent.MatchService)
	local closestPlayer: Player? = nil
	local closestDistance = math.huge

	for _, player in ipairs(Players:GetPlayers()) do
		if MatchService.IsPlayerAlive(player) then
			local playerRoot = getRootPart(player)
			if playerRoot then
				local distance = (playerRoot.Position - enemyRoot.Position).Magnitude
				if distance < closestDistance then
					closestPlayer = player
					closestDistance = distance
				end
			end
		end
	end

	return closestPlayer, closestDistance
end

local function updateEnemyPlayerThreats(deltaTime: number)
	local activeFolder = Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName)
	if not activeFolder then
		return
	end

	local MatchService = require(script.Parent.MatchService)
	if MatchService.GetState() == Constants.MatchStates.Defeat or MatchService.GetState() == Constants.MatchStates.Victory then
		return
	end

	for _, enemy in ipairs(activeFolder:GetChildren()) do
		local enemyRoot = getEnemyRoot(enemy)
		if not enemyRoot then
			continue
		end

		if enemy:GetAttribute("OriginalCoreHitRange") == nil then
			enemy:SetAttribute("OriginalCoreHitRange", enemy:GetAttribute("CoreHitRange") or 4)
		end

		local targetPlayer, distance = findClosestAlivePlayer(enemyRoot)
		if not targetPlayer or distance > Constants.Survival.EnemyPlayerAggroRange then
			enemy:SetAttribute("Target", Constants.CoreName)
			enemy:SetAttribute("CoreHitRange", enemy:GetAttribute("OriginalCoreHitRange") or 4)
			continue
		end

		enemy:SetAttribute("Target", targetPlayer.Name)
		enemy:SetAttribute("CoreHitRange", 0)
		local playerRoot = getRootPart(targetPlayer)
		if not playerRoot then
			continue
		end

		if distance <= Constants.Survival.EnemyPlayerHitRange then
			local now = os.clock()
			local lastHit = enemy:GetAttribute("LastPlayerHitAt") or 0
			if now - lastHit >= Constants.Survival.EnemyPlayerAttackCooldown then
				enemy:SetAttribute("LastPlayerHitAt", now)
				MatchService.DamagePlayer(targetPlayer, enemy:GetAttribute("Damage") or 0, enemy)
			end
		else
			local toPlayer = playerRoot.Position - enemyRoot.Position
			if toPlayer.Magnitude > 0 then
				local speed = enemy:GetAttribute("MoveSpeed") or 8
				local step = math.min(toPlayer.Magnitude, speed * deltaTime)
				enemyRoot.CFrame = CFrame.lookAt(enemyRoot.Position + toPlayer.Unit * step, playerRoot.Position)
			end
		end
	end
end

function CombatService.Init()
	print("[CombatService] Init")
end

function CombatService.Start()
	print("[CombatService] Start")
	attackRemote = getRemote()
	attackRemote.OnServerEvent:Connect(function(player, requestedTarget)
		local MatchService = require(script.Parent.MatchService)
		if not MatchService.IsPlayerAlive(player) then
			return
		end

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

	RunService.Heartbeat:Connect(updateEnemyPlayerThreats)

	Players.PlayerRemoving:Connect(function(player)
		lastAttackAt[player] = nil
	end)
end

return CombatService
