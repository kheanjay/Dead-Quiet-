# OWNERSHIP — one writer per system

Each system has exactly one owner chat. Only the owner edits that system's code, config, system doc and blueprint. Anyone else who needs a change writes `docs/proposals/<YYYY-MM-DD>-<topic>.md` and adds a PENDING for the owner in STATE.md. A new system gets a row here the session it is built. DQ-Integration owns no system: it runs cross-Place sessions (deploy shared code, clear contract PENDINGs, end-to-end tests) and edits only what those sessions require, as agreed with the owners. "Canon location" is where the truth lives (Studio path for Place-local code, repo path for shared code/contracts).

| System | Owner chat | Home Place | Canon location |
|---|---|---|---|
| Run flow (phases, night counter, win/lose, 12 nights + boss) | DQ-Game | Game | Studio `ServerScriptService/Services/RunFlowService` |
| Day/night cycle (lighting, timers) | DQ-Game | Game | Studio `.../Services/DayNightService` |
| Noise meter | DQ-Game | Game | Studio `.../Services/NoiseService` + `ReplicatedStorage/Game/Config/Noise` |
| Enemies + waves (incl. boss) | DQ-Game | Game | Studio `.../Services/EnemyService`, `WaveService` |
| Gathering (wood, stone, scrap nodes) | DQ-Game | Game | Studio `.../Services/GatherService` |
| Building / fortifying (walls) | DQ-Game | Game | Studio `.../Services/BuildService` |
| Turrets + traps | DQ-Game | Game | Studio `.../Services/TurretService` |
| Combat: weapons, damage, health | DQ-Combat | Game | Studio `.../Services/CombatService`, `HealthService` |
| Inventory | DQ-Craft | Game | Studio `.../Services/InventoryService` |
| Crafting | DQ-Craft | Game | Studio `.../Services/CraftService` + `Config/Recipes` |
| Loot + points of interest | DQ-Craft | Game | Studio `.../Services/LootService` |
| Salvage (enemy parts → turret/trap upgrades) | DQ-Craft | Game | Studio `.../Services/SalvageService` |
| Run rewards (dawn loot, run-end currency) | DQ-Game | Game | Studio `.../Services/RewardService` |
| UI kit (panels, buttons, templates) | DQ-UI | both | Studio `StarterGui/*` + `docs/design/style-guide.md` |
| HUD + menus | DQ-UI | both | Studio `StarterGui/*Gui` + client controllers |
| Cross-platform input (KB/M, gamepad, touch) | DQ-UI | both | Studio `.../Controllers/InputController` |
| Squads + matchmaking | DQ-Lobby | Lobby | Studio `.../Services/SquadService` |
| Teleport (send/receive) | DQ-Lobby | Lobby | Studio `.../Services/SquadService` (Game side: RunFlowService reads payload) |
| Loadout | DQ-Lobby | Lobby | Studio `.../Services/LoadoutService` |
| Meta shop | DQ-Lobby | Lobby | Studio `.../Services/ShopService` |
| Save data (DataService, session lock) | DQ-Data | Lobby (+Game writes rewards) | Studio `.../Services/DataService` |
| Contracts (save schema, teleport payload) | DQ-Data | both | repo `docs/contracts/` + `shared/src/` |
| Shared modules (`shared/src`, manifest) | DQ-Data | both | repo `shared/src/`, `shared/manifest.json` |
