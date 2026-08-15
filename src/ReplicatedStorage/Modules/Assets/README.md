# Modular Assets

This folder contains data-driven Roblox asset assembly.

- `ModularAssetCatalog.lua` describes reusable assets from composable parts.
- `ModularAssetFactory.lua` builds catalog entries into Roblox `Model` instances at runtime.
- Gameplay systems reference stable `AssetId` values instead of constructing visuals directly.

## Adding an asset

1. Add a new catalog entry with a unique `AssetId`.
2. Define its `PrimaryPart` and component `Parts`.
3. Reference the `AssetId` from the relevant gameplay config (enemy, buildable, prop, weapon, etc.).
4. Keep gameplay stats out of the asset catalog; this layer owns presentation/physical assembly only.

This separation allows art and gameplay to evolve independently and makes later replacement with MeshParts or imported models straightforward without changing service APIs.
