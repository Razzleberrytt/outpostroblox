--!strict

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local EnemyConfig = require(ReplicatedStorage.Modules.Config.EnemyConfig)

local EnemyService = {}

local aliveEnemies: { [Model]: boolean } = {}
local activeFolder: Folder? = nil

local function ensureActiveFolder(): Folder
	local folder = activeFolder or Workspace:FindFirstChild(Constants.ActiveEnemiesFolderName) :: Folder?
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = Constants.ActiveEnemiesFolderName
		folder.Parent = Workspace
	end
	activeFolder = folder
	return folder
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

local function removeEnemy(enemy: Model)
	if not aliveEnemies[enemy] then
		return
	end

	aliveEnemies[enemy] = nil
	if enemy.Parent then
		enemy:Destroy()
	end
end

function EnemyService.Init()
	print("[EnemyService] Init")
	ensureActiveFolder()
end

function EnemyService.Start()
	print("[EnemyService] Start")
	RunService.Heartbeat:Connect(function(deltaTime)
		local MatchService = require(script.Parent.MatchService)
		if MatchService.GetState() == Constants.MatchStates.Defeat or MatchService.GetState() == Constants.MatchStates.Victory then
			return
		end

		local core = MatchService.GetCore()
		for enemy in pairs(aliveEnemies) do
			local root = getEnemyRoot(enemy)
			if not root or not enemy.Parent then
				aliveEnemies[enemy] = nil
				continue
			end

			local health = enemy:GetAttribute("Health") or 0
			if health <= 0 then
				removeEnemy(enemy)
				continue
			end

			local toCore = core.Position - root.Position
			local distance = toCore.Magnitude
			local hitRange = enemy:GetAttribute("CoreHitRange") or 4
			if distance <= hitRange then
				MatchService.DamageCore(enemy:GetAttribute("Damage") or 0)
				removeEnemy(enemy)
			else
				local speed = enemy:GetAttribute("MoveSpeed") or 8
				local step = math.min(distance, speed * deltaTime)
				root.CFrame = CFrame.lookAt(root.Position + toCore.Unit * step, core.Position)
			end
		end
	end)
end

function EnemyService.SpawnEnemy(enemyType: string, spawnCFrame: CFrame): Model?
	local config = EnemyConfig[enemyType]
	if not config then
		warn(("[EnemyService] Unknown enemy type %s"):format(enemyType))
		return nil
	end

	local enemy = Instance.new("Model")
	enemy.Name = enemyType
	enemy:SetAttribute("EnemyType", enemyType)
	enemy:SetAttribute("Health", config.Health)
	enemy:SetAttribute("MaxHealth", config.Health)
	enemy:SetAttribute("Damage", config.Damage)
	enemy:SetAttribute("MoveSpeed", config.MoveSpeed)
	enemy:SetAttribute("CoreHitRange", config.CoreHitRange)

	local body = Instance.new("Part")
	body.Name = "Body"
	body.Size = Vector3.new(4, 5, 4)
	body.Anchored = true
	body.CanCollide = false
	body.BrickColor = BrickColor.new("Bright red")
	body.Material = Enum.Material.SmoothPlastic
	body.CFrame = spawnCFrame
	body.Parent = enemy
	enemy.PrimaryPart = body
	enemy.Parent = ensureActiveFolder()
	enemy:SetAttribute("Target", Constants.CoreName)

	aliveEnemies[enemy] = true
	enemy.Destroying:Connect(function()
		aliveEnemies[enemy] = nil
	end)

	return enemy
end

function EnemyService.DamageEnemy(enemy: Instance, amount: number, player: Player?)
	local model = if enemy:IsA("Model") then enemy else enemy:FindFirstAncestorWhichIsA("Model")
	if not model or not aliveEnemies[model] then
		return false
	end

	local health = model:GetAttribute("Health") or 0
	local newHealth = math.max(0, health - math.max(0, amount))
	model:SetAttribute("Health", newHealth)
	if newHealth <= 0 then
		removeEnemy(model)
	end

	return true
end

function EnemyService.GetAliveEnemyCount(): number
	local count = 0
	for enemy in pairs(aliveEnemies) do
		if enemy.Parent then
			count += 1
		else
			aliveEnemies[enemy] = nil
		end
	end
	return count
end

function EnemyService.IsAliveEnemy(enemy: Instance): boolean
	local model = if enemy:IsA("Model") then enemy else enemy:FindFirstAncestorWhichIsA("Model")
	return model ~= nil and aliveEnemies[model] == true
end

return EnemyService
