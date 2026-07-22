# Session handoff — resume here

_Last updated: 2026-07-22. This note lives in the repo (unlike Claude's local memory, which does NOT
travel between machines) so a fresh session on another computer can pick up exactly where we left off._

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

1. **Feel tuning** — walk speed (currently 9), run multiplier (1.9), jump (8), camera distance.
2. **Star-lake** is a walkable placeholder floor, not true water/void — decide the real behaviour.
3. **Performance** — the scene spawns a few thousand nodes; first load takes a few seconds. Optimise if
   it feels heavy (fewer/merged buildings, MultiMesh for non-interactive massing, etc.).
4. **Wire into `SceneManager`** so the zone is reachable in-flow (not yet; not the project main scene).
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
