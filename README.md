# KAYOS: The Night of Silence — v0.1.0

A narrative-first, dialogue-driven RPG in the lineage of *Planescape: Torment* and classic *Fallout*.
Two protagonists across one catastrophe: **Elorin** builds the Nullstone; **Grakkar** activates it 300
years later. The signature **Legacy System** writes the player's Part One choices into the world Part
Two must overcome.

- **Studio:** SC Milenwall · **Franchise:** KAYOS: Pieces of Fate
- **Engine:** Godot 4.7 · GDScript · **HD-2D isometric 3D** · true 3D models · `gl_compatibility`
- **Scale:** 1 Godot unit = 1 metre, locked — see `docs/Scale_Reference.md`
- **Scope (v1.0):** full two-part narrative, Legacy System, 7 attributes, Mental Strain, 6 classes,
  perks, skill checks, favour economy, 15 zones, 18 UI screens, 3 endings, save/load. **No combat.**

> **The project pivoted from 2D top-down to 3D on 2026-07-19** (`docs/3D_Pivot_Plan.md`). 3D is the
> mainline; the 2D Cold Open is archived and the old 2D render-target rule (960×540 native, 32px grid,
> 48×72 sprites, "never zoom out") is **retired** — it was a 2D-pixel-art constraint. Story panels stay
> 1920×1080 painterly, a deliberate register shift for visions. Scenes still under `godot/scenes/` are
> legacy until ported.

## Repository layout

```
KAYOS-NoS-v0-1-0/
├── README.md                          ← you are here
├── CLAUDE.md                          ← standing rules & conventions for agent sessions
├── docs/
│   ├── SESSION_HANDOFF.md             ← ★ where the last session stopped — start here
│   ├── GDD.md                         ← build-ready master spec (§0–15), canonical for systems
│   ├── Implementation_Plan.md         ← the phased build plan / POA
│   ├── 3D_Pivot_Plan.md               ← the 2D → HD-2D-3D pivot, phase by phase
│   ├── Building_a_3D_Zone.md          ← how the Zone3D kit works (recipe for new zones)
│   ├── Scale_Reference.md             ← ★ the units bible — 1 unit = 1 m
│   ├── Starfall_City_Codex.md         ← GENERATED book of the city
│   ├── city/                          ← ★ city source of truth: base JSON + wedges/*.json
│   ├── Narrative_Outline.md           ← canon novel outline & crossing points
│   ├── Canon_Notes.md, Zone_Atlas.md  ← story & place canon
│   ├── 3D_Asset_Bible.md              ← 3D asset spec & prompts
│   ├── Asset_Bible.xlsx               ← asset status tracker, Affinity pipeline
│   └── Tooling_Setup.md               ← Godot 4.7 + MCP servers + art tooling setup
├── godot/                             ← the Godot 4.7 project
│   ├── threed/                        ← the 3D mainline: Zone3D kit, Player3D, ColdOpen3D, StarfallCity3D
│   ├── autoload/                      ← GameState, DialogueManager, SceneManager
│   ├── data/                          ← GENERATED runtime data (starfall_city.json)
│   ├── assets/ftk/                    ← Kenney Fantasy Town Kit models
│   ├── tests/                         ← headless proof scenes
│   └── scenes/, actors/, ui/          ← legacy 2D, until ported
├── tools/                             ← Python generators (city, textures, blueprints)
└── art/
    ├── assets_raw/                    ← raw generation outputs
    ├── assets_clean/                  ← Affinity-cleaned finals → import to Godot
    ├── blueprints/                    ← GENERATED plans (Starfall_CityPlan.svg)
    ├── greybox_renders/               ← hero renders of the greybox
    └── style_anchors/                 ← one approved reference per character/location
```

## Running it

Open `godot/` in **Godot 4.7** and press F5, or run a scene directly with F6. The main scene is
`res://threed/ColdOpen3D.tscn`; the big walkable zone is `res://threed/StarfallCity3D.tscn`.

Controls: **WASD** move · **Shift** run · **Space** jump · right-drag orbit · **V** first-person ·
**F** examine.

Headless test suites (64 assertions, all green):

```bash
G=/Applications/Godot_4.7.app/Contents/MacOS/Godot
$G --headless --path godot res://tests/StarfallTest.tscn        # 19
$G --headless --path godot res://tests/ColdOpen3DTest.tscn      # 23
$G --headless --path godot res://tests/DialogueSystemsTest.tscn # 17
$G --headless --path godot res://tests/InteractionTest.tscn     #  5
```

## The Starfall city pipeline

The city has **one source of truth**, split so wedges can be authored in parallel. Edit the JSON, then
regenerate — never hand-edit the outputs.

```
docs/city/starfall_city.json  +  docs/city/wedges/*.json     ← EDIT THESE
        │
        ├── tools/build_city.py           → godot/data/starfall_city.json   (runtime data)
        ├── tools/gen_starfall_codex.py   → docs/Starfall_City_Codex.md
        └── tools/gen_starfall_cityplan.py→ art/blueprints/Starfall_CityPlan.svg
```

```bash
python3 tools/build_city.py && \
python3 tools/gen_starfall_codex.py && \
python3 tools/gen_starfall_cityplan.py
```

Current: 9 detailed wedges, 203 structures, ~2,820 souls. Map, doc, and walkable world share one
geometry — change one, change all.

## Where to start

1. **`docs/SESSION_HANDOFF.md`** — the live state and the open-items list.
2. **`docs/Implementation_Plan.md`** — the phased build plan with checkpoints.
3. **`docs/Building_a_3D_Zone.md`** + **`docs/Scale_Reference.md`** — before building any new zone.
4. The **GDD** is canonical for systems; the **Asset Bible** is the master content checklist.
