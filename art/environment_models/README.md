# Environment Models

Raw Meshy Text-to-3D exports for buildings and environment pieces — the environment counterpart to
`art/character_models/`. This is downstream of `art/environment_turnarounds/`. These are pre-texture
geometry only (AI Texturing is a separate second step per `docs/KAYOS_Meshy_Prompts.md`); nothing
here is Godot-ready yet.

Same multi-generation convention as `environment_turnarounds/`: files are numbered `_gen1`, `_gen2`,
`_gen3`... in chronological order, a higher number is not necessarily better, and nothing gets
deleted or culled automatically.

## Layout

```
rim_towers/            The Nine Rim Towers (House seats), one folder per house, H0-H8 per
                        docs/Starfall_City_Codex.md's wedge IDs. H1_nyx_talar has no model yet.
  H0_vael_suran/ H2_oravelle/ H3_sabreth/ H4_ilmyra/ H5_corvane/ H6_dead_house/
  H7_duskmere/ H8_serenthil/
academy/                The Academy of Astral Harmony.
  great_observatory/            Also holds top-section, middle-section, and spare-parts sub-pieces
                                 generated alongside the full building.
  theory_wings_moonbridge/
common_buildings/       The five reusable Starfall building types (Meshy prompt library
                        "Common Starfall buildings" section). Only 2 of 5 generated so far
                        (magic_emporium, tea_house) — matched by description, not confirmed
                        against the source prompt image.
cold_open/              Astra'Thalas / Solari pieces specific to the Cold Open scene: the festival
                        balcony, the Tower of Celestial Harmony, generic Solari skyline filler.
misc_background/        Background/filler Noctari buildings with no canonical ID in the prompt
                        library — bell tower, gateway, rotunda, generic towers, etc.
```

## Filenames

`<slug>_gen<N>.glb` — e.g. `H0_vael_suran_gen1.glb`. Keep incrementing `_genN` as new attempts come
in; once a generation is picked as the winner and textured, it moves downstream (Godot import),
same as the character pipeline.

## Open items

- **House Nyx'Talar (H1)** has no model in this batch — check whether it was generated and filed
  elsewhere, or still needs generating.
- **`magic_emporium`/`tea_house`** matches were made by comparing the building's description to
  `docs/KAYOS_Meshy_Prompts.md` prompts, not by checking against a reference image — worth a quick
  visual confirmation.
