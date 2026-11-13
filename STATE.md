# STATE — Dead Quiet
<!-- Current state ONLY; history lives in CHANGELOG.md. Owner: the chat that lands (refresh at every landing). Last verified: 2026-11-13, session B3. Budget ≤6,000 chars (wc -m). Resolved PENDINGs are deleted. -->

## Snapshot
- **Game:** co-op (1–5) open-world wave survival in a post-apocalyptic scrapland. Day: explore, gather, loot, craft, build. Night: defend the base against mutant waves, with turrets and traps. A run is 12 nights, boss on night 12; meta-currency persists between runs. Twist: **Noise** (day activity sets night difficulty + dawn loot) and **Salvage war** (enemy parts upgrade turrets/traps). Pitch: `docs/design/pitch.md`.
- **Engine:** Roblox Studio, Luau `--!strict`. PC main + console + mobile from day one.
- **Lobby Place:** loadout, meta shop, squad matchmaking → teleport to Game. Not created yet (M3). `places/Lobby/CONTEXT.md`.
- **Game Place:** open world, day/night, waves, run flow, rewards → teleport back. Exists: PlaceId `102971328877698`, experience `10776369632`, currently the start place. Empty template. `places/Game/CONTEXT.md`.
- **Built:** nothing in-game. Repo + workflow scaffolding (B1); Game PlaceId recorded (B2).
- **Contracts:** save-schema v0 DRAFT, teleport-payload v0 DRAFT (neither deployed). Shared modules: none.
- **Current milestone:** M1 "Playable night" (enemy: Howler): `docs/specs/M1-playable-night.md`.
- **Next session id:** B4.

## Open PENDINGs
- **PENDING (USER, Game, B2):** Rename the place `Place1` → "Game" (Asset Manager / Game Settings), and stop any running playtest before the next build session (Players had a player at B2).
- **PENDING (USER, Game, B1):** Confirm the M1 map blockout. Default: small ~300×300-stud scrapyard, central base plot, wood + stone nodes around it.
