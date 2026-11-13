# ROADMAP — status board
<!-- One row per feature. Status: done / partial / planned / idea. Flip rows when landing. Large file: grep your rows (grep -n "HO-Game" docs/ROADMAP.md), don't read whole. -->

Milestones: **M1** Playable night · **M2** A full run · **M3** The lobby · **M4** Salvage war + polish.

| Feature | Status | Owner | Notes/doc |
|---|---|---|---|
| Game Place skeleton (folders, Main, ClientMain, Remotes) | planned | HO-Game | M1 · places/Game/CONTEXT.md |
| Map blockout (scrapyard + base plot) | planned | HO-Game | M1 · docs/specs/M1-playable-night.md |
| Run flow state machine (Day→Night→Dawn, win/lose) | planned | HO-Game | M1 (1 night) → M2 (12 nights) |
| Day/night cycle | planned | HO-Game | M1 |
| Gathering: wood + stone nodes | planned | HO-Game | M1 |
| Gathering: scrap nodes | planned | HO-Game | M2 |
| Resource inventory (wood, stone) | planned | HO-Craft | M1 |
| Building: walls | planned | HO-Game | M1 |
| UI kit (industrial scrap panels, buttons, templates) | planned | HO-UI | M1 |
| HUD (resources, phase/timer, health, build) | planned | HO-UI | M1 |
| Cross-platform input (KB/M, gamepad, touch) | planned | HO-UI | M1 |
| Player health + basic melee weapon | planned | HO-Combat | M1 |
| Enemy: Scrapper (melee mutant) | planned | HO-Game | M1 |
| Night wave (single enemy type) | planned | HO-Game | M1 |
| Noise meter (day activity → wave size + dawn loot) | planned | HO-Game | M2 · the twist |
| 12-night run + night-12 boss | planned | HO-Game | M2 |
| More enemy types | planned | HO-Game | M2–M4 |
| Crafting (weapons, gear, quiet tools) | planned | HO-Craft | M2 |
| Loot + points of interest | planned | HO-Craft | M2 |
| Ranged weapons | planned | HO-Combat | M2 |
| Dawn rewards (Noise-scaled loot) | planned | HO-Game | M2 |
| Turrets + traps (basic) | planned | HO-Game | M2 |
| Lobby Place skeleton + hub map | planned | HO-Lobby | M3 |
| Save data (DataService, session lock, migrations) | planned | HO-Data | M3 · docs/contracts/save-schema.md |
| Teleport payload + squad teleport | planned | HO-Lobby | M3 · docs/contracts/teleport-payload.md |
| Squads + matchmaking (1–5) | planned | HO-Lobby | M3 |
| Loadout | planned | HO-Lobby | M3 |
| Meta shop + meta-currency | planned | HO-Lobby | M3 |
| Run-end rewards saved to profile | planned | HO-Game | M3 (with HO-Data) |
| Salvage: enemy parts → turret/trap upgrades | planned | HO-Craft | M4 · the twist |
| Sound palette pass (replace placeholders) | planned | HO-UI | M4 |
| Glow art variants pass | planned | HO-UI | M4 |
| Endless mode (unlocked after first win) | idea | HO-Game | after M4 |
| Night modifiers (fog, acid rain, blackout) | idea | HO-Game | variety |
| Nomad rig / base relocation | idea | HO-Game | alt twist from B1 interview |
| Extra biomes / Game places | idea | HO-Game | after M4 |
