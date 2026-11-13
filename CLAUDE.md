# CLAUDE.md — Dead Quiet · code DQ
<!-- CONSTITUTION: rules + rituals. Read first, every session. Budget ≤12,000 chars (wc -m). AGENTS.md mirrors this file for non-Claude AIs: edit both in the same commit. -->

Dead Quiet: co-op (1–5) open-world wave survival in a post-apocalyptic scrapland. Roblox Studio, Luau `--!strict`. PC main + console + mobile. Two Places: **Lobby** and **Game**. Pitch: `docs/design/pitch.md`. Map of all docs: `docs/INDEX.md`.

## 1. Identity & binding
- A chat binds to a SYSTEM, not a file. Names: `DQ-<System>`: DQ-Game, DQ-Combat, DQ-Craft, DQ-UI, DQ-Lobby, DQ-Data, DQ-Integration (cross-Place work only). Who owns what: `docs/OWNERSHIP.md`.
- At bootstrap, before any write, confirm which Place the open Studio instance is (Roblox Studio MCP `get_place_info`: name + PlaceId vs `places/<Place>/CONTEXT.md`). Needed Place not open, or unclear → ask the user. Never work on the wrong Place.
- Don't know which system you are? Ask the user before reading further.

## 2. Bootstrap ritual (in order)
1. Read `CLAUDE.md` (this file).
2. Read `STATE.md`.
3. Read `places/<Place>/CONTEXT.md` for the Place you will touch.
4. Read only the newest 3 CHANGELOG entries: `grep -n '^## ' CHANGELOG.md | head -4`, then `sed -n '1,<4th hit line − 1>p' CHANGELOG.md`.
5. Drift check: run `tools/hash_shared.luau` in Studio and compare with `shared/manifest.json` (`deployed.<Place>`). Mismatch = STOP and reconcile (`tools/checklists.md` §Drift). Manifest has no modules → pass.
6. Any PENDING in STATE.md aimed at your chat/system comes first.
7. Say out loud: "Integration session needed first" or "No Integration needed — proceeding." (Triggers: `tools/checklists.md` §Integration gate.)

## 3. Reading budget
- Bootstrap reads steps 1–4 only. After that, open only what the task touches; `docs/INDEX.md` is the map.
- Never read a file over ~200 lines whole: `grep -n`, then read the range.
- Never open `archive/` whole. `notes/` is the user's scratch: ignore unless asked.
- `docs/ROADMAP.md` is large: grep your rows.

## 4. Multi-chat sync
- The repo beats chat memory. Disk = knowledge, contracts, shared code; Studio = Place-local runtime code; git = ledger (`docs/decisions/ADR-0001-hybrid-canon.md`).
- One writer per system (OWNERSHIP.md). Non-owners never edit it: write `docs/proposals/<YYYY-MM-DD>-<topic>.md` + a PENDING for the owner.
- CHANGELOG is append-only, newest first. Right BEFORE landing, re-read STATE.md and the changelog's first entry (a sibling chat may have landed), then put your entry on top with the next session id.
- Contract or shared-code changes: one chat at a time.
- Unexpected git state (changes you didn't make, unknown commits): STOP, read `git status` + the newest changelog entry, reconcile, ask if unclear.

## 5. Landing checklist (session end + after each verified milestone)
1. Update `places/<Place>/CONTEXT.md` + touched `docs/systems/*.md`. A newly built system gets its system doc, an INDEX.md line and an OWNERSHIP.md row this session.
2. Shared code changed? Update `shared/src`, rehash, update the manifest, PENDING for the other Place to deploy.
3. Contract changed? Bump its version, document old→new + migration, PENDING.
4. CHANGELOG entry on top (format in the file header).
5. Refresh STATE.md (incl. next session id); flip ROADMAP rows.
6. `git add -A && git commit -m "[<Place|repo>] <summary>"`. No AI attribution trailers.
7. User advisory, plain English:
   (a) new PENDINGs and which chat acts before dependent work; (b) is the other Place stale; (c) commit is local, push recommended; (d) what the user must do (publish, set an id, test on a device); (e) should the next session be Integration; (f) ONLY when handing off to another chat: one copy-paste NEXT SESSION PROMPT (identity + Place, the one task, facts/paths/hazards, bootstrap + landing). Same chat continuing → no prompt; ask whether to carry on.

## 6. Editing rules
- Write whole scripts or exact line diffs. Never chained regex / find-replace edits across scripts.
- Persistent edits only in edit mode, never while a playtest runs (play-mode edits are lost).
- Verify live behaviour with tagged prints: `[DIAG]` `[DATA]` `[CONTRACT]` `[Test]`, read back from the output log. Never claim it works by assumption. Remove or flag-gate them before landing.
- Every script starts `--!strict`. Server authority: clients request via remotes; the server validates everything (Noise, damage, crafting, building, currency).
- Naming: modules/Instances `PascalCase`; remotes, functions, variables `camelCase`; constants `UPPER_SNAKE`; clone sources `*Template`. Remotes live in `ReplicatedStorage/Remotes`.

### Roblox traps (add as discovered, dated)
- 2026-11-13 · TeleportService doesn't work in Studio playtests: test Lobby↔Game teleports in the published game.
- 2026-11-13 · TeleportData is client-visible and spoofable: never trust it for currency/rewards (server writes rewards to DataStore).
- 2026-11-13 · DataStores in Studio need "Enable Studio Access to API Services"; use a test store name in Studio.
- 2026-11-13 · ScreenGuis: `ResetOnSpawn=false`, `ZIndexBehavior=Sibling` unless a doc says otherwise.
- 2026-11-13 · Don't name modules after Roblox services (`RunService`, `Players`…): use e.g. `RunFlowService`.
- 2026-11-13 · Input: bind actions with ContextActionService (keyboard + gamepad + touch button), never keyboard-only UserInputService paths.

## 7. UI, art, sound & content rules (user's rules, dated)
- 2026-11-13 · UI is real, editable Instances (ScreenGuis authored in Studio, in StarterGui) the user can tweak. Scripts never generate UI or re-layout it live; they only set text, values, visibility. Dynamic lists clone a designed `*Template`. Only the Close button closes a UI: no click-outside dismiss.
- 2026-11-13 · Every feature ships for PC + console + mobile from day one; no mouse- or key-only input. Touch buttons chunky, gamepad selection works.
- 2026-11-13 · Tintable art is generated white and coloured in-engine (ImageColor3 / Color); every generated image/border also ships a glow version.
- 2026-11-13 · All sounds come from one consistent palette made for this game (`docs/design/style-guide.md`); Creator Store clips are placeholders to replace, marked `-- PLACEHOLDER SFX`.
- 2026-11-13 · Looks changed or unusual? Ask the user whether they did it; never "fix" it.
- 2026-11-13 · Watch for z-fighting / coplanar faces in models and builds.
- 2026-11-13 · Commits have no AI attribution trailers.
- 2026-11-13 · AIs may start/stop playtests on their own when verification needs it; leave debug flags off when done.
- 2026-11-13 · Look: stylized low-poly, rust-orange + teal, emissive glow on tech/enemies; industrial-scrap UI; metallic/industrial sound. Details: `docs/design/style-guide.md`.

## 8. Blueprints
- `docs/blueprints/*` are LAW for what they cover. Read the relevant one before designing.
- One session-task per session. Never improvise a different data shape or module name.
- Blocked, or the blueprint seems wrong? STOP, write a proposal, ask the user.
- `docs/specs/*` are intent, not law; a big system gets a blueprint before it is built.

## 9. Contract-change protocol (`docs/contracts/`)
Owner only (DQ-Data) → bump the integer version + add a migration (never edit old migrations) → deploy + verify in the owner's Place → `PENDING: <other Place> must deploy <module> vN` → the consumer deploys and deletes the PENDING at its next bootstrap.

## 10. Doc budgets (characters, `wc -m`)
CLAUDE.md / AGENTS.md ≤12k · STATE.md ≤6k · each CONTEXT.md ≤6k · changelog entry ≤600 · `docs/systems/*` ≤300 lines.
Over budget → delete resolved items, move detail to system docs. Resolved PENDINGs are DELETED, never struck through. STATE.md stays one file. CHANGELOG keeps the newest 10 entries; when an 11th lands the oldest moves verbatim to the top of `archive/CHANGELOG-archive.md`.
