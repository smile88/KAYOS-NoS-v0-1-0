# Environment Turnarounds

Raw Nano Banana 2 / Meshy AI generations for buildings and environments — the environment
counterpart to `art/character_turnarounds/`. Per `docs/KAYOS_Meshy_Prompts.md`, structural assets
(stairs, doors, symmetry) go through Meshy's **Multi-Image-to-3D**, fed by multiple angle shots of
the *same* generation. That is not what most of this folder holds yet, though — see below.

**Important distinction from `character_turnarounds/`:** most subjects here have **multiple
independent generations of the same building**, not multiple angles of one generation. The user
runs several attempts per subject and picks the best later — nothing gets deleted or culled
automatically. Files are numbered `_gen1`, `_gen2`, `_gen3`... in chronological order; a higher
number is not necessarily better, just later.

## Layout

```
rim_towers/            The Nine Rim Towers (House seats), one folder per house, H0-H8 per
                        docs/Starfall_City_Codex.md's wedge IDs.
  H0_vael_suran/ H1_nyx_talar/ H2_oravelle/ H3_sabreth/ H4_ilmyra/
  H5_corvane/ H6_dead_house/ H7_duskmere/ H8_serenthil/
academy/                The Academy of Astral Harmony's two named buildings.
  great_observatory/ theory_wings_moonbridge/
common_buildings/       The five reusable Starfall building types (Meshy prompt library
                        "Common Starfall buildings" section).
  terraced_home/ magic_emporium/ archive_library/ canal_tier_market/ tea_house/
establishing_shots/     Wide 16:9 Meshy AI establishing renders (city, academy) — single
                        generation each so far, not per-subject folders.
```

## Filenames

`<slug>_gen<N>.png` (or `.jpg` for compressed re-exports) — e.g. `H0_vael_suran_gen1.png`,
`H0_vael_suran_gen2.png`, `H0_vael_suran_gen3.jpg`. Keep incrementing `_genN` as new attempts come
in; don't overwrite or delete earlier generations even after one is picked as the winner — once a
generation is chosen, promote it to `art/style_anchors/` (per `art/README.md`) rather than deleting
the others here.
