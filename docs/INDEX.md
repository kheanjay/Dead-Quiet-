# INDEX — every doc, one line each
<!-- Open only what the task needs. Register every new doc here the session it is created; delete lines for deleted docs. -->

## Root
- `CLAUDE.md` — constitution: rules + rituals (Claude). Read first.
- `AGENTS.md` — same constitution for non-Claude AIs.
- `STATE.md` — current snapshot + open PENDINGs.
- `CHANGELOG.md` — newest-first event bus; read only the newest 3 at bootstrap.

## places/
- `places/Game/CONTEXT.md` — Game Place: architecture, where things live, entry paths, hazards.
- `places/Lobby/CONTEXT.md` — Lobby Place: same, for the hub/shop/squad Place.

## docs/
- `docs/OWNERSHIP.md` — System | Owner chat | Home Place | Canon location.
- `docs/ROADMAP.md` — feature status board (grep, don't read whole).

## docs/design/
- `docs/design/pitch.md` — pitch, core loop, twist (Noise + Salvage), run structure, inspirations.
- `docs/design/style-guide.md` — art, UI, sound palette, colour tokens.

## docs/decisions/
- `docs/decisions/ADR-0001-hybrid-canon.md` — disk canon for knowledge/contracts/shared code; Studio canon for Place-local code.

## docs/contracts/
- `docs/contracts/save-schema.md` — player save (meta-progression); v0 DRAFT.
- `docs/contracts/teleport-payload.md` — Lobby↔Game teleport data; v0 DRAFT.

## docs/specs/
- `docs/specs/M1-playable-night.md` — M1 scope, acceptance criteria, session plan.

## docs/blueprints/ · docs/systems/ · docs/proposals/
- (empty) — blueprints are LAW for big systems; system docs are created when a system is built; proposals are from non-owners.

## shared/ · tools/ · archive/
- `shared/manifest.json` — shared module hashes + deployed hash per Place (drift check).
- `tools/checklists.md` — recipes: big files, drift, Integration gate, deploy/edit shared, agendas, git.
- `tools/hash_shared.luau` — run in Studio: hashes `ReplicatedStorage/Shared` modules.
- `tools/hash_disk.ps1` — hashes `shared/src` files on disk (same algorithm).
- `archive/CHANGELOG-archive.md` — rotated changelog entries. NEVER read whole.
