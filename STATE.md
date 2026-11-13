# STATE — Dead Quiet
<!-- Current state ONLY; history lives in CHANGELOG.md. Owner: the chat that lands (refresh at every landing). Last verified: 2026-11-14, session B6. Budget ≤6,000 chars (wc -m). Resolved PENDINGs are deleted. -->

## Snapshot
- **Game:** co-op (1–5) open-world wave survival in a post-apocalyptic scrapland. Day: explore, gather, loot, craft, build. Night: defend the base against mutant waves, with turrets and traps. A run is 12 nights, boss on night 12; meta-currency persists between runs. Twist: **Noise** (day activity sets night difficulty + dawn loot) and **Salvage war** (enemy parts upgrade turrets/traps). Pitch: `docs/design/pitch.md`.
- **Engine:** Roblox Studio, Luau `--!strict`. PC main + console + mobile from day one.
- **Lobby Place:** loadout, meta shop, squad matchmaking → teleport to Game. Not created yet (M3). `places/Lobby/CONTEXT.md`.
- **Game Place:** open world, day/night, waves, run flow, rewards → teleport back. Exists: PlaceId `102971328877698`, experience `10776369632`, currently the start place. Skeleton + run flow + day/night + inventory + HUD/input built; baseplate map. `places/Game/CONTEXT.md`.
- **Built:** Game skeleton (Main, Services, ClientMain, Controllers, Config, Remotes), RunFlowService (one night, test timings, win + lose) and DayNightService (B4, M1 session 1); InventoryService + InventoryController, per-player wood/stone, remote `inventoryChanged` (B5, M1 session 2; `docs/systems/inventory.md`); HudGui + HudController + InputController, actions attack/interact/build, health bar unbound (B6, M1 session 3; `docs/systems/hud-input.md`; gamepad + touch NOT verified). Verified in 1-player Studio playtests; NOT verified with 2+ players. Not published.
- **Next M1 session:** 4 · DQ-Game · Map blockout + GatherService (nodes, respawn); listen via `InputController:onAction("attack" / "interact")`.
- **Contracts:** save-schema v0 DRAFT, teleport-payload v0 DRAFT (neither deployed). Shared modules: none.
- **Current milestone:** M1 "Playable night" (enemy: Howler): `docs/specs/M1-playable-night.md`.
- **Next session id:** B7.

## Open PENDINGs
- **PENDING (DQ-Combat, Game, B6):** M1 session 6: HealthService's client side calls `HudController:setHealth(current, max)`, and melee listens to `InputController:onAction("attack")` (`docs/systems/hud-input.md`).
- **PENDING (USER, Game, B4):** Studio MCP playtests capture no output (see Game CONTEXT hazards): check or update the MCP plugin, or keep pasting Output lines by hand.
- **PENDING (USER, Game, B1):** Confirm the M1 map blockout. Default: small ~300×300-stud scrapyard, central base plot, wood + stone nodes around it.
