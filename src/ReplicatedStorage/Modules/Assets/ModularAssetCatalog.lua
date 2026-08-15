--!strict

export type PartSpec = {
	Name: string,
	Size: Vector3,
	Offset: CFrame,
	Color: Color3,
	Material: Enum.Material,
	Shape: Enum.PartType?,
	CanCollide: boolean?,
}

export type AssetSpec = {
	PrimaryPart: string,
	Parts: { PartSpec },
}

local Catalog: { [string]: AssetSpec } = {
	Enemy_Grunt = {
		PrimaryPart = "Torso",
		Parts = {
			{
				Name = "Torso",
				Size = Vector3.new(3.6, 4.2, 2.6),
				Offset = CFrame.new(),
				Color = Color3.fromRGB(132, 33, 33),
				Material = Enum.Material.Metal,
			},
			{
				Name = "Head",
				Size = Vector3.new(2.3, 2.0, 2.3),
				Offset = CFrame.new(0, 3.1, 0),
				Color = Color3.fromRGB(196, 68, 51),
				Material = Enum.Material.SmoothPlastic,
			},
			{
				Name = "LeftArm",
				Size = Vector3.new(1.1, 3.5, 1.1),
				Offset = CFrame.new(-2.35, 0.35, 0),
				Color = Color3.fromRGB(92, 28, 28),
				Material = Enum.Material.Metal,
			},
			{
				Name = "RightArm",
				Size = Vector3.new(1.1, 3.5, 1.1),
				Offset = CFrame.new(2.35, 0.35, 0),
				Color = Color3.fromRGB(92, 28, 28),
				Material = Enum.Material.Metal,
			},
			{
				Name = "LeftLeg",
				Size = Vector3.new(1.25, 2.7, 1.4),
				Offset = CFrame.new(-0.95, -3.3, 0),
				Color = Color3.fromRGB(64, 64, 68),
				Material = Enum.Material.Metal,
			},
			{
				Name = "RightLeg",
				Size = Vector3.new(1.25, 2.7, 1.4),
				Offset = CFrame.new(0.95, -3.3, 0),
				Color = Color3.fromRGB(64, 64, 68),
				Material = Enum.Material.Metal,
			},
		},
	},
}

return table.freeze(Catalog)
