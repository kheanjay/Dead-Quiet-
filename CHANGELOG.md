# CHANGELOG — Holdout
<!-- Event bus. NEWEST FIRST, append-only (never edit old entries). Keep the newest 10 entries; when an 11th lands, move the oldest verbatim to the top of archive/CHANGELOG-archive.md. Each entry ≤600 chars (wc -m).
Format: "## <YYYY-MM-DD> [<Place(s)|repo>] <SessionID> -- <one-line summary>", then ≤4 short bullets: what changed · files/tools · verified vs NOT verified · what the user must do.
Session ids are a running counter (B1, B2, ...); the next id is in STATE.md. -->

## 2026-11-13 [repo] B1 -- Repo + workflow scaffolding
- Constitution (CLAUDE/AGENTS.md), STATE, CHANGELOG, Lobby + Game CONTEXT, docs/ (INDEX, OWNERSHIP, ROADMAP, ADR-0001, pitch, style guide, M1 spec, contract drafts), shared/manifest.json, tools/.
- No game code; no Studio Place touched.
- Verified: doc budgets (wc -m), hash_disk.ps1 vs FNV-1a test vectors. NOT verified: hash_shared.luau in Studio.
- User: create the Places, answer the PENDINGs in STATE.md.
