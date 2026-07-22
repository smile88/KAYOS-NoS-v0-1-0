# Session handoff — resume here

_Last updated: 2026-07-23. This note lives in the repo (unlike Claude's local memory, which does NOT
travel between machines) so a fresh session on another computer can pick up exactly where we left off._

## Latest session (2026-07-23) — Starfall polish pass (open items 1–4)

Worked the open-items list below, top-down. All headless-verified (`godot/tests/StarfallTest.tscn`,
new this session, 12/12; `ColdOpen3DTest` still 23/23):

1. **Feel** — `Player3D` gravity movement now eases in/out (accel 60 / friction 70), keeps air momentum
   (air_accel 16), and has **coyote-time (0.10 s) + jump-buffering (0.10 s)** so jumps fire at the edges.
   Instant velocity-snapping is gone. Starfall walk speed retuned **9 → 6.5**, run ×2.0 (13 m/s). Numbers
   are exported — final "does it feel right" is a **your-eyes** call (open the scene, press F6).
2. **Star-lake** — decided: **the Mirror is a real void, not a walkable floor.** Removed the hidden
   `MirrorFloor` collider; step off the shore and you fall through the star-field, and `Player3D`
   (`fall_limit = -25` on the Starfall scene) fishes you back onto the **last solid ground you stood on**
   and emits `fell`. The railless causeway is the one crossing — the danger is the point.
3. **Performance** — routed all the repeated **non-collidable** dressing (building windows/doors/roofs,
   crystal combs, canal water) through **MultiMesh pools** (`_deco()`/`_flush_pools()` in StarfallCity3D).
   MeshInstance3D nodes **4300 → 1047** (total nodes 5847 → 2600), 6 MultiMesh draw batches. Every
   collidable surface (terraces, stairs, building bodies, towers, island) is unchanged — still real nodes.
4. **Wired into `SceneManager`** — the Cold Open now hands off to **`threed/StarfallCity3D.tscn`** (was the
   old 2D `StarfallAcademy.tscn`). `SceneManager._place_player` now handles **Marker3D** spawns; `Player3D`
   joins group `"player"`; the Starfall scene has a `SpawnFromColdOpen` Marker3D on the rim. Full flow
   (Cold Open → Silence → title card → walkable 3D Starfall) is green.

**Still open:** (5) bake to an editable `.tscn` — still **deferred, awaiting your call**; (6) interiors /
canal shaping / real modelled art to replace primitives. See the list at the bottom.

## City-plan system (2026-07-23) — the full Starfall design bible

New: an authoritative, generated city plan. **Single source of truth: `docs/city/starfall_city.json`**
(districts, every structure with polar coords/dims/rooms/occupants, every NPC's home; geometry LOCKED to
`StarfallCity3D.gd`). Two generators read it (change JSON → re-run → all agree):
- `tools/gen_starfall_codex.py` → **`docs/Starfall_City_Codex.md`** (human-readable book of the city).
- `tools/gen_starfall_cityplan.py` → **`art/blueprints/Starfall_CityPlan.svg`** (gridded topographical
  survey in the Plate register; 50 m grid; the exemplar wedge fully plotted; Under-Terraces = the dashed
  "Other Map").

Decisions locked with the user: **~3,000 souls**, **every structure bespoke**, **foundation + one
exemplar wedge first**. Done this pass: the schema + all 9 Houses named/stubbed + **House Vael'Suran**
(the wedge flanking the Grand Processional, containing the built Open House) fully specified — 22
structures, ~301 souls, rim→Under-Terraces. Canon NPCs placed in-wedge: Talindir (apprentice scribe),
Vara (human prodigy in a canal garret), Durak Ironthought (with the Terran deep-wrights below).
**Next: author the other eight wedges (H1–H8) + the Academy island into the same JSON**, then re-run.
Run `python tools/gen_starfall_codex.py && python tools/gen_starfall_cityplan.py` to regenerate.

## Where we are

Building **Starfall**, the first big 3D zone, as a walkable greybox on the `godot/threed/` HD-2D kit
(the Cold Open — `ColdOpen3D.tscn` → Balcony3D + Scriptorium3D — is the reference implementation).

**Done this session:**
- `godot/threed/StarfallCity3D.gd` + `.tscn` — the whole caldera exterior, walkable, **built to scale
  (~900 m rim diameter)**: concentric terraces stepping DOWN ~46 m to the central star-lake "Mirror",
  9 rim observatory towers (one the dead House), crystal-comb ring, dense multi-storey habitation,
  railless causeway, Academy island with a ~110 m hero observatory (green dome + wings + moon-bridge +
  warded vault), and the golden armillary monument.
- **`docs/Scale_Reference.md`** — the units bible. **1 Godot unit = 1 metre, locked.** Check every zone
  against it. Buildings 10–26 m, doorways 2.2 m, terrace drops ~11 m, observatory ~110 m, etc.
- **`art/blueprints/Starfall_Blueprint.svg`** (gen `tools/gen_starfall_blueprint.py`) — labelled plan,
  same geometry as the greybox. **Map, doc, and world all share one geometry — change one, change all.**
- Real, working **grand staircases**: visible stepped boxes over a hidden ramp collider (Godot's
  `CharacterBody3D` can't climb stepped geometry). Headless-verified: player descends 11 m/terrace,
  stays grounded, no fall-through.
- `Player3D` gained opt-in **`gravity_enabled`**, **jump**, and hold-Shift-to-run. Zone3D gained
  additive collision helpers (`_floor_box` / `_ramp` / `_col_cyl`). **All opt-in — the Cold Open is
  unaffected** (it defaults `gravity_enabled = false`).
- Input remap: **Space = jump** now; `interact` is **F only** (Space was removed from it).
- New temp textures (basalt, canal_water, ward_glyph, comb_crystal, dome_verdigris, terrace_stone) via
  `tools/gen_3d_textures.py` → `godot/art/3d/`.
- Hero renders in `art/greybox_renders/`.

## How to run / test it

Open `godot/threed/StarfallCity3D.tscn` in Godot **4.7** (`/Applications/Godot_4.7.app`) and press **F6**
(Run Current Scene). Controls: **WASD** move · **Shift** run · **Space** jump · right-drag orbit ·
**V** first-person · **F** examine. You spawn on the rim; walk down the Grand Processional (+Z / front).

Regenerate art/map anytime: `python3 tools/gen_3d_textures.py` and `python3 tools/gen_starfall_blueprint.py`
(re-import textures with `Godot_4.7 --headless --import --path godot` if `load()` fails on new PNGs).

## Open items / next steps (pick up here)

1. ✅ **Feel tuning** (2026-07-23) — accel/friction + coyote + jump-buffer; walk 6.5 / run ×2.0. Final
   feel judgement still wants your eyes on it in-editor.
2. ✅ **Star-lake** (2026-07-23) — now a real void with last-safe respawn; causeway is the crossing.
3. ✅ **Performance** (2026-07-23) — MultiMesh pools for non-collidable dressing; meshes 4300 → 1047.
   Could go further later (MultiMesh the ~435 building *bodies* too, decoupling their collision) if load
   still feels heavy, but it's now well within budget.
4. ✅ **Wired into `SceneManager`** (2026-07-23) — Cold Open hands off to the 3D city; Marker3D spawns.
5. **WYSIWYG-editable scene (DEFERRED by user choice).** User wants to eventually open the zone in the
   editor and click/drag objects. Plan: BAKE the procedurally-generated city into a real `.tscn` — build
   it once, set every generated node's `owner` = scene root, `PackedScene.pack(root)` + `ResourceSaver.save`.
   Then it's fully editable. Caveat to warn about: a structural re-gen overwrites hand edits.
6. Building/interior variety, canal shaping, real modelled art to replace temp textures/primitives.

## Key files

| File | What |
|---|---|
| `godot/threed/StarfallCity3D.gd` / `.tscn` | the city (procedural) + its scene |
| `godot/threed/Zone3D.gd` | base kit + collision helpers |
| `godot/threed/Player3D.gd` | gravity/jump/run (opt-in) |
| `docs/Scale_Reference.md` | **the units bible** |
| `docs/Building_a_3D_Zone.md` | how the kit works |
| `art/blueprints/Starfall_Blueprint.svg` | the plan |
| `docs/Zone_Atlas.md`, `docs/KAYOS_Starfall_Map_Prompt.md` | Starfall canon |

## Nothing is broken / uncommitted after this handoff

Everything below was committed and pushed to `origin/master` (private repo
`github.com/smile88/KAYOS-NoS-v0-1-0`). `git pull` on the laptop to resume.
