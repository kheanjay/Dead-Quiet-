# Contract — Teleport payload (Lobby ↔ Game)
- **Version:** 0 (DRAFT, not deployed) · **Owner:** DQ-Data (shape) · **Producers/consumers:** DQ-Lobby (Lobby→Game), DQ-Game (reads; Game→Lobby)
- **Module:** `shared/src/TeleportPayload.luau` → `ReplicatedStorage/Shared/TeleportPayload` (build + validate functions; not created yet)
- Becomes v1 when first deployed (M3).

## Lobby → Game (TeleportOptions:SetTeleportData)
```lua
export type ToGame = {
	v: number,                 -- payload version
	squadId: string,           -- GUID
	members: { number },       -- UserIds in the squad
	loadouts: { [string]: { weapon: string, perk: string? } }, -- key = tostring(UserId)
}
```

## Game → Lobby
```lua
export type ToLobby = {
	v: number,
	squadId: string,
	result: "won" | "lost",
	nightReached: number,
}
```
Display only: rewards are already saved by the Game server.

## Rules
- TeleportData is client-visible and spoofable. Treat it as hints: validate loadouts against the saved profile's unlocks; never grant currency from it.
- Unknown or missing `v` → fall back to defaults and print `[CONTRACT] bad payload`.
- Studio playtests have no teleport data: Game uses its dev fallback.
