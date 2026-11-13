# System — Day/night cycle
<!-- Owner: DQ-Game. Home Place: Game. Canon: Studio ServerScriptService/Services/DayNightService. Present tense, current truth. Budget ≤300 lines. Last verified: 2026-11-14, B4. -->

## What it does
Lighting follows the run phase. Each phase has a preset; on a phase change the server tweens Lighting and the Atmosphere to it. Server-side Lighting replicates, so there's no client code.

## Where it lives
| Piece | Path |
|---|---|
| Service | `ServerScriptService/Services/DayNightService` (ModuleScript; requires RunFlowService) |
| Config | `ReplicatedStorage/Game/Config/DayNight` (`PRESETS` per phase, `TRANSITION` seconds per phase, `DEFAULT_TRANSITION`) |
| Debug flag | `Config/Debug.DAY_NIGHT` (`[Test] DayNight …`). Off at landing. |

## Presets (starting values; the user may retune them in Studio, so ask before "correcting")
| Phase | ClockTime | Brightness | Look (style-guide.md) |
|---|---|---|---|
| Waiting, Day | 13 | 2.6 | warm, hazy, dusty atmosphere |
| Dusk | 18.2 | 1.6 | Rust atmosphere / RustDark decay |
| Night, Lose | 0 | 0.4 | dark blue ambient, high contrast so glow reads |
| Dawn | 6.4 | 1.8 | Teal-tinted atmosphere |
| End | (unchanged) | | keeps the current look |

Each preset sets Lighting `ClockTime`, `Brightness`, `Ambient`, `OutdoorAmbient`, and Atmosphere `Density`, `Haze`, `Color`, `Decay`.

## Behaviour
- On `start()` the current phase's preset is applied instantly, then each phase change tweens (Sine InOut) over `TRANSITION[phase]` seconds. A new phase cancels any running tweens.
- The clock only moves forward: an internal monotonic hour value is tweened and `ClockTime = hour % 24` (Dusk 18.2 → Night 0 passes through midnight, not back through noon).
- No Atmosphere in Lighting → one `[DIAG]` warn; only Lighting properties change. Sky, Bloom, SunRays and DepthOfField are left as authored.
- Hazard: manual Lighting edits in Studio are overwritten at runtime by the presets. Retune the presets in Config instead.

## Verified
- 2026-11-14 B4: 1-player Studio playtest: Waiting (instant), Day, Dusk, Night, Dawn presets each applied on their phase change.
