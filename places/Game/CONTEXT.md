# CONTEXT — Game Place
<!-- Present tense, current truth only. Architecture owner: DQ-Game; each system owner keeps its own lines true. Budget ≤6,000 chars (wc -m). Last verified: 2026-11-14, B4. -->

The Game Place runs one squad's run (1–5 players): an open scrapland map, a day/night cycle, gathering, building, crafting, the Noise meter, night waves, a boss on night 12, dawn rewards, then a teleport back to the Lobby. Lines marked BUILT are true in Studio; the rest is the INTENDED layout. Replace each line with the truth as it gets built.

**Identity:** PlaceId `102971328877698` · experience GameId `10776369632` · Studio name `Place1` (to be renamed "Game"). Bootstrap check: `get_place_info` must return this PlaceId. **Status: skeleton + run flow + day/night built (B4); baseplate map, no UI, no gameplay yet.** It is currently the experience's start place; when the Lobby is added (M3), the Lobby becomes the start place.

## Architecture
- BUILT · `ServerScriptService/Main` requires the services in its `ORDER` list, then calls `:start()` on each in the same order. Services are ModuleScripts with no side effects on require. A new service = a module in `Services` + its name in `ORDER`.
- BUILT · `RunFlowService` (DQ-Game) is the state machine: `Waiting → Day → Dusk → Night → Dawn → End (Win)`, or `Night → Lose → End` when every player is down. M1 = one night with short test timings (`Config/RunFlow`); M2 = 12 nights + boss. It replicates Phase, Night, PhaseEndsAt, Outcome as attributes on `ReplicatedStorage/Game/RunState`; other services use `:onPhaseChanged`, `:markDown`, `:endNightEarly`. `docs/systems/run-flow.md`.
- BUILT · `DayNightService` tweens Lighting + Atmosphere to a per-phase preset (`Config/DayNight`). `docs/systems/day-night.md`.
- BUILT · Client: `ClientMain` requires the controllers in its `ORDER` list and starts them. `RunStateController` reads the run state (phase, night, time left) for the future HUD.
- Intended · `NoiseService` keeps the shared squad Noise meter (server-side), feeding `WaveService` (wave size/mix) and `RewardService` (dawn loot).
- Intended · `GatherService`, `BuildService`, `TurretService`, `EnemyService`, `WaveService` (DQ-Game); `InventoryService`, `CraftService`, `LootService`, `SalvageService` (DQ-Craft); `CombatService`, `HealthService` (DQ-Combat).
- Intended · At run end, `RewardService` writes meta-currency to the save via the shared `SaveSchema` module (server-side), then teleports the squad to the Lobby.
- Intended · UI is authored ScreenGuis; controllers only set values/visibility.

## Where things live
- BUILT · Server entry: `ServerScriptService/Main` (Script)
- BUILT · Server services: `ServerScriptService/Services/<Name>Service` (now: RunFlowService, DayNightService)
- BUILT · Client entry: `StarterPlayer/StarterPlayerScripts/ClientMain` (LocalScript)
- BUILT · Client controllers: `StarterPlayer/StarterPlayerScripts/Controllers/<Name>Controller` (now: RunStateController)
- BUILT · Place-local config: `ReplicatedStorage/Game/Config/` (now: `RunFlow`, `DayNight`, `Debug`; later e.g. `Items`, `Waves`, `Noise`)
- BUILT · Debug flags: `ReplicatedStorage/Game/Config/Debug`: one boolean per system gating its `[Test]` prints. All false at landing.
- BUILT · Replicated run state: `ReplicatedStorage/Game/RunState` (Folder with attributes)
- BUILT · Remotes: `ReplicatedStorage/Remotes/<camelCaseName>` (RemoteEvent / RemoteFunction). Folder exists, empty.
- Cross-Place shared modules (deployed from `shared/src`): `ReplicatedStorage/Shared/` (not created; no shared modules yet)
- Authored UI: `StarterGui/<Name>Gui` (ScreenGui); list templates as `*Template` inside it
- Models/art: `ServerStorage/Assets/{Enemies,Buildables,Props}`; map in `Workspace/Map`; base plot `Workspace/Map/BasePlot`
- Sounds: `SoundService/Palette/<Category>/<Name>`

## Entry paths
- Published (from M3): player arrives via teleport from the Lobby with teleport-payload v1 (`docs/contracts/teleport-payload.md`). Not read yet.
- BUILT · Studio playtest / direct join: no teleport data → `RunFlowService` prints `[DIAG] dev fallback: no teleport data; squad = current players, default loadout` once and runs with the current players.

## Known hazards
- TeleportService and TeleportData don't work in Studio playtests.
- TeleportData is spoofable: rewards and currency are decided and saved by the server only.
- Night waves + many parts on mobile: keep enemy counts and buildable part counts within the budgets set in the Waves/Building blueprints.
- Stacked walls and floor plates: watch for z-fighting.
- Until M3 this Place is the start place: published joins land here directly with no teleport data (same dev fallback as Studio).
- 2026-11-14 · Studio MCP playtests: `get_playtest_output` captured nothing and `execute_luau target=server` timed out during play (B4). Until that works, the user presses Play and pastes the Output lines.
- Lighting is overwritten at runtime by the DayNight presets: retune `Config/DayNight`, not Lighting itself.
