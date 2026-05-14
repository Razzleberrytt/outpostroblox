# Roblox Game Spec

## Working Title: **Outpost Legends: Team Survival Simulator**

## Brutal Business Read

This is a strong Roblox concept **only if it is scoped tightly**.

Do **not** build a giant open-world RPG first. That will kill the project. The highest-probability version is:

> **A team-based survival defense game with simulator-style upgrades and RPG hero progression.**

Think:

**Simulator progression** = permanent upgrades, pets/companions, power numbers, rebirth-style prestige
**RPG** = heroes/classes, gear, skills, bosses, quests
**Hero defense** = lanes, waves, enemy types, base defense
**Survival team-based** = players must cooperate, revive, gather, defend, and survive escalating nights

The game should feel easy to understand in 30 seconds but deep enough to keep grinding.

---

# 1. Core Game Pitch

**Outpost Legends** is a co-op survival defense simulator where players choose heroes, gather resources, build defenses, fight waves of enemies, upgrade their base, and survive as many nights as possible.

Players earn permanent upgrades between matches, unlock new heroes, improve gear, collect companions, and push into harder zones.

## One-Sentence Pitch

> Team up, choose your hero, build your outpost, survive enemy waves, defeat bosses, and grow stronger every run.

---

# 2. Target Audience

## Primary Audience

Roblox players who like:

* Simulator games
* Anime/RPG power progression
* Tower defense
* Survival games
* Co-op/team games
* Pets/companions
* Unlocking zones
* Grinding upgrades

## Age Target

Roughly **8–16**, but with enough strategy for older players.

## Platform Priority

Design for:

1. Mobile
2. Tablet
3. PC
4. Console later

Mobile-first is mandatory for Roblox.

---

# 3. Core Fantasy

The player fantasy is:

> “I am getting stronger every run, my team needs me, and our base is becoming powerful enough to survive impossible waves.”

The emotional hook:

* Panic during waves
* Relief after surviving
* Satisfaction from upgrades
* Pride from carrying the team
* Curiosity from unlocking new zones/heroes

---

# 4. Game Structure

## Main Game Mode

### **Survival Defense Run**

A run lasts about **10–18 minutes**.

Each run has:

1. Lobby / matchmaking
2. Hero selection
3. Map vote
4. Prep phase
5. Enemy wave phase
6. Upgrade phase
7. Boss wave
8. Rewards
9. Return to hub

---

# 5. Core Gameplay Loop

## Session Loop

```text
Enter lobby
→ Choose hero
→ Join team
→ Vote map/difficulty
→ Spawn at outpost
→ Gather resources
→ Build defenses
→ Fight enemy waves
→ Upgrade hero/base
→ Survive boss
→ Earn rewards
→ Spend rewards on permanent progression
→ Repeat harder content
```

## Minute-to-Minute Loop

```text
Move
→ Gather
→ Build
→ Fight
→ Revive teammates
→ Upgrade
→ Survive
```

## Long-Term Loop

```text
Unlock heroes
→ Upgrade heroes
→ Collect companions
→ Upgrade weapons
→ Unlock zones
→ Prestige/rebirth
→ Push higher waves
→ Climb leaderboards
```

---

# 6. Team-Based Survival Mechanics

## Team Size

Recommended:

* Solo supported
* Ideal team: **4 players**
* Max team: **6 players**

## Shared Objective

The team protects a central structure:

### **The Core**

If the Core reaches 0 HP, the run ends.

The Core can be:

* Upgraded
* Shielded
* Repaired
* Temporarily boosted
* Damaged by enemies

## Downed Player System

Players do not instantly die.

When HP reaches 0:

* Player enters **Downed State**
* Crawls slowly
* Teammates can revive
* If not revived in time, player respawns after delay
* Respawn delay increases each death

## Why This Matters

This makes the game feel team-based instead of just “everyone fighting alone.”

---

# 7. Hero System

Players choose from heroes/classes before each run.

Each hero has:

* Basic attack
* Skill 1
* Skill 2
* Ultimate
* Passive ability
* Role identity
* Upgrade path

---

## Starter Heroes

### 1. **Vanguard**

Tank / frontline defender

**Role:** Protect teammates and hold enemy groups.

Abilities:

* Shield Bash
* Taunt Pulse
* Fortify
* Ultimate: Iron Wall

Passive:

* Takes reduced damage near the Core

Best for:

* New players
* Boss tanking
* Holding lanes

---

### 2. **Ranger**

Ranged damage dealer

**Role:** Kill enemies before they reach the base.

Abilities:

* Quick Shot
* Explosive Arrow
* Mark Target
* Ultimate: Arrow Storm

Passive:

* Deals bonus damage to marked enemies

Best for:

* DPS players
* Flying enemies
* Boss damage

---

### 3. **Engineer**

Builder / defense specialist

**Role:** Builds and upgrades traps, turrets, walls, and repair stations.

Abilities:

* Deploy Turret
* Repair Beam
* Build Trap
* Ultimate: Overclock Defenses

Passive:

* Builds cost fewer resources

Best for:

* Strategic players
* Base defense
* Team support

---

### 4. **Medic**

Support / healer

**Role:** Keeps the team alive.

Abilities:

* Healing Burst
* Cleanse
* Revive Boost
* Ultimate: Team Recovery Field

Passive:

* Revives teammates faster

Best for:

* Team players
* Hard difficulty
* Survival runs

---

### 5. **Mystic**

AoE / crowd control

**Role:** Slows, stuns, and damages groups.

Abilities:

* Energy Orb
* Gravity Field
* Spirit Chain
* Ultimate: Rift Storm

Passive:

* Enemies affected by Mystic abilities take bonus team damage

Best for:

* Crowd control
* Wave clearing
* Advanced players

---

# 8. Defense System

The base can be defended with buildable objects.

## Buildables

### Walls

* Block enemies
* Can be repaired
* Can be upgraded

### Turrets

* Auto-attack enemies
* Upgrade damage/fire rate/range

### Traps

Examples:

* Spike trap
* Slow trap
* Fire trap
* Shock trap

### Healing Station

* Restores player HP
* Limited range
* Upgradeable

### Resource Extractor

* Generates resources during prep/waves
* High-value target enemies may attack it

---

# 9. Resource System

Each run uses temporary resources.

## In-Run Resources

### Scrap

Used for:

* Walls
* Turrets
* Repairs
* Traps

Earned by:

* Gathering
* Killing enemies
* Breaking crates
* Completing objectives

### Energy

Used for:

* Hero ability upgrades
* Core shields
* Team boosts

Earned by:

* Surviving waves
* Defeating elites
* Completing side objectives

---

# 10. Simulator Progression

This is the part that makes the game sticky.

Players need permanent growth outside of runs.

## Permanent Progression

Players earn:

* Coins
* Hero XP
* Gear drops
* Companion eggs
* Upgrade materials
* Zone tokens

## Upgrade Categories

### Hero Level

Improves:

* Damage
* HP
* Ability strength
* Ultimate cooldown

### Weapon Level

Improves:

* Basic attack damage
* Critical chance
* Attack speed

### Base Mastery

Improves:

* Starting resources
* Build speed
* Repair speed
* Core HP

### Companion Level

Companions provide:

* Coin multiplier
* Damage multiplier
* Resource multiplier
* Healing bonus
* Build speed bonus

---

# 11. Companion / Pet System

Roblox players respond strongly to collectible companion systems.

## Companions

Companions follow the player and provide passive boosts.

Examples:

* Scrap Bot
* Mini Dragon
* Forest Spirit
* Crystal Fox
* Tiny Golem
* Robo Owl

## Companion Rarities

* Common
* Uncommon
* Rare
* Epic
* Legendary
* Mythic

## Companion Stats

Each companion may boost:

* Damage
* Coins
* XP
* Scrap gain
* Ability cooldown
* Healing
* Build speed

## Egg System

Players buy eggs using Coins or zone-specific tokens.

Important: keep paid eggs cosmetic or convenience-focused. Avoid hard pay-to-win early.

---

# 12. RPG Gear System

Players can equip gear.

## Gear Slots

* Weapon
* Armor
* Trinket
* Relic

## Gear Rarities

* Common
* Rare
* Epic
* Legendary
* Mythic

## Gear Stats

Examples:

* +Damage
* +Health
* +Cooldown reduction
* +Crit chance
* +Defense build speed
* +Healing power
* +Boss damage
* +Elite damage

## Gear Drops

Dropped from:

* Bosses
* Elite enemies
* Survival milestones
* Daily quests
* Zone chests

---

# 13. Enemy Design

Enemies should be readable, simple, and distinct.

## Basic Enemy Types

### Grunt

* Basic melee enemy
* Attacks players/Core

### Runner

* Fast enemy
* Low HP
* Rushes the Core

### Tank

* Slow
* High HP
* Requires team focus

### Spitter

* Ranged enemy
* Attacks from distance

### Bomber

* Explodes near walls/Core
* Must be killed early

### Flyer

* Ignores walls
* Requires ranged attacks/turrets

### Healer

* Heals enemies
* Priority target

### Elite

* Stronger version with special effects

---

# 14. Boss Design

Every run should end with a boss.

## Boss Example: **The Hollow Brute**

Mechanics:

* Charges at the Core
* Slams the ground
* Spawns minions
* Has armor phases
* Enrages below 30% HP

## Boss Example: **The Swarm Queen**

Mechanics:

* Spawns insect waves
* Creates poison zones
* Summons flying enemies
* Must destroy eggs before they hatch

## Boss Example: **The Scrap Titan**

Mechanics:

* Targets turrets
* Throws debris
* Becomes stronger if defenses are ignored

---

# 15. Map / Zone Progression

The game should launch with **one strong zone**, not five weak ones.

## Launch Zone

### **Forest Outpost**

Theme:

* Abandoned forest base
* Glowing crystals
* Broken machines
* Dark survival atmosphere but kid-friendly

Map areas:

* Central Core
* North lane
* East lane
* West lane
* Resource field
* Upgrade station
* Boss gate

## Future Zones

### Crystal Caverns

* More elites
* More flying enemies

### Desert Ruins

* Heat hazard
* Sandstorm events

### Frozen Wastes

* Slower movement
* Ice enemies

### Toxic Swamp

* Poison zones
* Healing more important

---

# 16. Run Difficulty

Difficulty should scale clearly.

## Difficulty Options

### Normal

* For new players
* Basic rewards

### Hard

* More elites
* Better rewards

### Nightmare

* Strong team required
* Legendary drops possible

### Endless

* Infinite waves
* Leaderboard mode

---

# 17. Match Flow

## Pre-Run Lobby

Players can:

* Choose hero
* Equip gear
* Equip companions
* Vote map
* Vote difficulty
* Invite friends
* See team roles

## In-Run Flow

### Phase 1: Prep

Duration: 60–90 seconds

Players:

* Gather scrap
* Build defenses
* Upgrade walls/turrets
* Choose team boosts

### Phase 2: Wave

Duration: 90–150 seconds

Players:

* Fight enemies
* Repair base
* Revive teammates
* Protect the Core

### Phase 3: Upgrade

Duration: 30–45 seconds

Players:

* Upgrade hero abilities
* Upgrade defenses
* Prepare for next wave

### Final Phase: Boss

The boss appears after wave 5, 10, or 15 depending on mode.

---

# 18. Player Progression

## Player Level

Player level unlocks:

* New zones
* New heroes
* New buildables
* New difficulty modes
* More companion slots

## Hero Level

Each hero levels separately.

This encourages replay.

## Account Upgrades

Permanent upgrades apply to all heroes.

Examples:

* +Starting HP
* +Starting Scrap
* +Coin Gain
* +XP Gain
* +Build Speed
* +Core HP

---

# 19. Rebirth / Prestige System

Once players reach a certain level, they can prestige.

## Rebirth Benefits

Reset some progress in exchange for:

* Permanent multiplier
* Special aura
* Exclusive companion
* Leaderboard badge
* Higher upgrade cap

Keep this simple at first.

---

# 20. Quest System

## Daily Quests

Examples:

* Survive 5 waves
* Revive 3 teammates
* Defeat 50 enemies
* Repair 10 defenses
* Win as Engineer
* Defeat one boss

## Weekly Quests

Examples:

* Complete 10 survival runs
* Win on Hard difficulty
* Collect 5 rare gear pieces
* Survive 25 endless waves

## Role Quests

Examples:

* As Medic, heal 5,000 HP
* As Engineer, build 25 defenses
* As Vanguard, block 10,000 damage

---

# 21. Monetization

Keep this ethical and Roblox-safe.

## Gamepasses

### VIP Pass

Benefits:

* +10% coins
* VIP name tag
* VIP daily chest
* VIP cosmetic aura

### Extra Companion Slot

Allows one additional companion equipped.

### Extra Loadout Slot

Save more hero/gear builds.

### Cosmetics Pack

Includes:

* Auras
* Trails
* Weapon skins
* Base skins

### Private Server Support

Useful for friend groups.

---

## Developer Products

### Coin Boost

Temporary multiplier.

### XP Boost

Temporary multiplier.

### Revive Token

Revives faster, but should not trivialize survival.

### Cosmetic Crates

Only sell cosmetics or mostly cosmetics.

---

# 22. Avoid These Mistakes

## Do Not Build First

Avoid starting with:

* Huge open world
* Trading economy
* 20 heroes
* 50 pets
* Complex crafting
* PvP
* Story campaign
* Massive lore system
* Procedural maps
* Too many currencies

That will become unmanageable.

## Build First

Start with:

* One map
* Four heroes
* Five enemy types
* One boss
* Basic upgrade shop
* Basic companion system
* One survival mode
* One lobby
* Data saving

---

# 23. MVP Scope

## MVP Goal

A playable version that proves the core game is fun.

## MVP Features

### Required

* Lobby
* Team joining
* Hero selection
* One map
* Core defense objective
* 5 waves
* One boss
* Three buildables:

  * Wall
  * Turret
  * Spike trap
* Four heroes:

  * Vanguard
  * Ranger
  * Engineer
  * Medic
* Basic enemies:

  * Grunt
  * Runner
  * Tank
  * Bomber
  * Flyer
* Coins
* XP
* Basic upgrades
* Data saving
* Mobile UI

### Not Required for MVP

* Trading
* Rebirth
* Multiple zones
* Advanced pets
* Huge gear system
* Cosmetics shop
* Cutscenes
* PvP
* Clans
* Battle pass

---

# 24. Vertical Slice

Before building the full MVP, build a vertical slice.

## Vertical Slice Goal

One complete 5-minute match.

## Includes

* One small test map
* One hero
* One enemy type
* One turret
* One Core
* Three waves
* Basic rewards
* Basic data save

## Success Criteria

The test is successful only if:

* Players understand what to do without explanation
* Protecting the Core feels tense
* Upgrades feel useful
* Teamwork matters
* Players want to do another run

---

# 25. Recommended Build Order

## Phase 1 — Core Prototype

Build:

1. Player spawns
2. Core object with HP
3. Enemy spawner
4. Enemies path toward Core
5. Enemies damage Core
6. Players can attack enemies
7. Waves start/end
8. Win/loss condition

Do not add pets, shops, or cosmetics yet.

---

## Phase 2 — Team Survival

Add:

1. Downed state
2. Revive system
3. Basic team UI
4. Core health UI
5. Wave countdown
6. Enemy counter
7. Reward screen

---

## Phase 3 — Hero Classes

Add:

1. Hero selection
2. Vanguard
3. Ranger
4. Engineer
5. Medic
6. Basic abilities
7. Cooldowns
8. Hero leveling

---

## Phase 4 — Buildables

Add:

1. Wall
2. Turret
3. Spike trap
4. Repair system
5. Scrap resource
6. Build placement UI

---

## Phase 5 — Progression

Add:

1. Coins
2. XP
3. Upgrade shop
4. DataStore saving
5. Basic gear
6. Daily quests

---

## Phase 6 — Simulator Systems

Add:

1. Companions
2. Eggs
3. Companion multipliers
4. Rebirth/prestige
5. Zone unlocks

---

## Phase 7 — Monetization

Add:

1. VIP pass
2. Cosmetic shop
3. Boosts
4. Extra loadouts
5. Extra companion slot

---

# 26. Data Model

## Player Data

```lua
PlayerData = {
    Coins = 0,
    Gems = 0,
    Level = 1,
    XP = 0,
    Rebirths = 0,

    UnlockedHeroes = {
        "Vanguard",
        "Ranger"
    },

    HeroLevels = {
        Vanguard = 1,
        Ranger = 1,
        Engineer = 1,
        Medic = 1
    },

    EquippedHero = "Vanguard",

    Companions = {},

    EquippedCompanions = {},

    Gear = {},

    EquippedGear = {
        Weapon = nil,
        Armor = nil,
        Trinket = nil,
        Relic = nil
    },

    Upgrades = {
        CoreHealth = 0,
        StartingScrap = 0,
        CoinMultiplier = 0,
        BuildSpeed = 0
    },

    QuestProgress = {}
}
```

---

# 27. Core Systems Needed

## Roblox Services

Likely needed:

* Players
* ReplicatedStorage
* ServerScriptService
* ServerStorage
* DataStoreService
* CollectionService
* PathfindingService
* MarketplaceService
* TweenService

## Main Folders

```text
ReplicatedStorage
  Remotes
  Modules
    HeroConfig
    EnemyConfig
    WaveConfig
    BuildableConfig
    UpgradeConfig

ServerScriptService
  Services
    DataService
    WaveService
    EnemyService
    CombatService
    BuildService
    RewardService
    HeroService

ServerStorage
  Enemies
  Buildables
  Bosses

StarterGui
  MainHUD
  HeroSelectUI
  UpgradeUI
  RewardUI

Workspace
  Maps
  ActiveEnemies
  ActiveBuildables
```

---

# 28. UI Requirements

## Main HUD

Must show:

* Core HP
* Player HP
* Wave number
* Enemies remaining
* Scrap amount
* Ability buttons
* Revive prompt
* Build button
* Upgrade button

## Mobile Controls

Mobile should have:

* Large ability buttons
* Simple build placement
* Clear revive button
* Minimal clutter
* Big readable text

Do not make the UI tiny. Roblox mobile users will leave.

---

# 29. Art Direction

## Style

Use a bright stylized Roblox look.

Recommended style:

* Colorful
* Slightly heroic
* Slightly mysterious
* Not too dark
* Not horror-heavy

## Visual Theme

“Fantasy survival outpost with light sci-fi machines.”

This lets you have:

* Heroes
* Turrets
* Monsters
* Magic
* Pets
* Upgrades
* Crystals
* Zones

---

# 30. Sound Design

Important sounds:

* Wave starting alarm
* Core taking damage
* Enemy death
* Boss spawn
* Ability activation
* Turret firing
* Level up
* Reward chest
* Teammate downed
* Teammate revived

Sound matters more than people think. It makes the game feel alive.

---

# 31. Retention Systems

## Day 1 Retention

Players should get:

* Fast first match
* Easy first win
* First hero upgrade within 5 minutes
* First companion within 10–15 minutes

## Day 3 Retention

Players should want:

* New hero
* Better companion
* Hard difficulty
* Zone unlock

## Day 7 Retention

Players should chase:

* Legendary gear
* Rebirth
* Endless leaderboard
* Weekly quests

---

# 32. First 30 Minutes Player Experience

## Minute 0–2

Player joins hub.

They see:

* Play button
* Hero selection
* Upgrade shop
* Companion egg
* Daily quest board

## Minute 2–10

Player enters first match.

They:

* Defend Core
* Fight waves
* Build simple defenses
* Defeat mini boss
* Earn coins/XP

## Minute 10–15

Player returns to lobby.

They:

* Upgrade hero
* Open first companion egg
* See next unlock

## Minute 15–30

Player plays again with visible power increase.

This is critical. The second run must feel better than the first.

---

# 33. Success Metrics

Track these mentally or with analytics later.

## Important Metrics

* How many players finish the tutorial?
* How many players complete first match?
* How many players play a second match?
* Average session length
* Most-used hero
* Most failed wave
* Most purchased upgrade
* Where players quit

## Minimum Healthy Signals

A good early version should get:

* Players understanding the objective quickly
* Players replaying at least twice
* Players asking how to unlock things
* Players helping each other during waves

---

# 34. Development Priority

## Highest Priority

1. Fun combat
2. Clear objective
3. Smooth waves
4. Team revive system
5. Satisfying upgrades
6. Data saving
7. Mobile usability

## Lower Priority

1. Lore
2. Cosmetics
3. Multiple maps
4. Trading
5. Advanced economy
6. Cutscenes
7. Complex crafting

---

# 35. Final Recommended MVP

Build this exact version first:

## **Outpost Legends MVP**

* 1 lobby
* 1 map: Forest Outpost
* 4 heroes:

  * Vanguard
  * Ranger
  * Engineer
  * Medic
* 5 enemy types:

  * Grunt
  * Runner
  * Tank
  * Bomber
  * Flyer
* 3 buildables:

  * Wall
  * Turret
  * Spike Trap
* 5 waves
* 1 boss
* Core defense objective
* Downed/revive system
* Coins
* XP
* Basic hero upgrades
* Basic companion egg
* Data saving
* Mobile-first HUD

That is the version with the highest chance of actually getting finished and tested.

---

# 36. Short Build Prompt for Roblox/Codex/Agent

Use this as the project prompt:

```text
Create a Roblox co-op survival defense simulator RPG called Outpost Legends.

Core concept:
Players join a team, choose a hero class, defend a central Core from enemy waves, gather Scrap, build defenses, revive teammates, defeat a boss, earn Coins and XP, then upgrade heroes and permanent progression in the lobby.

MVP scope:
- One lobby
- One map: Forest Outpost
- Team size: 1–6 players
- Core object with health
- Wave system with 5 waves
- Boss after wave 5
- Four heroes: Vanguard, Ranger, Engineer, Medic
- Three buildables: Wall, Turret, Spike Trap
- Five enemy types: Grunt, Runner, Tank, Bomber, Flyer
- Downed/revive system
- Scrap in-run currency
- Coins and XP as permanent rewards
- Basic DataStore saving
- Mobile-friendly HUD

Do not build:
- trading
- PvP
- multiple maps
- huge open world
- complex crafting
- advanced cosmetics
- battle pass
- clans

Architecture:
Use server-authoritative combat and wave spawning.
Keep configs in ModuleScripts.
Separate systems into DataService, WaveService, EnemyService, CombatService, BuildService, HeroService, and RewardService.
Use RemoteEvents only for validated player actions.
Do not trust client-side damage, currency, or rewards.

Goal:
Create a playable vertical slice first:
one hero, one enemy, one turret, one Core, three waves, basic rewards.
Then expand to the full MVP.
```

---

# 37. Best Name Options

## Strongest Names

1. **Outpost Legends**
2. **Corefall Survival**
3. **Hero Outpost Simulator**
4. **Last Stand Legends**
5. **Crystal Siege Simulator**
6. **Defense Heroes: Survival**
7. **Outpost Defenders**
8. **Hero Siege Survival**
9. **Monster Wave Simulator**
10. **Corebound Heroes**

Best pick: **Outpost Legends**

It is clean, flexible, and does not trap the game into one theme.
