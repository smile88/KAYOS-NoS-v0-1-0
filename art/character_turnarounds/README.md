# Character Turnarounds

Multi-angle reference sets (front / back / side) for feeding Meshy's **Multi-Image-to-3D**, per the
workflow note in `docs/KAYOS_ColdOpen_NanoBanana_Prompts.md`: generate 2–3 angles of the same
character with the same prompt, swap only the camera-angle sentence, and feed the set in together —
this is what fixes asymmetric/odd geometry, not the prompt wording.

This is a separate stage from `art/assets_raw/` + `art/assets_clean/` (the flat single-image-per-ID
2D portrait/UI pipeline documented in `art/README.md`). These are raw Meshy inputs, not Affinity-
cleaned finals — nothing here gets imported into Godot directly; the Meshy output (glb) does, once
generated.

Character IDs (CH-###) and archetype IDs (NA-0#) match `docs/Master_KeyArt_Prompts.md` and
`docs/KAYOS_Meshy_Prompts.md` — keep new folders in sync with those docs if the roster changes.

## Layout

```
protagonists/
  CH-001-002_elorin_voidweaver/
    CH-001_prime/
    CH-002_exile/
  CH-003-005_grakkar_the_unbound/
    CH-003_young/
    CH-004_prime/
    CH-005_elder/
  CH-006-007_talindir/
    CH-006_young/
    CH-007_aged/
supporting_cast/
  CH-008_sera/ CH-009_coil/ CH-010_vara/ CH-011_durak_ironthought/
  CH-012_seravin_hollow_water/ CH-013_corel/ CH-014_conclave_officials/
  CH-017_void_wardens/ CH-019_morga_steelheart/ CH-020_kess/
  CH-023_overseer_ilvane/ CH-025_the_archivist/ CH-028_grand_archmage_sulvaine/
npc_archetypes/
  NA-01_hooded_elf_civilian/ NA-02_robed_scholar/ NA-03_orc_laborer/
  NA-05_terran_folk/ NA-06_facility_overseer_guard/
```

Protagonists get one folder per life-stage variant (each has its own CH-### ID); supporting cast and
NPC archetypes are single-variant, so the character folder holds the angles directly.

## Filenames

`<ID>_<variant>_<angle>.png` — e.g. `CH-001_prime_front.png`, `CH-001_prime_back.png`,
`CH-001_prime_side.png`. Use `front` / `back` / `side` (add `threequarter` if a set needs a fourth
angle). Single-variant folders drop the variant segment, e.g. `CH-008_sera_front.png`.

Most characters currently only have a `front` image — add `back`/`side` into the same folder as
they're generated, same filename pattern.
