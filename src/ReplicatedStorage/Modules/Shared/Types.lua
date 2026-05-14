--!strict

export type HeroId = "Vanguard" | "Ranger" | "Engineer" | "Medic"
export type EnemyId = "Grunt" | "Runner" | "Tank" | "Bomber" | "Flyer"
export type BuildableId = "Wall" | "Turret" | "SpikeTrap"

export type HeroDefinition = {
	DisplayName: string,
	Role: string,
	MaxHealth: number,
	PrimaryStat: string,
	AbilityIds: { string },
}

export type EnemyDefinition = {
	DisplayName: string,
	Health: number,
	Speed: number,
	RewardScrap: number,
	Threat: string,
}

export type BuildableDefinition = {
	DisplayName: string,
	Cost: number,
	MaxHealth: number,
	Description: string,
}

return {}
