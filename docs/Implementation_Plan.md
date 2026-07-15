# KAYOS: The Night of Silence — Implementation Plan / POA

**Version:** 1.0 · **Date:** 2026-07-15 · **Owner:** SC Milenwall
**Companion docs:** `GDD.md` (canonical spec), `Asset_Bible.xlsx` (content checklist), `Tooling_Setup.md` (env).

This is the master plan of action. It is **phased**, with a **hard-stop checkpoint** at the end of
every sub-phase and phase. Nothing proceeds past a checkpoint until its exit criteria are all green.
The sequence deliberately follows the GDD's recommended build order (§15) and front-loads a
**playable vertical slice** so the whole game's feel is proven before content scales.

---

## 0. Guiding principles

1. **Systems before content.** The Legacy System, dialogue engine, checks, and Strain are built and
   test-proven on throwaway scenes before a single real zone is authored. Content is cheap to add
   onto correct systems and ruinous to retrofit onto wrong ones.
2. **Vertical slice is the gate.** Cold Open + Part One Act I (Starfall) must be fully playable and
   feel like the shipping game before the rest of Part One is built. This is checkpoint **CP-2**.
3. **Data-driven everything.** Dialogue, quests, items, attributes, perks, NPC definitions = Godot
   `Resource`/`.tres` or JSON. No hardcoded content strings in logic (GDD §13).
4. **Art runs as a parallel track.** Asset production (Nano Banana → Affinity → Godot) is a separate
   swimlane that feeds engine work; it never blocks systems programming, and placeholder art keeps
   the build moving.
5. **The editor is the level tool.** The project is structured so you can open Godot and visually
   place/resize/repaint everything — the "modern RPG Maker MV" experience (see §5).
6. **Checkpoints are real stops.** Each has objective, testable exit criteria. A failed criterion
   sends work back inside the phase, never forward.

---

## 1. What already exists (reuse audit)

| Asset (in `~/Projects`) | What it is | Verdict |
|---|---|---|
| **`KAYOS_NightOfSilence/`** | Godot 4.6 project, name-matched, ~39 lines GDScript, has imported art (Elorin/Corel/Sera/DialogueBox PNGs, Interior/Exterior scenes) | **Donor.** Harvest the imported art + `Interior.tscn`/`Player.tscn` as reference; do **not** build on its (near-empty) code. |
| **`kaos-the-last-light/`** (github: smile88) | Godot 4.6, clean autoload architecture (GameManager, EventBus, SaveSystem, DataManager, WorldState), but **turn-based combat + orbital 3D camera** | **Pattern reference only.** Its autoload/EventBus structure is a good template; its combat & camera are out of scope (our game has no combat, is 2D top-down). |
| **`godot-mcp/`** (github: Coding-Solo) | Already-cloned, already-built Godot MCP server (launch/run/capture) | **Fallback MCP.** Superseded by an in-editor server — see `Tooling_Setup.md`. |
| **`Town 1/`** | 3D RPG with KayKit models | Not applicable (3D). |
| **`Summer Engine/`** | Empty Godot starter | Ignore (name coincidence with the Summer Engine MCP vendor). |

**Conclusion:** none is a suitable foundation to build *on*. We scaffold a fresh Godot 4.7 project
(`godot/`) and harvest art + a couple of reference scenes from `KAYOS_NightOfSilence`. Godot's native
editor already provides the RPG-Maker-style visual editing you want — no third-party "RPG engine"
layer is needed (§5).

---

## 2. The agent team (parallel swimlanes)

Parallelism helps where tracks are **well-separated and low-conflict**. The build splits cleanly into
five swimlanes. These are the roles; spawn them (as Claude Code subagents) only when a phase's work
for that lane is ready and dependencies are met — most are **serialized behind the Systems lane early
on**, then genuinely parallel from Phase 2.

| Agent | Charter | Runs in parallel with | Primary phases |
|---|---|---|---|
| **`architect`** (lead) | Owns project structure, autoloads, save format, cross-system contracts, checkpoints. Integrates other lanes. Does not hand off the flag-registry contract. | — (coordinates) | 0,1,5, all CPs |
| **`systems`** | GDScript for GameState/flags, DialogueManager, check resolution, Strain, SceneManager, inventory, favour economy. | art, writing (from P2) | 1,2,4,6,7 |
| **`content`** (writing) | Authors dialogue trees, examine-text, quests as data resources against the §8 schema. Never touches engine code. | systems, art | 2,4,6,7 |
| **`art`** | Runs the Nano Banana → Affinity → Godot pipeline; produces `assets_clean/` + `style_anchors/`; updates the Asset Bible status column. | everything | 0,3, all |
| **`level`** (scene assembly) | Builds each zone scene: paints tilemaps, places NPC instances + interactables, wires triggers. Consumes art + content + systems. | — (integrates late per zone) | 2,4,6,7 |
| **`qa`** | Writes/maintains the flag-registry test harness and the Legacy read/write checkpoints; runs playthrough smoke tests each CP. | all | every CP |

**Reality check on parallelism:** in Phase 0–1 the Systems lane is the critical path and the others
have little to do but scaffold and produce art. True 4-way parallelism begins at **Phase 2** (slice),
where systems, content, art, and level assembly each have a full plate. Don't over-spawn before then.

---

## 3. Phase map (with hard-stop checkpoints)

```
Phase 0  Foundation & Tooling ........... CP-0  ┐
Phase 1  Core Systems (throwaway scenes) . CP-1 │ single-lane critical path
Phase 2  Vertical Slice (Cold Open+P1A1) . CP-2 ┘ ← THE GATE. Prove the game.
Phase 3  Art Production — P1 set .......... CP-3  (parallel track, overlaps 2 & 4)
Phase 4  Part One complete ................ CP-4
Phase 5  P1→P2 Handoff + Legacy read test . CP-5  ← proves the signature mechanic end-to-end
Phase 6  Part Two complete ................ CP-6
Phase 7  Coda + three endings ............. CP-7
Phase 8  Polish · visions · audio · build . CP-8  ← v1.0
```

---

### PHASE 0 — Foundation & Tooling
*Lane: architect + art. Goal: a runnable empty project and a working art pipeline.*

**0.1 Engine & project skeleton**
- Install/confirm **Godot 4.7 stable** (you currently have 4.6.1 — see `Tooling_Setup.md`).
- Create `godot/` project: renderer **Compatibility**; viewport **640×360**; window 1280×720;
  stretch `canvas_items` / aspect `keep` / scale `integer`; default texture filter **Nearest** (GDD §13).
- Folder convention inside `godot/`: `autoload/ scenes/ scenes/zones/ actors/ ui/ data/ data/dialogue/
  data/quests/ data/characters/ resources/ art/` (art symlinks or import-copies from `../art/assets_clean/`).
- Input Map: movement, interact, examine, menu, journal, ledger (keyboard + controller).
- Commit as the initial project (recommend `git init` at repo root — see §7 risks).

**0.2 MCP + editor tooling**
- Install the chosen Godot MCP server and verify Claude Code can read the scene tree and run the
  project (`Tooling_Setup.md`). Confirm Affinity + Nano Banana tooling per that doc.

**0.3 Art pipeline bootstrap**
- Generate **CH-001 (Elorin)** and **PO-001** first. Approve. Build the three faction document
  palettes in Affinity from them. Save to `art/style_anchors/`.
- Verify the full round-trip on ONE asset: generate → Affinity clean → export `assets_clean/CH-001.png`
  → import into Godot with Filter=Nearest → visible crisp on a test scene.

> **CP-0 (hard stop).** Exit criteria — all must be true:
> 1. Godot 4.7 project opens, runs an empty 640×360 scene with crisp integer scaling.
> 2. Godot MCP server connected; Claude Code can list the scene tree and launch the project.
> 3. One real asset has traversed the entire pipeline and renders pixel-crisp in-engine.
> 4. Three faction palettes exist in `style_anchors/`.
> 5. Repo layout committed.

---

### PHASE 1 — Core Systems (on throwaway test scenes)
*Lane: systems + architect + qa. Goal: the mechanics, provable in isolation, zero real content.*

**1.1 GameState singleton + flag registry (GDD §11)**
- Autoload `GameState`: `Dictionary` of flags + inventory + current-protagonist context. Typed
  get/set helpers; enum/int/bool support; serialize to save.
- Seed the full ~40-flag registry from §11 as known keys with defaults.

**1.2 Save/load**
- Single serialized `GameState` (flags + inventory + protagonist + scene + position). Round-trip test.

**1.3 Legacy Ledger test harness (qa)**
- A test scene that **writes** P1 flags, saves, reloads in a "P2 context," and **reads** them back —
  the isolation test the GDD calls out (§11 "write in a P1 test scene, read in a P2 test scene").

**1.4 DialogueManager (GDD §8.1 schema)**
- Loads conversation resources (`.tres`/JSON), walks nodes, evaluates `require_flag` (hide) and
  `check` (show-but-lock), applies `set_flags` and `strain` deltas, emits signals to UI.
- Build against the two sample trees in §8.2 (Funding Lie) and §8.3 (Morga's Arithmetic).

**1.5 Skill-check resolution (GDD §7.2)**
- Deterministic core (Attr + mods ≥ DC) + `uncertain` Fortune roll. Inline tag states for UI
  (passable gold / locked grey / +Fortune). Guarantee: every critical check has a non-check route.

**1.6 Mental Strain (GDD §7.3)**
- 0–100 meter, bands (Calm/Frayed/Strained/Breaking/Silence), option-gating hooks, the 100→60
  forced-scene reset. Wire Strain deltas from dialogue.

**1.7 Minimal dialogue UI**
- Dialogue box + choice buttons + portrait + Strain meter, driven by DialogueManager signals.
  Placeholder art is fine here.

> **CP-1 (hard stop).** Exit criteria:
> 1. Both §8 sample trees play start-to-finish, showing hidden/locked options correctly.
> 2. A check passes/fails deterministically and routes via `goto_fail`; an `uncertain` check varies.
> 3. Strain rises/falls, gates options, and fires the Silence reset scene.
> 4. Flags set in dialogue persist through save→load and are read back by the Ledger harness.
> 5. No hardcoded content strings in any system script.

---

### PHASE 2 — Vertical Slice ★ THE GATE
*All lanes active. Goal: Cold Open + Part One Act I (Starfall) fully playable, shipping-quality feel.*

**2.1 Player + movement + interaction (systems/level)**
- `Player.tscn` (own scene, instanced into zones), 32×48 sprite, 4-dir; `Interactable` base
  (Area2D + `@export` examine-text/dialogue ref); talk/examine/take/exit cursor states (UI-015).

**2.2 SceneManager + zone template (architect/level)**
- Scene transitions, per-zone world-state persistence, fade + title cards (UI-013).
- A reusable **Zone** scene template: TileMapLayer(s) + Y-sort + player spawn + NPC layer +
  interactable layer + Camera2D (integer zoom). This template is what makes every later zone a
  drag-and-paint job (§5).

**2.3 Reusable NPC system (systems)**
- `NPC.tscn` = base scene + `@export CharacterData` resource (sprite sheet, portrait ID, default
  dialogue). Drop into any zone, pick the character in the Inspector, position visually.

**2.4 Character creation (systems/content)** — attributes point-buy (7, GDD §7.1), class pick (3 for
Elorin), one background perk. Writes `P1_CLASS/PERK/ATTR[]`.

**2.5 Cold Open — "The Same Night" (content/level)** — Talindir on rails: movement/interaction/
dialogue tutorials + the one `COLDOPEN_HONEST` choice; the Silence sweep; title card. Zone: Astra'Thalas
balcony (EN-006/016). Uses VS-001.

**2.6 Part One Act I — Starfall (content/level/systems)**
- Zones: Academy exterior (EN-001), theory wings (EN-002), containment halls (EN-003).
- The "Funding Lie" fork (§8.2); team-assembly mini-quests (Vara/Durak/Coil); first-test blame.
- Side quests SQ-P1-01 (Vara's Name) and SQ-P1-02 (Geomancer's Terms).
- Journal (UI-009) minimal; Legacy Ledger (UI-010) showing the indigo column accumulating.

**2.7 Slice art (art)** — all **P1-priority** assets the slice needs In Engine (Asset Bible P1 set:
Elorin, Talindir, Sera, Coil, Vara + student/citizen sets, EN-001/002/003, dialogue/portrait/strain UI,
VS-001). ~33 P1 assets total.

> **CP-2 (hard stop — THE GATE).** Exit criteria:
> 1. New game → character creation → Cold Open → Starfall Act I → first real Legacy flags written,
>    playable end-to-end with **no placeholder art in the slice's critical path**.
> 2. At least two side quests complete and set consequence flags.
> 3. The Ledger screen shows real P1 deeds accumulating.
> 4. Save/load works mid-slice and restores exact state.
> 5. Runs 60fps at 640×360 integer-scaled; feels like the shipping game.
> **If CP-2 does not feel right, stop and fix feel before scaling content. This is the whole point.**

---

### PHASE 3 — Art Production, Part One set (parallel track)
*Lane: art. Overlaps Phases 2 & 4. Goal: all P2-priority (remainder of Part One) assets to In Engine.*
- Work the Asset Bible in ID order within priority; keep the style anchor attached every session.
- Budget 20–45 min Affinity cleanup per sprite (Bible's own estimate). Tilesets = trace-over method.

> **CP-3 (hard stop).** All Part One zones (EN-001..009,016) + Part One character/portrait/prop/item/UI
> assets are `In Engine`, palette-consistent, verified Nearest-filter. Asset Bible dashboard reflects it.

---

### PHASE 4 — Part One complete
*Lanes: systems/content/level. Goal: the whole of Elorin's campaign.*
- **4.1** Act II — years of construction: the bending of purpose; **THE SAFEGUARD DESIGN** (the single
  most important sequence — `P1_WARD_SCHEME`, `P1_FAILSAFE_CUT`, `P1_FLAW_*`); THE GLANCE (`P1_GLANCE_SEEN`);
  team crisis quests; SQ-P1-03/06. Build vault zone EN-008 + pylons PR-018/019 **once** (reused in P2).
- **4.2** Act III — Astra'Thalas/vault: the testimony (`P1_TESTIMONY`); the archive & warning
  (`P1_ARCHIVE_*`, `P1_WARNING`); last words to Talindir (`P1_TALINDIR_TRUTH`); Elorin's Same-Night
  vision shell (authored, content deferred to Coda).
- **4.3** Interlude — "The Fading": hand the archive to Talindir; the 300-year montage.
- **4.4** Remaining side quests to the 3–5-per-zone target; full examine-text pass.

> **CP-4 (hard stop).** All Part One + Interlude playable end-to-end. **Every §11.1 P1 flag is written
> by some reachable choice** (audit table). A full Part One playthrough saves a complete flag set.

---

### PHASE 5 — Part One→Two Handoff + Legacy read test ★ signature mechanic
*Lanes: architect/systems/qa. Goal: prove the Legacy System across the part boundary for real.*
- Implement the P1→P2 transition preserving `GameState` (never cleared).
- **Channel A vault generator (GDD §5.1):** assemble EN-008's defenses at P2-Act-III load from
  `P1_WARD_SCHEME`/`P1_FAILSAFE_CUT`/`P1_FLAW_*`/`P1_TESTIMONY`. Build the generation table as data.
- **Channel B/C/D/E hooks:** document corpus findability from `P1_ARCHIVE_*`/`P1_WARNING`; descendant/
  institution flags; safeguard-truth computation; Coda tally inputs.
- qa: automated matrix test — feed representative P1 flag sets, assert the correct P2 vault + document
  availability + reachable endings.

> **CP-5 (hard stop).** From three distinct saved Part One playthroughs, Part Two Act III generates
> three visibly different vaults and document sets, each traceable to the exact P1 choice. The Ledger
> shows rust echoes linking back to indigo deeds.

---

### PHASE 6 — Part Two complete
*Lanes: all. Goal: Grakkar's campaign.*
- **6.1** Act I — Ashpile: slavery-by-routine; theft of literacy (`P2_LITERACY`, SQ-P2-01); **THE READER**
  crossing (reads the player's own P1 archive text); Black Crag (`P2_BLACKCRAG_ROLE`, `P2_MORGA_ALIVE`).
- **6.2** Act II — the Long Game: infiltration; Kess (SQ-P2-02); **Morga's Arithmetic** (`P2_ARITHMETIC`,
  §8.3); discovering/deducing the flaw (the deepest Legacy fork); Ilvane (SQ-P2-04); `P2_HEEDS_ELORIN`.
- **6.3** Act III — THE SAME NIGHT (Grakkar's half): the vault the player built (Channel A);
  `P2_WARNING_SENT`/`P2_TOWER_CLEARED`/`P2_FINAL_MERCY`/`P2_NIGHT_TONE`; the lights go out from inside.
- **6.4** Part Two art set to In Engine (CP-3-equivalent for P3-priority assets) + side quests + examine.

> **CP-6 (hard stop).** Full Part Two playable from a real Part One save. Every §11.2 flag written by a
> reachable choice. The Glance and The Reader mirror their Part One halves exactly.

---

### PHASE 7 — Coda + three endings
*Lanes: content/systems.*
- Talindir at Lunaris (EN-014): the chronicle = a tour of cumulative flags as desk documents.
- Ending resolution logic exactly per GDD §9.4 (priority order). The three endings (VS-008/009/010).
- Deliver Elorin's Same-Night vision with content now filled by Part Two's outcome (crossing closes).

> **CP-7 (hard stop).** All three endings reachable via the documented flag conditions; a full
> two-part playthrough resolves to the correct ending and tallies the chronicle faithfully.

---

### PHASE 8 — Polish · visions · audio · release build
*Lanes: all.*
- Vision-space set-pieces (EN-015, VS-002..005), UI-017 overlay; notification chips (UI-018);
  title/menu (UI-011/012); save/load cards (UI-014); P4-priority assets; placeholder audio pass;
  performance + web-export check; full continuity pass across the three Crossing Points.

> **CP-8 (hard stop = v1.0).** Cold-boot to credits on multiple divergent runs with no blocking bugs;
> all 129 assets `In Engine`; save/load stable; ships a web + desktop build.

---

## 4. Cross-cutting workstreams (run continuously)

- **Flag-coverage audit** (qa): a living table asserting every §11 flag has a writer and a reader.
- **Asset Bible sync** (art): the xlsx status column is the single source of truth for art progress.
- **Canon fidelity** (content): every scene checked against `Narrative_Outline.md` + GDD §4; the three
  Crossing Points kept airtight (Outline §6).
- **Save-compat** (architect): once real playthroughs exist, avoid breaking the save format; version it.

---

## 5. The "modern RPG Maker MV" setup (visual editing in Godot)

You do **not** need a third-party RPG framework. Godot 4.7's native editor gives you the visual,
drag-resize-paint workflow you want, provided the project is structured for it. The setup:

- **Environments = TileMapLayer nodes** painted with the 32px faction tilesets. You paint maps
  directly on the canvas, exactly like an RPG Maker map — draw terrain, walls, decoration layers,
  with a collision layer and Y-sort for depth. Resize/repaint any zone visually, live.
- **Everything is a scene you drag in.** Player, each NPC, each interactable, each prop is its own
  scene. Open a zone, drag an `NPC.tscn` from the FileSystem dock onto the map, and in the **Inspector**
  pick which character (`@export CharacterData`), set its patrol/dialogue — all visual, no code.
- **`@export` + `@tool` for inspector editing.** Interactables expose examine-text, dialogue resource,
  and trigger conditions as Inspector fields. `@tool` scripts let custom nodes preview in-editor.
- **Sprites & sizes are handbook-editable.** Select any Sprite2D/AnimatedSprite2D and change texture,
  region, position, scale, z-index in the Inspector and by dragging handles. 32px grid snap on.
- **Reusable data resources** (`CharacterData`, `DialogueTree`, `QuestData`, `ItemData`) are edited in
  the Inspector like RPG Maker's database tabs — no text files needed once the resource types exist.
- **Optional quality-of-life addons** (evaluate in Phase 2, don't pre-adopt): a tilemap/auto-tile
  helper, and — only if sprite-sheet animation friction bites in Phase 6 — Aseprite/LibreSprite for
  walk cycles (the Asset Bible already flags this). Godot's own AnimatedSprite2D + SpriteFrames covers
  the 4-direction walk cycles natively.
- **The MCP layer** lets Claude Code build/modify these scenes for you and run them so you can watch —
  but because `.tscn`/`.tres` are text, scenes can also be authored directly. See `Tooling_Setup.md`.

**Net:** open `godot/`, paint a map, drag in characters and props, tweak sizes/positions in the
Inspector, hit play. That is the RPG-Maker-MV-grade experience — in Godot 4.7.

---

## 6. Milestone summary (for tracking)

| CP | Deliverable | Proves |
|---|---|---|
| CP-0 | Runnable project + art pipeline + MCP | Tooling works |
| CP-1 | Core systems on test scenes | Mechanics correct in isolation |
| **CP-2** | **Playable vertical slice** | **The game is fun & feels right** |
| CP-3 | Part One art In Engine | Art pipeline scales |
| CP-4 | Part One complete | Half the game ships-shaped |
| CP-5 | Legacy read across parts | The signature mechanic works end-to-end |
| CP-6 | Part Two complete | Full campaign playable |
| CP-7 | Coda + endings | The game concludes correctly |
| CP-8 | v1.0 build | Done |

---

## 7. Risks & open decisions

- **Engine version:** GDD targets 4.7; installed is 4.6.1. Upgrade to 4.7 stable before Phase 0.2
  (existing donor projects are 4.6 — 4.7 opens them with a one-way upgrade; keep donors untouched,
  copy art out).
- **Godot MCP compatibility with 4.7** must be verified (Funplay was tested on 4.6.3). Fallback: the
  already-built Coding-Solo `godot-mcp`, or direct `.tscn` authoring.
- **Nano Banana 2 is a paid API** (the consumer Gemini Pro plan does not cover API image gen). Budget
  ~$30–65 for the full 129-asset bible at heavy iteration. Free fallback: AI Studio (Nano Banana 1,
  500/day, manual) or Hugging Face image spaces. Decision pending — see `Tooling_Setup.md`.
- **Version control:** repo is not yet a git repo. Recommend `git init` at CP-0 and commit per
  checkpoint; the save format should be versioned once real playthroughs exist.
- **Scope discipline:** no combat in v1.0 (GDD §7.7); resist adding it. Grakkar-first NG+, VA, full
  score, localization are all post-v1.0.
```
