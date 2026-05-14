--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)

local RewardService = {}

local victoryGranted = false

local function ensureRewardAttributes(player: Player)
	if player:GetAttribute("Coins") == nil then
		player:SetAttribute("Coins", 0)
	end
	if player:GetAttribute("XP") == nil then
		player:SetAttribute("XP", 0)
	end
end

function RewardService.Init()
	print("[RewardService] Init")
end

function RewardService.Start()
	print("[RewardService] Start")
	Players.PlayerAdded:Connect(ensureRewardAttributes)
	for _, player in ipairs(Players:GetPlayers()) do
		ensureRewardAttributes(player)
	end
end

function RewardService.GrantVictoryRewards()
	if victoryGranted then
		return
	end
	victoryGranted = true

	for _, player in ipairs(Players:GetPlayers()) do
		ensureRewardAttributes(player)
		player:SetAttribute("Coins", (player:GetAttribute("Coins") or 0) + Constants.Rewards.VictoryCoins)
		player:SetAttribute("XP", (player:GetAttribute("XP") or 0) + Constants.Rewards.VictoryXP)
	end
end

return RewardService
