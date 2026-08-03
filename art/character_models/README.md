# Character Models

Completed rigged 3D character exports from Meshy AI (biped, FBX + textures), one folder per
character. This is downstream of `art/character_turnarounds/` — a turnaround set feeds Meshy,
Meshy produces a rigged model, the model lands here.

Each folder keeps the Meshy export zip as delivered (`Character_output.fbx`, a merged-animations
FBX, and diffuse/metallic/roughness textures) — extract only if/when actually importing into
Godot; don't delete the zip after extracting.

Currently:

- `CH-002_elorin_exile/` — Meshy_AI_Elven_Sorceress_Rigge_biped.zip. Identified by matching the
  model's source reference image (`Gemini_Generated_Image_2s1ohy...png`, filed as
  `character_turnarounds/.../CH-002_exile/CH-002_exile_side.png`) against the existing CH-002
  front/back turnarounds — same torn void-scholar robes, same constellation motifs, same object
  held in hand.

**Left in Downloads, unfiled:** `Meshy_AI_Elder_Sorcerer_Rigged_biped.zip` (+ its extracted
folder) — a second rigged aged-mage model. Its diffuse texture atlas doesn't clearly match any
specific named character (Seravin Hollow-Water and the Archivist are the closest canon candidates,
both elderly Noctari, but the model is generically named "Sorcerer" not tied to either in the
filename or any reference image found nearby). Needs a human look before filing.
