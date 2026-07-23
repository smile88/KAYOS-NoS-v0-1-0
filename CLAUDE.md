# KAYOS: The Night of Silence — working notes

Narrative-first, dialogue-driven RPG. Two protagonists across one catastrophe: Elorin builds the
Nullstone; Grakkar activates it 300 years later. The **Legacy System** writes Part One choices into
the world Part Two must overcome. No combat.

**Resume point: read `docs/SESSION_HANDOFF.md` first.** It is kept current by hand and says exactly
where the last session stopped and what is open. This file is the standing rules; that one is the state.

## Engine

- **Godot 4.7** — `/Applications/Godot_4.7.app/Contents/MacOS/Godot`. Project root is `godot/`.
- GDScript only. Renderer is `gl_compatibility`. Main scene: `res://threed/ColdOpen3D.tscn`.
- Autoloads: `GameState`, `DialogueManager`, `SceneManager` (in `godot/autoload/`).

**The project pivoted from 2D to 3D — 3D is mainline.** `README.md` still describes the original
2D top-down design (960×540, 32px grid, 48×72 sprites) and is stale on that point; treat `docs/3D_Pivot_Plan.md`
and `docs/Building_a_3D_Zone.md` as current. The 2D Cold Open is archived. Remaining 2D scenes under
`godot/scenes/` are legacy until ported.

## Non-negotiables

**1 Godot unit = 1 metre. Locked.** Check every new zone against `docs/Scale_Reference.md` before
building geometry — buildings 10–26 m, doorways 2.2 m, terrace drops ~11 m, the hero observatory ~110 m.
Scale errors are expensive to unwind later.

**Never hand-edit generated files.** The Starfall city has one source of truth, split for parallel
authoring, and three generated outputs:

```
docs/city/starfall_city.json     ← BASE (meta, grid, geometry, districts, 9 House stubs)   ✎ EDIT
docs/city/wedges/*.json          ← one fragment per wedge (H0–H8, ACADEMY)                 ✎ EDIT
        │
        └── tools/build_city.py  → godot/data/starfall_city.json  (assembled; the runtime reads this)
            tools/gen_starfall_codex.py    → docs/Starfall_City_Codex.md
            tools/gen_starfall_cityplan.py → art/blueprints/Starfall_CityPlan.svg
```

After changing any JSON, regenerate all three or they drift apart:

```bash
python3 tools/build_city.py && \
python3 tools/gen_starfall_codex.py && \
python3 tools/gen_starfall_cityplan.py
```

`build_city.py` run alone validates fragments and warns on dangling occupant/home cross-refs.

**Map, doc, and world share one geometry.** `StarfallCity3D.gd` geometry is locked to the blueprint and
the codex. Change one, change all — never let the SVG and the walkable scene disagree.

## Running and testing

Headless suites — all four are green (64 assertions); keep them that way:

```bash
G=/Applications/Godot_4.7.app/Contents/MacOS/Godot
$G --headless --path godot res://tests/StarfallTest.tscn       # 19 — walkable city, gravity, void respawn
$G --headless --path godot res://tests/ColdOpen3DTest.tscn     # 23 — the Cold Open reference zone
$G --headless --path godot res://tests/DialogueSystemsTest.tscn # 17 — dialogue, checks, flags
$G --headless --path godot res://tests/InteractionTest.tscn     #  5
```

In-editor: open a scene and press **F6**. Controls: **WASD** move · **Shift** run · **Space** jump ·
right-drag orbit · **V** first-person · **F** examine. (`interact` is F only — Space is jump.)

If `load()` fails on newly generated PNGs, re-import: `$G --headless --import --path godot`.

## Conventions that bite

- **Stairs need a hidden ramp collider.** `CharacterBody3D` can't climb stepped geometry — build visible
  stepped boxes over an invisible ramp (`Zone3D._ramp`). This pattern is load-bearing everywhere.
- **Non-collidable dressing goes through MultiMesh pools** (`_deco()` / `_flush_pools()` in
  `StarfallCity3D.gd`). Windows, doors, roofs, crystal combs, canal water. Anything the player can stand
  on or bump into stays a real node. Budget: under 1800 `MeshInstance3D`, asserted by the test.
- **`Player3D` extras are opt-in** — `gravity_enabled`, jump, run default off so the Cold Open is
  unaffected. Don't flip defaults; set them per-scene.
- **`Zone3D.gd` is the base kit.** New zones extend it and follow `docs/Building_a_3D_Zone.md`.

## Art pipeline

The user generates art externally (Gemini web) and does the Affinity cleanup; Claude does engine work,
import wiring, and the generator scripts (`tools/gen_3d_textures.py`, `gen_placeholders.py`). Don't
hand-author image assets — write the generator or wire up what the user supplies.
Raw → `art/assets_raw/`, cleaned → `art/assets_clean/`, 3D temp textures → `godot/art/3d/`.

## Canon

`docs/GDD.md` is canonical for systems; `docs/Narrative_Outline.md` and `docs/Canon_Notes.md` for story;
`docs/Zone_Atlas.md` for places. Locked world facts: Starfall is ~3,000 souls, ~900 m rim diameter, every
structure bespoke. The star-lake "Mirror" is a real void, not a floor — the railless causeway is the one
crossing, and the danger is the point.
