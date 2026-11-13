# CONTEXT — Lobby Place
<!-- Present tense, current truth only. Architecture owner: DQ-Lobby; each system owner keeps its own lines true. Budget ≤6,000 chars (wc -m). Last verified: 2026-11-13, B1. -->

The Lobby is the start place of the experience. Players load their save, spend meta-currency in the meta shop, pick a loadout, form a squad of 1–5, and teleport together to a reserved Game server. Players return here after a run. **Status: not built. The Place does not exist yet (PlaceId: TBD). Planned for M3.** Everything below is the INTENDED layout. Replace each line with the truth as it gets built.

## Architecture (intended)
- One server entry script requires services in a fixed order, then calls `:start()` on each.
- `DataService` (DQ-Data) loads/saves the player profile through the shared `SaveSchema` module (save-schema contract), with session locking and migrations.
- `ShopService` + `LoadoutService` (DQ-Lobby) spend currency and set the loadout; the server validates every purchase.
- `SquadService` (DQ-Lobby) forms squads (party pads or invite), then `TeleportService:ReserveServer` + `TeleportAsync` to the Game place with teleport-payload v1 built by the shared `TeleportPayload` module.
- Client: one entry LocalScript requires controllers (shop, loadout, squad UI). UI is authored ScreenGuis.

## Where things live (intended)
- Server entry: `ServerScriptService/Main` (Script)
- Server services: `ServerScriptService/Services/<Name>Service`
- Client entry: `StarterPlayer/StarterPlayerScripts/ClientMain`
- Client controllers: `StarterPlayer/StarterPlayerScripts/Controllers/<Name>Controller`
- Place-local config: `ReplicatedStorage/Lobby/Config/` (shop items, prices)
- Cross-Place shared modules (deployed from `shared/src`): `ReplicatedStorage/Shared/`
- Remotes: `ReplicatedStorage/Remotes/<camelCaseName>`
- Authored UI: `StarterGui/<Name>Gui`; list templates as `*Template`
- Map: `Workspace/Lobby` (hub, squad pads, shop kiosk)
- Sounds: `SoundService/Palette/<Category>/<Name>`

## Entry paths
- New join: start place → `DataService` loads the profile (migrates old versions) → spawn in hub.
- Return from Game: same as a new join; rewards are already in the save (written by Game's server).

## Known hazards
- Teleports only work in the published game, not in Studio playtests.
- DataStore in Studio needs API access enabled; use the test store name.
- Never trust TeleportData for currency or unlocks.
