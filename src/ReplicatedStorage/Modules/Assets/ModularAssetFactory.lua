--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Catalog = require(ReplicatedStorage.Modules.Assets.ModularAssetCatalog)

local ModularAssetFactory = {}

local function makePart(spec, origin: CFrame): BasePart
	local part = Instance.new("Part")
	part.Name = spec.Name
	part.Size = spec.Size
	part.CFrame = origin * spec.Offset
	part.Color = spec.Color
	part.Material = spec.Material
	part.Shape = spec.Shape or Enum.PartType.Block
	part.Anchored = true
	part.CanCollide = spec.CanCollide == true
	part.CanTouch = false
	part.CastShadow = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	return part
end

function ModularAssetFactory.Exists(assetId: string): boolean
	return Catalog[assetId] ~= nil
end

function ModularAssetFactory.Create(assetId: string, origin: CFrame): Model?
	local spec = Catalog[assetId]
	if not spec then
		warn(("[ModularAssetFactory] Unknown asset id %s"):format(assetId))
		return nil
	end

	local model = Instance.new("Model")
	model.Name = assetId
	model:SetAttribute("AssetId", assetId)

	local byName: { [string]: BasePart } = {}
	for _, partSpec in ipairs(spec.Parts) do
		local part = makePart(partSpec, origin)
		part.Parent = model
		byName[part.Name] = part
	end

	local primaryPart = byName[spec.PrimaryPart]
	if not primaryPart then
		model:Destroy()
		warn(("[ModularAssetFactory] Asset %s has missing primary part %s"):format(assetId, spec.PrimaryPart))
		return nil
	end

	model.PrimaryPart = primaryPart
	return model
end

return ModularAssetFactory
