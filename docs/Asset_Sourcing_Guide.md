# Asset sourcing guide — what KAYOS needs, and how to judge a pack

_A shopping list for placeholder and near-final 3D assets, mapped to the Zone Atlas. Written to be
used while browsing: each section says what we already have, what's missing, and the search terms
that actually surface it._

**Hard constraints for anything you bring back** — check these before you fall in love with a pack:

| Constraint | Why |
|---|---|
| **glTF / GLB preferred** | Godot 4.7 imports it natively. FBX needs an extra converter; `.blend` needs Blender installed. OBJ loses rigs and animation. |
| **1 unit = 1 metre** | `docs/Scale_Reference.md` is locked. Packs authored at other scales are fine — we normalise on import — but check the pack states its scale somewhere. |
| **CC0 > CC-BY > anything else** | CC0 is public domain, zero obligation. CC-BY needs an attribution file we must maintain and ship. Avoid "free for personal use" and anything with a revenue cap. |
| **`gl_compatibility` renderer** | The project uses Godot's compatibility renderer. Heavy PBR, SSR, SDFGI, volumetric fog are unavailable or degraded. Prefer packs that read well on **albedo + simple normal**, not ones that need full PBR to look right. |
| **Y-up, origin at the feet/base** | Saves per-asset fixup. Kenney/KayKit/Quaternius all do this correctly. |

**Register warning.** KAYOS is Planescape/Morrowind lineage — adult, sombre, text-heavy. Most excellent
free 3D packs are **chibi/cartoon** (3-heads-tall, big eyes). They work as placeholders but they set a
tone that final art has to walk back. When judging a pack, ask *"could the final game look like this?"*
If no, it's a greybox stand-in only — fine, but label it as such.

---

## 1. Characters

**Have:** `godot/assets/characters/` — KayKit Adventurers (5, fantasy, skinned, 76 anims), Kenney Mini
(12, modern, skinned, 32 anims), Kenney Blocky (18, modern, rigid, 27 anims). All CC0.

**Missing — the roster the story actually calls for:**

- **Robed scholars / scribes** — the Academy is the whole of Part One. Talindir, Vara, the Theory Wings.
- **Commoners** in period dress — ~2,820 souls in Starfall across nine Houses.
- **Dwarves / stout folk** — the Terran deep-wrights in the Under-Terraces.
- **Guards / wardens** — containment halls, the Vault.
- **Elderly + children** — a real city needs age range or it reads as an army barracks.
- **Grakkar's era (Part Two)** — ragged, post-catastrophe survivors, labourers.

**Search terms that work:** `low poly character pack rigged CC0`, `stylized medieval villager glb`,
`fantasy townsfolk 3d model pack`, `modular character creator low poly`, `robed mage 3d rigged`.

**What matters most:** a **shared skeleton** across the pack. If every character rigs to the same
armature, one animation set drives all of them and NPCs become cheap. Packs advertising "modular" or
"same rig" are worth far more than a bigger pack of one-offs. Mixamo (free, Adobe account) can retarget
animations onto humanoid rigs if a pack ships geometry but no anims.

**What we do NOT need:** combat animations. No combat in KAYOS. Idle, walk, sit, talk/gesture, carry,
lie down, and a death/collapse pose cover the entire game.

---

## 2. Architecture — exterior, modular

**Have:** Kenney Fantasy Town Kit, 167 pieces — 63 wall, 26 roof, 13 stairs, 10 fountain, 9 road,
6 hedge, 5 fence/tree/stall, plus chimneys, watermill, windmill, carts, banners, balconies.

**The gap:** FTK is a **village** kit — timber-frame cottages. Starfall is a **grand classical academy
city**: a 110 m domed observatory, nine House towers, terraced stone, colonnades, a causeway. FTK has no
columns, no domes, no monumental arches, no grand civic facades.

**Missing:**
- **Classical / monumental** — columns, pediments, porticos, domes, grand staircases, plinths, cornices.
- **Stone city blocks** — multi-storey dense urban terraces, not detached houses.
- **Towers** — proper observatory drums, spires, astronomical structures.
- **Bridges & aqueducts** — the railless causeway, canal crossings.
- **Walls & fortification** — parapets, battlements, retaining walls for the terraces.

**Search terms:** `modular building kit low poly glb`, `classical architecture 3d kit`,
`stylized city modular pack`, `fantasy city builder assets`, `medieval town modular kitbash`,
`greek roman columns low poly`.

**Judge it by:** does it **snap to a grid**? Modular kits are worth 10× a set of pretty one-off
buildings, because the city is procedurally assembled (`StarfallCity3D.gd`). Look for a stated grid size
(1 m, 2 m, 4 m). Pieces that only work in the arrangement shown in the promo render are near-useless.

---

## 3. Interiors — **the biggest gap in the project**

**Have:** essentially nothing. One hand-built room in `StarfallCity3D.gd` (the Open House lectern room).
Every FTK building is a decorative shell with no inside.

This is why buildings feel un-enterable — **not** door size. The FTK doors are comfortably walk-through
at the current scale; there is simply nothing behind them.

**Needed, by zone:**
- **Z-07 Common Interiors** — homes, inns, shops. The Sounding-Glass inn is already named in the codex.
- **Z-04 Academy Theory Wings** — lecture halls, studies, orreries.
- **Z-05 Containment Halls** — vaults, wards, laboratory.
- **Z-15 Archives / Z-16 Talindir's Study** — the Legacy corpus. Shelves, scroll racks, reading desks.
- **Z-14 Research Facility labour floors** — Part Two industrial.

**Search terms:** `modular interior kit low poly`, `dungeon modular pack glb`, `medieval interior
furniture pack`, `library bookshelf 3d low poly`, `tavern interior assets`, `laboratory props low poly`.

**Note:** KayKit (same author as the Adventurers pack you now have) publishes **Dungeon Remastered**,
**Furniture Bits**, and **Restaurant Bits** — all CC0, all on GitHub, all matching register with the
characters already installed. That's the single highest-value direction for interiors.

---

## 4. Props & set dressing

**Have:** a handful via FTK (carts, stalls, barrels-ish, lanterns, banners).

**Needed:** books, scrolls, quills, candles, braziers, orreries/astrolabes, telescopes, crates, barrels,
sacks, rope, tools, market goods, food, pottery, tapestries, rugs, chests, beds, tables, chairs, benches,
signage.

**Search terms:** `medieval props pack low poly`, `fantasy furniture glb CC0`, `library props 3d`,
`alchemy laboratory props low poly`, `market stall goods 3d pack`.

**Priority note:** you said it yourself — a chair or book here or there can be polished later. Buy
**breadth** cheaply here; don't agonise. The exception is **hero props** the story points a camera at:
the Nullstone, the armillary monument, Talindir's desk, the Vault door.

---

## 5. Textures & materials

**Have:** 14 hand-generated placeholder PNGs in `godot/art/3d/` — `basalt`, `stone`, `terrace_stone`,
`marble_floor`, `canal_water`, `comb_crystal`, `dome_verdigris`, `ward_glyph`, `city_windows`,
`window_glow`, `star_dome`, `scriptorium_wall/floor`, `shelf_wood`. All procedurally generated by
`tools/gen_3d_textures.py`, all low quality — they exist to hold the slot.

**Needed:** proper **seamless tiling** sets for stone, marble, granite, basalt, plaster, timber, slate
roofing, cobble, sand, cloth, metal, glass.

**Search terms:** `seamless PBR texture CC0`, `tileable stone texture 4k`, `stylized hand painted
texture pack`, `trim sheet fantasy`.

**Two things to check:**
1. **Tiling scale.** This is currently a real bug in the build — the tower drums render stone blocks
   roughly **3 m across**, so one brick is taller than a person and every scale cue dies. When you grab
   a texture, note the **real-world size it represents** (e.g. "this tile = 2 m × 2 m"). We set
   `uv1_scale` from that.
2. **Stylised vs photoreal.** Photoreal 4K PBR will fight the HD-2D register *and* the
   `gl_compatibility` renderer. Hand-painted / stylised tiling textures are the better match.

**Also worth grabbing:** **trim sheets** (one texture holding many architectural mouldings/details) —
extremely efficient for modular architecture, and exactly what a procedurally-assembled city wants.

---

## 6. Ruins, decay & Part Two

Part Two is 300 years after a catastrophe. **Z-12 The Ashpile**, **Z-13 Black Crag**, **Z-14 Research
Facility** all need the ruined register — and reusing Part One's assets *as ruins* is a huge narrative
win (the player should recognise Starfall in the wreckage).

**Needed:** rubble, broken walls/columns, scorched variants, collapsed roofs, ash drifts, debris piles,
scaffolding, industrial/labour equipment.

**Search terms:** `ruins modular pack low poly`, `destroyed building 3d assets`, `rubble debris pack`,
`post apocalyptic props low poly`.

---

## 7. Nature & terrain

**Have:** 5 FTK trees, 3 rocks, 6 hedges.

**Needed:** cliff faces (the caldera is a volcanic bowl — its walls are a major visual), boulders, scree,
sparse alpine vegetation, water surfaces, ash/snow ground cover.

**Search terms:** `low poly rocks cliffs pack`, `stylized nature pack glb`, `modular cliff kit`.

**Note:** the caldera walls are currently untextured dark geometry — a good cliff kit would do more for
the establishing shot than almost anything else on this list.

---

## 8. VFX, particles & shaders

**Needed:** the Silence (the catastrophe itself), ward glyphs and magical containment, the star-lake
Mirror (a void full of stars), crystal glow, torch/lantern flame, dust motes, fog, rain.

**Search terms:** `Godot 4 shader pack`, `stylized VFX texture sheets`, `magic particle textures CC0`,
`flipbook explosion sprite sheet`.

**Note:** this is mostly **shader and particle work**, not downloadable models — I'd write these rather
than source them. What's worth sourcing is **flipbook/sprite-sheet textures** (smoke, sparks, glyphs) to
drive `GPUParticles3D`.

---

## 9. Skies & lighting

**Have:** a hand-made `star_dome.png`.

**Needed:** night skies with real star fields, dusk/dawn gradients, moon. Starfall is a night city and an
**astronomy** city — the sky is a main character.

**Search terms:** `night sky HDRI free`, `starfield skybox CC0`, `panoramic sky texture`.

**Caveat:** on `gl_compatibility`, HDRI-driven image-based lighting is limited. A good **panoramic sky
texture** on a `Sky` material will do more than a true HDRI here.

---

## 10. UI, fonts & icons

The GDD calls for **18 UI screens** and the game is dialogue-driven — text is the primary interface, so
this matters more than in most projects.

**Needed:** frames/panels/borders, buttons, scroll and parchment backgrounds, attribute and skill icons
(7 attributes, 6 classes, perks), portrait frames, dialogue-choice indicators, a Mental Strain meter.

**Search terms:** `fantasy UI kit CC0`, `RPG interface pack`, `parchment UI elements`, `RPG icon pack`.

**Fonts:** a display face for headings and a genuinely readable body face — you'll be setting long
passages. Google Fonts and the Open Font License cover this with no obligations. Test any candidate at
**your actual body size on a dark background** before committing; many characterful display faces become
unreadable at paragraph length.

---

## 11. Audio

Not 3D assets, but the same sourcing problem, and a narrative game lives or dies here.

**Needed:** ambience (night city, wind, water, crowd murmur, interior room tone), footsteps per surface,
UI clicks, page turns, door/mechanism sounds, magic/ward stings, and music — at minimum a main theme,
Starfall, the Academy, the Silence, and Part Two.

**Search terms:** `CC0 ambient loops`, `fantasy game music free license`, `footstep sound pack`.

---

## Where to look

| Source | License | Notes |
|---|---|---|
| **Kenney** (kenney.nl) | CC0 | The reference standard. Consistent, grid-aligned, GLB. Already supplying the town kit and two character packs. |
| **KayKit** (kaylousberg.com, and GitHub) | CC0 | Fantasy register, skinned rigs, embedded textures. Dungeon / Furniture / City-Builder Bits are the obvious next pulls. Downloadable straight from GitHub. |
| **Quaternius** (quaternius.com) | CC0 | Large library, but distributed via Google Drive (rate-limits on bulk download) and often **FBX/.blend only** — needs conversion. |
| **Poly Haven** | CC0 | Best-in-class HDRIs, textures, and some models. |
| **ambientCG** | CC0 | Enormous seamless PBR texture library, clearly labelled by real-world scale. |
| **OpenGameArt** | mixed | Deep but uneven; **check the license on every single item**, it varies per upload. |
| **Sketchfab** | mixed | Filter to Downloadable + CC0/CC-BY. Quality is high, consistency across a "set" is not. |
| **itch.io** | mixed | Where many indie asset authors publish first. Often the newest KayKit/Kenney releases. |
| **Godot Asset Library** | mixed | Shaders, tools, and plugins more than art. |
| **Freesound / Kevin MacLeod / Incompetech** | CC0 / CC-BY | Audio. Check attribution terms. |
| **Google Fonts** | OFL | Fonts, no obligations. |

---

## Vetting checklist

Before committing a pack to the repo, confirm:

- [ ] **License** is CC0 or CC-BY, stated in a file you can keep alongside the assets
- [ ] **glTF/GLB** available (not FBX/blend-only)
- [ ] **Modular / grid-aligned** if it's architecture — and the grid size is stated
- [ ] **Shared skeleton** if it's characters, and the animation list is non-combat-usable
- [ ] **Textures included** and, if external, in a folder that travels with the models
      _(this bit me: Kenney GLBs reference `Textures/colormap.png` relatively — copy the `.glb` without
      that folder and Godot imports them pure white)_
- [ ] **Poly count** sane — Starfall already runs ~1,000 visible meshes; hero props can be dense,
      repeated city dressing cannot
- [ ] **Register matches** — or you've consciously accepted it as greybox-only
- [ ] **Consistent within itself** — a pack whose pieces don't match each other is worse than nothing

---

## If you want a priority order

1. **Interiors kit** — the single biggest hole; buildings are shells and it blocks Z-04/05/07/14/15/16
2. **Monumental / classical architecture** — Starfall is an academy city and FTK is a village
3. **Seamless stone/marble textures at known real-world scale** — fixes the broken scale reading
4. **Cliff / terrain kit** — the caldera walls are a huge portion of every wide shot
5. **More characters** — scholars, commoners, age range
6. **Everything else** — props, VFX sheets, UI, audio
