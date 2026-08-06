# Art Pipeline

This folder implements the Asset Bible's prescribed generation → cleanup → engine pipeline.

| Folder | Contents | Stage |
|---|---|---|
| `assets_raw/` | Raw Nano Banana 2 generations, named by asset ID (e.g. `CH-001_v3.png`). | Generated |
| `assets_clean/` | Affinity-cleaned finals, same IDs (e.g. `CH-001.png`). **These import into Godot.** | Cleaned → In Engine |
| `style_anchors/` | One approved "winning" reference image per character/location. The true art bible. | Approved |
| `character_turnarounds/` | Multi-angle (front/back/side) character ref sets, one folder per CH-###/NA-0# ID, for Meshy Multi-Image-to-3D. See its own README. | Generated (3D input) |
| `character_models/` | Completed rigged Meshy 3D character exports (FBX + textures), one folder per character. See its own README. | Generated (3D output) |
| `environment_turnarounds/` | Rim tower / building / establishing-shot generations — often multiple independent attempts per subject, not angles. See its own README. | Generated (pick-the-best) |
| `environment_models/` | Completed Meshy 3D building/environment exports (raw geometry, pre-texture), one folder per subject. See its own README. | Generated (3D output) |
| `lore_iconography/` | Deity, artifact, and faction icon renders (Master_KeyArt_Prompts.md PART 3). See its own README. | Generated |
| `key_art/` | Illustrated location and historical-event splash art (Master_KeyArt_Prompts.md PART 2, Canon_Notes.md timeline). See its own README. | Generated |
| `reference_material/` | Third-party texture/asset-pack preview sheets kept as visual grounding — not authored, not imported. See its own README. | Reference only |
| `franchise_reference/` | Broader KAYOS-multiverse material (world maps, exotic races, franchise politics) — explicitly **not** this game's canon. See its own README. | Out-of-scope reference |

**Rule (from the Asset Bible):** every asset draws colours only from its faction's document
palette (Noctari indigo/violet/silver · Solari gold/ivory/dawn · Orc ash/iron/rust/ember).
Generate `CH-001` (Elorin) + `PO-001` first, approve them, build the palettes from them, then
conform everything after. See `docs/Asset_Bible.xlsx` → AFFINITY PIPELINE sheet.
