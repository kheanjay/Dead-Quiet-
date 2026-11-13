# ADR-0001 — Hybrid canon: disk for knowledge, Studio for Place-local code

- **Status:** accepted · **Date:** 2026-11-13 · **Session:** B1

## Context
Holdout is built by several AI chats (Claude, GPT/Codex, others) plus the user, across two Roblox Places (Lobby, Game). Chats have no shared memory and limited reading budgets. Roblox Studio holds live scripts inside place files, which git cannot diff directly, and we are not using a file-sync tool (e.g. Rojo) for now. Some code (save schema, teleport payload) must be identical in both Places, and silent divergence would corrupt saves or break teleports.

## Decision
- **The repo (disk) is canon for:** knowledge (constitution, STATE, CONTEXT, system docs, blueprints, decisions), cross-Place contracts (`docs/contracts/`), and code shared by 2+ Places (`shared/src/`, tracked in `shared/manifest.json` with hashes).
- **Roblox Studio is canon for:** Place-local runtime code, authored UI, maps, models — everything that only one Place uses.
- **Git is the ledger:** every landing commits docs + shared code, with a CHANGELOG entry saying what changed in Studio.
- Shared code is deployed from disk into `ReplicatedStorage/Shared/` in each Place; a hash check at every bootstrap detects drift.

## Why
- Docs and contracts on disk can be read by any AI cold, grepped cheaply, and versioned.
- Keeping Place-local code in Studio avoids a sync toolchain and lets the user tweak scripts and UI directly in the editor.
- Only shared code needs strict sync, so only shared code pays the cost of hashing and manifests.

## Consequences
- Place-local code has no git history: CONTEXT.md and system docs must say where code lives and how it works; the user should keep Studio place versions (auto-saved by Roblox when published).
- A chat must never edit shared modules directly in Studio: edit `shared/src`, rehash, deploy, update the manifest.
- If we later adopt Rojo, write ADR-0002 superseding this one.
