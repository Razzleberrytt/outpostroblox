--!strict

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

print("[Outpost Legends] Client boot starting")

for _, controllerName in ipairs(controllerOrder) do
	Controllers[controllerName].Init()
end

for _, controllerName in ipairs(controllerOrder) do
	Controllers[controllerName].Start()
end

print("[Outpost Legends] Client boot complete")
