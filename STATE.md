# STATE — Holdout (working title)
<!-- Current state ONLY; history lives in CHANGELOG.md. Owner: the chat that lands (refresh at every landing). Last verified: 2026-11-13, session B1. Budget ≤6,000 chars (wc -m). Resolved PENDINGs are deleted. -->

## Snapshot
- **Game:** co-op (1–5) open-world wave survival in a post-apocalyptic scrapland. Day: explore, gather, loot, craft, build. Night: defend the base against mutant waves, with turrets and traps. A run is 12 nights, boss on night 12; meta-currency persists between runs. Twist: **Noise** (day activity sets night difficulty + dawn loot) and **Salvage war** (enemy parts upgrade turrets/traps). Pitch: `docs/design/pitch.md`.
- **Engine:** Roblox Studio, Luau `--!strict`. PC main + console + mobile from day one.
- **Lobby Place:** loadout, meta shop, squad matchmaking → teleport to Game. Not created yet. `places/Lobby/CONTEXT.md`.
- **Game Place:** open world, day/night, waves, run flow, rewards → teleport back. Not created yet. `places/Game/CONTEXT.md`.
- **Built:** nothing. Repo + workflow scaffolding only (B1).
- **Contracts:** save-schema v0 DRAFT, teleport-payload v0 DRAFT (neither deployed). Shared modules: none.
- **Current milestone:** M1 "Playable night": `docs/specs/M1-playable-night.md`.
- **Next session id:** B2.

## Open PENDINGs
- **PENDING (USER, both, B1):** Create the Roblox experience: Lobby = start place, Game = second place (Game alone is enough for M1). Open the Game place in Studio with the MCP plugin connected, and give the next chat its PlaceId (goes into `places/Game/CONTEXT.md`).
- **PENDING (USER, repo, B1):** Final game name. Working title "Holdout"; the short code HO stays either way.
- **PENDING (USER, Game, B1):** Confirm the M1 enemy. Default: "Scrapper", a melee mutant drawn to Noise. Detail: `docs/specs/M1-playable-night.md`.
- **PENDING (USER, Game, B1):** Confirm the M1 map blockout. Default: small ~300×300-stud scrapyard, central base plot, wood + stone nodes around it.
