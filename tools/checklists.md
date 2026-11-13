# Checklists — expanded recipes
<!-- Grep for the § you need (grep -n '^## ' tools/checklists.md); don't read whole. -->

## Reading big files cheaply
- `wc -l <file>` first. Over ~200 lines → `grep -n '<term>' <file>`, then `sed -n '<a>,<b>p' <file>` around the hit.
- Studio scripts: use MCP `grep_scripts` / `get_script_source` with a line range, not whole-place dumps.
- CHANGELOG newest 3: `grep -n '^## ' CHANGELOG.md | head -4`, then `sed -n '1,<4th−1>p' CHANGELOG.md`.
- ROADMAP: `grep -n 'DQ-<System>' docs/ROADMAP.md`. Archive: `grep -n '<term>' archive/*.md` only.

## Drift
1. In Studio: run `tools/hash_shared.luau` (MCP `execute_luau`). On disk: `powershell -ExecutionPolicy Bypass -File tools/hash_disk.ps1`.
2. Compare: Studio hash = `deployed.<Place>` = `hash` for every module → clean.
3. Mismatch → STOP feature work. Find which side changed (CHANGELOG, git log). Disk is canon: redeploy from `shared/src` unless the user confirms a Studio edit should be kept (then the owner copies it to disk, rehashes, commits).
4. Record the reconciliation in the CHANGELOG entry.

## Integration gate (any one → "Integration session needed first")
- Drift detected in either Place.
- A PENDING needs work in a Place other than the one you are in.
- A contract or shared-module change is committed but not deployed/verified in every consuming Place.
- The task spans both Places (e.g. teleport, rewards → save → lobby display).

## Deploying a shared module (DQ-Integration or the owner)
1. Confirm the Place (`get_place_info`). Edit mode, no playtest running.
2. Create/replace the ModuleScript at the manifest `deployPath` with the exact contents of `shared/src/<file>`.
3. Run `tools/hash_shared.luau`; the hash must equal manifest `hash`.
4. Set `deployed.<Place>` to that hash; delete the matching PENDING; CHANGELOG + commit.

## Editing a shared module (owner only)
1. Announce: add a PENDING "DQ-<owner> editing <module>" so no one else starts.
2. Edit `shared/src/<file>` on disk (whole file or exact diff). If it changes a contract, follow the contract-change protocol (CLAUDE.md §9).
3. `tools/hash_disk.ps1` → update manifest `hash`; deploy + verify in the owner's Place; update `deployed.<Place>`.
4. PENDING: "<other Place> must deploy <module> (hash <h>)". Land.

## Integration session agenda (after any contract change, else ~weekly)
1. Bootstrap in each Place in turn (ask the user to open it).
2. Drift check both Places; deploy pending shared modules; clear PENDINGs.
3. End-to-end test of cross-Place paths (published game for teleports): Lobby → Game → Lobby, save round-trip.
4. Update both CONTEXT.md files, STATE, CHANGELOG; commit `[Lobby+Game] ...`.

## Doc-gardening agenda (~monthly)
- `wc -m CLAUDE.md AGENTS.md STATE.md places/*/CONTEXT.md` → enforce budgets; move detail into system docs.
- Rotate CHANGELOG to 10 entries (oldest → top of `archive/CHANGELOG-archive.md`, verbatim).
- Delete resolved/stale PENDINGs; prune INDEX lines for deleted docs; check CLAUDE.md and AGENTS.md still match (`diff <(tail -n +3 CLAUDE.md) <(tail -n +3 AGENTS.md)`).
- Archive superseded STATE/CONTEXT versions only if worth keeping (`archive/<file>-<date>.md`).

## Git backup / push
- Commit at every landing: `git add -A && git commit -m "[<Place|repo>] <summary>"` (no AI trailers).
- Pushing only when the user says so. To add a remote: `git remote add origin <url>` then `git push -u origin main`.
- Studio place files are backed up by Roblox version history when published; mention unpublished Studio work in the advisory.
