# Contract — Player save schema
- **Version:** 0 (DRAFT, not deployed) · **Owner:** DQ-Data · **Consumers:** Lobby (read/write), Game (writes run rewards)
- **Module:** `shared/src/SaveSchema.luau` → `ReplicatedStorage/Shared/SaveSchema` (not created yet)
- Becomes v1 when DQ-Data first deploys it (M3). After that: never change shapes without bumping the version + adding a migration.

## DataStore
- Store name: `DQ_Profiles` (Studio: `DQ_Profiles_TEST`) · Key: `u_<UserId>`
- Session-locked (one server writes a profile at a time).

## Draft shape (Luau type)
```lua
export type Profile = {
	version: number,            -- schema version (integer)
	cogs: number,               -- meta-currency (name TBD)
	unlocks: { [string]: true },-- unlocked item/turret/perk ids
	cosmetics: { [string]: true },
	equippedCosmetics: { [string]: string }, -- slot -> id
	loadout: { weapon: string, perk: string? },
	stats: { runsPlayed: number, runsWon: number, bestNight: number },
}
```

## Migrations
- (none yet) — each future version adds `migrate_<n-1>_to_<n>(profile) -> profile`; old migrations are never edited.

## Rules
- Run rewards are computed and written by the Game server only; never from client or TeleportData.
