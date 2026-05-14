# Architecture

## Rojo Layout

The project uses a Rojo-compatible filesystem layout that maps Roblox services to `src/` folders through `default.project.json`.

- `ReplicatedStorage` contains shared configs, shared utility modules, and remote name definitions.
- `ServerScriptService` contains server-only gameplay services and startup orchestration.
- `ServerStorage` contains server-only enemy, buildable, and boss asset placeholders.
- `StarterPlayerScripts` contains client presentation and input controllers.

## Server-Authoritative Gameplay

Gameplay state must be owned by the server. Clients may request actions, but they do not decide outcomes.

The server is authoritative for:

- Damage and healing
- Currency and rewards
- Inventory and progression
- Hero selection validity
- Ability cooldowns and effects
- Build placement, costs, repairs, and health
- Enemy spawning, health, movement, and deaths
- Wave and match state

## RemoteEvent Policy

RemoteEvents are reserved for validated player intent and server-to-client presentation updates. Client requests should be treated as untrusted input and validated by the relevant server service before any state changes occur.

Required remotes are defined by name in `ReplicatedStorage/Remotes/init.lua`; gameplay logic should not be implemented in that module.

## Service Startup

`Main.server.lua` requires all server services, calls `Init()` on every service, then calls `Start()` on every service. This keeps dependency setup separate from event connections and gameplay loops.
