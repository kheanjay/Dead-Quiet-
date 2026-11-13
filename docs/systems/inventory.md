# System — Inventory
<!-- Owner: DQ-Craft. Home Place: Game. Canon: Studio ServerScriptService/Services/InventoryService. Present tense, current truth. Budget ≤300 lines. Last verified: 2026-11-14, B5. -->

## What it does
Keeps each player's resource counts (M1: wood, stone) on the server. Other services add and remove resources through the server API; the owning client gets a copy of its own counts for the HUD. Clients can never set a count. Counts live for the server's lifetime only (no save; one server = one run).

## Where it lives
| Piece | Path |
|---|---|
| Service | `ServerScriptService/Services/InventoryService` (ModuleScript, in `Main`'s `ORDER`) |
| Client cache | `StarterPlayerScripts/Controllers/InventoryController` (ModuleScript, in `ClientMain`'s `ORDER`) |
| Item ids | `ReplicatedStorage/Game/Config/Items` (`WOOD = "wood"`, `STONE = "stone"`, `ORDER`, `MAX_COUNT = 9999`) |
| Remote | `ReplicatedStorage/Remotes/inventoryChanged` (RemoteEvent, authored in Studio) |
| Debug flag | `Config/Debug.INVENTORY` (`[Test] Inventory …` on server + client, and the test hook). Off at landing. |

## Server API (`InventoryService`)
Use the `Items` constants for ids. Amounts are whole numbers from 1 to `MAX_COUNT`; anything else (zero, negative, fraction, NaN, unknown id, a player who has left) returns `false` / `0` and changes nothing.
- `:add(player, itemId, amount)` → boolean. Clamps at `Items.MAX_COUNT`.
- `:remove(player, itemId, amount)` → boolean. `false` and nothing removed when the player holds less.
- `:has(player, itemId, amount)` → boolean.
- `:get(player, itemId)` → number. `:getAll(player)` → copy of `{ [itemId]: count }`.
- `:hasAll(player, cost)` / `:removeAll(player, cost)` → boolean, for multi-item costs `{ wood = 4, stone = 2 }`. `removeAll` is all or nothing.
- `:onChanged(fn(player, itemId, count, delta))` → disconnect function. Server-side listeners.

A player's inventory is created (all zeros) on `PlayerAdded` and dropped on `PlayerRemoving`.

## Replication (`Remotes/inventoryChanged`)
- Server → owning client only, on every change: `(counts, itemId, delta)`. `counts` is the full `{ [itemId]: count }` table, so a missed event self-heals on the next one.
- Client → server with no arguments: "send me a snapshot". The server ignores any arguments, honours one request per second per player, and replies `(counts, nil, nil)`.

## Client API (`InventoryController`)
`:get(itemId)` → number (0 until the first snapshot), `:getAll()` → copy, `:onChanged(fn(itemId, count, delta))` → disconnect. Fires once per item whose count changed. The HUD (DQ-UI) binds to this; no UI exists yet.

## Adding a resource
Add a constant and its id to `ORDER` in `Config/Items`. Nothing else changes.

## Test hook
While `Debug.INVENTORY` is on, 3 s after a player joins the server runs a fixed sequence (adds, removes, rejected calls) and prints each result; the player should end with wood 2, stone 2. It never runs with the flag off.

## Verified
- 2026-11-14 B5: 1-player Studio playtest (user-pasted Output), via the test hook: add, remove, has, removeAll and every rejected call returned the expected result; server ended at wood 2, stone 2; the client cache got the initial snapshot and every change and ended at wood 2, stone 2.
- NOT verified: 2+ players (each client receiving only its own counts), `MAX_COUNT` clamp, the snapshot rate limit.
