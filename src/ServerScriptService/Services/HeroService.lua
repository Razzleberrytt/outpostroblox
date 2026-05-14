--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Constants = require(ReplicatedStorage.Modules.Shared.Constants)
local RemoteNames = require(ReplicatedStorage.Remotes)

local HeroService = {}

-- Public API:
-- Init() prepares dependencies and internal state. It must not start gameplay loops.
-- Start() connects listeners or begins service work after every service has initialized.
-- Owns hero selection, hero state, abilities, and server-side cooldown validation.

local function getRemote(name: string): RemoteEvent
	local folder = ReplicatedStorage:WaitForChild(Constants.RemoteFolderName) :: Folder
	return folder:WaitForChild(name) :: RemoteEvent
end

local function ensureHeroAttributes(player: Player)
	if player:GetAttribute("HeroId") == nil then
		player:SetAttribute("HeroId", Constants.DefaultHeroId)
	end
end

function HeroService.Init()
	print("[HeroService] Init")
end

function HeroService.Start()
	print("[HeroService] Start")
	for _, player in ipairs(Players:GetPlayers()) do
		ensureHeroAttributes(player)
	end
	Players.PlayerAdded:Connect(ensureHeroAttributes)

	local abilityRemote = getRemote(RemoteNames.RequestAbility)
	abilityRemote.OnServerEvent:Connect(function(player)
		local MatchService = require(script.Parent.MatchService)
		if not MatchService.IsPlayerAlive(player) then
			return
		end

		-- Ability effects are intentionally out of scope for this vertical slice. This
		-- server-owned gate keeps downed players from firing future ability requests.
	end)
end

return HeroService
