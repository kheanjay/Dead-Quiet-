# CONTEXT — Game Place
<!-- Present tense, current truth only. Architecture owner: HO-Game; each system owner keeps its own lines true. Budget ≤6,000 chars (wc -m). Last verified: 2026-11-13, B1. -->

The Game Place runs one squad's run (1–5 players): an open scrapland map, a day/night cycle, gathering, building, crafting, the Noise meter, night waves, a boss on night 12, dawn rewards, then a teleport back to the Lobby. **Status: not built. The Place does not exist yet (PlaceId: TBD).** Everything below is the INTENDED layout. Replace each line with the truth as it gets built.

## Architecture (intended)
- One server entry script requires services in a fixed order, then calls `:start()` on each. Services are ModuleScripts with no side effects on require.
- `RunFlowService` (HO-Game) is the state machine: `Lobby wait → Day → Dusk → Night → Dawn → … → night 12 boss → End`. It publishes the phase and night number; other services react to it.
- `DayNightService` drives Lighting from the phase. `NoiseService` keeps the shared squad Noise meter (server-side), feeding `WaveService` (wave size/mix) and `RewardService` (dawn loot).
- `GatherService`, `BuildService`, `TurretService` (HO-Game); `InventoryService`, `CraftService`, `LootService`, `SalvageService` (HO-Craft); `CombatService`, `HealthService` (HO-Combat); `EnemyService` + `WaveService` (HO-Game).
- At run end, `RewardService` writes meta-currency to the save via the shared `SaveSchema` module (server-side), then teleports the squad to the Lobby.
- Client: one entry LocalScript requires controllers (input, HUD binding, build placement preview). UI is authored ScreenGuis; controllers only set values/visibility.

## Where things live (intended)
- Server entry: `ServerScriptService/Main` (Script)
- Server services: `ServerScriptService/Services/<Name>Service`
- Client entry: `StarterPlayer/StarterPlayerScripts/ClientMain` (LocalScript)
- Client controllers: `StarterPlayer/StarterPlayerScripts/Controllers/<Name>Controller`
- Place-local shared modules + config: `ReplicatedStorage/Game/` (e.g. `Config/Items`, `Config/Waves`, `Config/Noise`)
- Cross-Place shared modules (deployed from `shared/src`): `ReplicatedStorage/Shared/`
- Remotes: `ReplicatedStorage/Remotes/<camelCaseName>` (RemoteEvent / RemoteFunction)
- Authored UI: `StarterGui/<Name>Gui` (ScreenGui); list templates as `*Template` inside it
- Models/art: `ServerStorage/Assets/{Enemies,Buildables,Props}`; map in `Workspace/Map`; base plot `Workspace/Map/BasePlot`
- Sounds: `SoundService/Palette/<Category>/<Name>`

## Entry paths
- Published: player arrives via teleport from the Lobby with teleport-payload v1 (`docs/contracts/teleport-payload.md`).
- Studio playtest: no teleport data → `RunFlowService` uses a dev fallback (squad = current players, default loadout) and prints `[DIAG] dev fallback`.

## Known hazards
- TeleportService and TeleportData don't work in Studio playtests.
- TeleportData is spoofable: rewards and currency are decided and saved by the server only.
- Night waves + many parts on mobile: keep enemy counts and buildable part counts within the budgets set in the Waves/Building blueprints.
- Stacked walls and floor plates: watch for z-fighting.
