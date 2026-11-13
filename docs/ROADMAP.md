# ROADMAP — status board
<!-- One row per feature. Status: done / partial / planned / idea. Flip rows when landing. Large file: grep your rows (grep -n "DQ-Game" docs/ROADMAP.md), don't read whole. -->

Milestones: **M1** Playable night · **M2** A full run · **M3** The lobby · **M4** Salvage war + polish.

| Feature | Status | Owner | Notes/doc |
|---|---|---|---|
| Game Place skeleton (folders, Main, ClientMain, Remotes) | done | DQ-Game | M1 · B4 · places/Game/CONTEXT.md |
| Map blockout (scrapyard + base plot) | planned | DQ-Game | M1 · docs/specs/M1-playable-night.md |
| Run flow state machine (Day→Night→Dawn, win/lose) | partial | DQ-Game | M1 (1 night) done B4 → M2 (12 nights) · docs/systems/run-flow.md |
| Day/night cycle | done | DQ-Game | M1 · B4 · docs/systems/day-night.md |
| Gathering: wood + stone nodes | planned | DQ-Game | M1 |
| Gathering: scrap nodes | planned | DQ-Game | M2 |
| Resource inventory (wood, stone) | done | DQ-Craft | M1 · B5 · docs/systems/inventory.md |
| Building: walls | planned | DQ-Game | M1 |
| UI kit (industrial scrap panels, buttons, templates) | planned | DQ-UI | M1 |
| HUD (resources, phase/timer, health, build) | planned | DQ-UI | M1 |
| Cross-platform input (KB/M, gamepad, touch) | planned | DQ-UI | M1 |
| Player health + basic melee weapon | planned | DQ-Combat | M1 |
| Enemy: Howler (blind melee mutant, hunts by sound) | planned | DQ-Game | M1 · docs/design/pitch.md §Enemies |
| Night wave (single enemy type) | planned | DQ-Game | M1 |
| Noise meter (day activity → wave size + dawn loot) | planned | DQ-Game | M2 · the twist |
| 12-night run + night-12 boss | planned | DQ-Game | M2 |
| Enemy: Gnawer (fast swarm, chews walls) | planned | DQ-Game | M2 |
| Enemy: Husk (slow, scrap-armoured, drops salvage plates) | planned | DQ-Game | M4 · ties to Salvage |
| Boss: Matriarch Howler (night 12) | planned | DQ-Game | M2 |
| Crafting (weapons, gear, quiet tools) | planned | DQ-Craft | M2 |
| Loot + points of interest | planned | DQ-Craft | M2 |
| Ranged weapons | planned | DQ-Combat | M2 |
| Dawn rewards (Noise-scaled loot) | planned | DQ-Game | M2 |
| Turrets + traps (basic) | planned | DQ-Game | M2 |
| Lobby Place skeleton + hub map | planned | DQ-Lobby | M3 |
| Save data (DataService, session lock, migrations) | planned | DQ-Data | M3 · docs/contracts/save-schema.md |
| Teleport payload + squad teleport | planned | DQ-Lobby | M3 · docs/contracts/teleport-payload.md |
| Squads + matchmaking (1–5) | planned | DQ-Lobby | M3 |
| Loadout | planned | DQ-Lobby | M3 |
| Meta shop + meta-currency | planned | DQ-Lobby | M3 |
| Run-end rewards saved to profile | planned | DQ-Game | M3 (with DQ-Data) |
| Salvage: enemy parts → turret/trap upgrades | planned | DQ-Craft | M4 · the twist |
| Sound palette pass (replace placeholders) | planned | DQ-UI | M4 |
| Glow art variants pass | planned | DQ-UI | M4 |
| Endless mode (unlocked after first win) | idea | DQ-Game | after M4 |
| Night modifiers (fog, acid rain, blackout) | idea | DQ-Game | variety |
| Nomad rig / base relocation | idea | DQ-Game | alt twist from B1 interview |
| Extra biomes / Game places | idea | DQ-Game | after M4 |
