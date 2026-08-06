# Character Models

3D character exports from Meshy AI, one folder per character (CH-###) or NPC archetype (NA-0#).
This is downstream of `art/character_turnarounds/` — a turnaround set feeds Meshy, Meshy produces
a model, the model lands here.

Two kinds of content share this folder:

- **Rigged exports** (biped, FBX + textures) — kept as the Meshy export zip, delivered
  (`Character_output.fbx`, a merged-animations FBX, and diffuse/metallic/roughness textures).
  Extract only if/when actually importing into Godot; don't delete the zip after extracting.
- **Raw Text-to-3D geometry** (`.glb`, pre-rig, pre-texture) — Meshy's first-pass output before
  the auto-rig step. Multiple independent generation attempts of the same character are numbered
  `_gen1`, `_gen2`... (highest number isn't necessarily best); nothing gets deleted or culled
  automatically. Once a generation is picked, rigged, and textured, the rigged export joins it in
  the same folder.

Currently:

- `CH-002_elorin_exile/` — `Meshy_AI_Elven_Sorceress_Rigge_biped.zip` (rigged), plus two raw
  `_gen1`/`_gen2` glb attempts. The zip was identified by matching the model's source reference
  image (`Gemini_Generated_Image_2s1ohy...png`, filed as
  `character_turnarounds/.../CH-002_exile/CH-002_exile_side.png`) against the existing CH-002
  front/back turnarounds — same torn void-scholar robes, same constellation motifs, same object
  held in hand.
- All other `CH-###_*/` and `NA-0#_*/` folders — raw `_genN` glb only, matched to their prompt via
  `docs/KAYOS_Meshy_Prompts.md` (the file was named as a copy-pasted prompt snippet, not the
  character's name).
- `_uncatalogued/` — `hooded_noctari_female.glb` and `random_orc.glb`. Neither filename nor prompt
  text ties these to a specific CH-###/NA-0# entry (the closest candidate for the former is
  NA-01 hooded_elf_civilian, but it's a distinct file, not a duplicate — could be a second
  attempt at the same archetype or a genuinely separate figure). Needs a human look before filing.

**Left in Downloads, unfiled:** `Meshy_AI_Elder_Sorcerer_Rigged_biped.zip` (+ its extracted
folder) — a second rigged aged-mage model. Its diffuse texture atlas doesn't clearly match any
specific named character (Seravin Hollow-Water and the Archivist are the closest canon candidates,
both elderly Noctari, but the model is generically named "Sorcerer" not tied to either in the
filename or any reference image found nearby). Needs a human look before filing.
