# Art Pipeline

This folder implements the Asset Bible's prescribed generation → cleanup → engine pipeline.

| Folder | Contents | Stage |
|---|---|---|
| `assets_raw/` | Raw Nano Banana 2 generations, named by asset ID (e.g. `CH-001_v3.png`). | Generated |
| `assets_clean/` | Affinity-cleaned finals, same IDs (e.g. `CH-001.png`). **These import into Godot.** | Cleaned → In Engine |
| `style_anchors/` | One approved "winning" reference image per character/location. The true art bible. | Approved |

**Rule (from the Asset Bible):** every asset draws colours only from its faction's document
palette (Noctari indigo/violet/silver · Solari gold/ivory/dawn · Orc ash/iron/rust/ember).
Generate `CH-001` (Elorin) + `PO-001` first, approve them, build the palettes from them, then
conform everything after. See `docs/Asset_Bible.xlsx` → AFFINITY PIPELINE sheet.
