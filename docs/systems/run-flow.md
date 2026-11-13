# System — Run flow
<!-- Owner: DQ-Game. Home Place: Game. Canon: Studio ServerScriptService/Services/RunFlowService. Present tense, current truth. Budget ≤300 lines. Last verified: 2026-11-14, B4. -->

## What it does
The run state machine. It owns the phase, the night number, the phase timer and the run outcome, and it replicates them to clients. Other services react to its phase changes; they never set the phase themselves.

```
Waiting ──(≥1 player + START_GRACE)──► Day ─► Dusk ─► Night ─► Dawn ─► (next night | End, Outcome=Win)
                                                        │
                                   every player down ───┴─► Lose ─► End (Outcome=Lose)
```
M1: `NIGHTS_IN_RUN = 1`, so the first Dawn is the win. M2 raises it to 12 (boss on the last night).

## Where it lives
| Piece | Path |
|---|---|
| Service | `ServerScriptService/Services/RunFlowService` (ModuleScript) |
| Config | `ReplicatedStorage/Game/Config/RunFlow` (`NIGHTS_IN_RUN`, `START_GRACE`, `DURATIONS` per phase, seconds) |
| Replicated state | `ReplicatedStorage/Game/RunState` (Folder, attributes below) |
| Client reader | `StarterPlayerScripts/Controllers/RunStateController` |
| Debug flag | `ReplicatedStorage/Game/Config/Debug.RUN_FLOW` (`[Test] RunFlow …` server, `[Test] RunState …` client). Off at landing. |

## Replication (attributes on `ReplicatedStorage/Game/RunState`)
| Attribute | Type | Meaning |
|---|---|---|
| `Phase` | string | `Waiting` `Day` `Dusk` `Night` `Dawn` `Lose` `End` |
| `Night` | number | current night, 0 before the first Day |
| `PhaseEndsAt` | number | `workspace:GetServerTimeNow()` when the phase ends; 0 = no timer |
| `Outcome` | string | `""` while running, `"Win"` from the last Dawn, `"Lose"` from Lose |

The server writes Night, PhaseEndsAt and Outcome before Phase, so a client reacting to `Phase` sees the others already set. No remotes: clients only read.

## Server API (`RunFlowService`)
- `:start()`: called once by `Main`. No side effects on require.
- `:getPhase()`, `:getNight()`, `:getPhaseEndsAt()`, `:getOutcome()`.
- `:onPhaseChanged(fn(phase, night, phaseEndsAt))` → disconnect function. Fires on later changes only; read `getPhase()` for the current phase.
- `:markDown(player)`: the player is down for the rest of this Night. M1 calls it on Humanoid death; DQ-Combat's HealthService can call it later. When every player in the server is down → Lose.
- `:endNightEarly()`: for WaveService when the wave is cleared → Dawn now.

## Client API (`RunStateController`)
`:getPhase()`, `:getNight()`, `:getOutcome()`, `:getTimeLeft()` (seconds, from PhaseEndsAt), `:onPhaseChanged(fn(phase, night))` → disconnect. The HUD (DQ-UI) binds to this; no UI exists yet.

## Entry / dev fallback
`GetJoinData().TeleportData` is nil in Studio and on direct joins (Game is the start place until M3). The service then prints `[DIAG] dev fallback: no teleport data; squad = current players, default loadout` once per server (a permanent diagnostic, not a debug flag). The teleport payload is v0 DRAFT and isn't read yet.

## Rules / hazards
- The down set resets at each Night start. A player who leaves is removed from it, and the wipe check runs again.
- A dead player respawns (CharacterAutoLoads) but stays "down" until the night ends. Revisit with HealthService (M1 session 6).
- End is terminal in M1. M3: RewardService + teleport to the Lobby run from End.

## Verified
- 2026-11-14 B4: 1-player Studio playtest, win path: all phases in order with the configured timings; client saw each phase with the correct timeLeft; DayNight followed each phase.
