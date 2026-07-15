# KAYOS: The Night of Silence — v0.1.0

A narrative-first, dialogue-driven 2D top-down RPG in the lineage of *Planescape: Torment* and
classic *Fallout*. Two protagonists across one catastrophe: **Elorin** builds the Nullstone;
**Grakkar** activates it 300 years later. The signature **Legacy System** writes the player's
Part One choices into the world Part Two must overcome.

- **Studio:** SC Milenwall · **Franchise:** KAYOS: Pieces of Fate
- **Engine:** Godot 4.7 · GDScript · 2D top-down · 640×360 native · 32px grid · nearest-neighbour
- **Scope (v1.0):** full two-part narrative, Legacy System, 7 attributes, Mental Strain, 6 classes,
  perks, skill checks, favour economy, 15 zones, 18 UI screens, 3 endings, save/load. **No combat.**

## Repository layout

```
KAYOS-NoS-v0-1-0/
├── README.md                         ← you are here
├── docs/
│   ├── GDD.md                        ← build-ready master spec (§0–15)
│   ├── Narrative_Outline.md          ← canon novel outline & crossing points
│   ├── Design_Prompt_VerticalSlice.md← the courtyard/containment prototype brief
│   ├── Asset_Bible.xlsx              ← 129 assets, prompts, status tracker, Affinity pipeline
│   ├── Implementation_Plan.md        ← ★ the phased build plan / POA (start here)
│   └── Tooling_Setup.md              ← Godot 4.7 + MCP servers + art tooling setup
├── art/
│   ├── assets_raw/                   ← Nano Banana 2 outputs (CH-001_v3.png)
│   ├── assets_clean/                 ← Affinity-cleaned finals → import to Godot (CH-001.png)
│   └── style_anchors/                ← one approved reference per character/location
└── godot/                            ← the Godot 4.7 project (created in Phase 0)
```

## Where to start

1. Read **`docs/Implementation_Plan.md`** — the granular, phased build plan with checkpoints.
2. Read **`docs/Tooling_Setup.md`** — how to set up Godot 4.7, the MCP servers, and the art pipeline.
3. The **GDD** is canonical; the **Asset Bible** is the master content checklist.
