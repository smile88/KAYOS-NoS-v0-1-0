# KAYOS: The Night of Silence — 3D Asset Bible (HD-2D → true 3D)

**Status:** master 3D-asset catalogue for the post-pivot build (billboards retired 2026-07-19; the game
is now low-poly 3D models — see `Building_a_3D_Zone.md`). This is the 3D companion to `Asset_Bible.xlsx`:
it re-specifies the canon assets (GDD §15 Content Manifest) as **3D models** and adds the categories a
3D world needs that a 2D one didn't — modular architecture, furniture, flora, terrain, skyboxes, VFX.

**ID scheme (unchanged from the GDD):** `CH-###` characters · `EN-###` environments/zones · `PR-###`
props · `PO-###` portraits (still 2D, for dialogue) · `VS-###` story panels (still painterly 2D) ·
`IT-###` items · `UI-###` interface · `FN-###` fonts. New 3D-only kits use suffixes: `-K` = modular
kit, `-F` = flora set, `-T` = terrain/material set. Where an asset already exists as a placeholder in
`godot/threed/`, the **Build** column names it.

**Status column:** `PLACEHOLDER` = primitive stand-in exists in engine · `SPEC` = designed here, not
modelled · `TODO` = named, needs a spec.

---

## 0. THE 3D STYLE BIBLE (read before modelling anything)

**Register:** between **Daggerfall and Morrowind** — chunky low-poly geometry, flat-to-lightly-textured
surfaces, honest hard edges, readable silhouettes over detail. Nearest-filtered textures. No PBR gloss,
no normal-map fussiness. Lighting does the atmosphere; models stay simple. Poly budget is a *look*, not
just a limit — keep it visibly faceted.

**Scale:** 1 Godot unit = 1 metre. Ground = XZ plane, Y up, +Z toward the default camera. An adult
elf/human model ≈ **2.1 m tall** (matches the old `pixel_size 0.03` billboard height); orc ≈ 2.3 m and
broader. Doors ≈ 2.4 m. One storey ≈ 3.5 m.

**Per-culture material language (the most important table in this doc — every zone and prop inherits it):**

| Culture / faction | Geometry | Palette | Materials | Light |
|---|---|---|---|---|
| **Noctari** (night elves — Starfall, Umbraveil) | slender, vertical, astronomical; domes, thin spires, ring-forms | deep indigo-black, silver-white, cold star-blue; **antique gold used sparingly** | dark basalt & slate, silvered metal, **starlight crystal** (the "crystal combs"), dark polished wood | cool, low, pin-point; light *measured*, never wasted |
| **Solari** (sun elves — Astra'Thalas) | broad, radiant, gilded; sun-discs, great gates, terraces | white marble, antique & bright gold, warm ivory | white/veined marble, gold leaf, sun-mosaic tesserae, honey-lacquer | warm, high, generous, gold — the Song's glow |
| **Orc / arcano-industrial** (Ashpile, facility, Black Crag) | heavy, riveted, functional; slag, scaffolds, furnaces | iron-grey, rust, ash, ember-orange | rough iron, riveted plate, slag brick, coal, worn timber, chain | harsh work-lamps, furnace glow, cold slag-plain grey |
| **Terran** (earth-folk — undercroft, Deep Ways) | monolithic, geomantic, carved-stone; low and load-bearing | ochre, umber, granite grey, deep green vein | dressed stone, raw ore, geomantic glyph-inlay (dim green-gold) | dim, mineral, glow-stone |
| **Umbraveil** (Noctari, but its own thing) | terraced, open-archwayed (**no doors**), light-channelled | twilight blue-violet, silver, **rationed warm amber** | twilight stone, crystal light-farm blades, amber light-conduits | the two-hour gold wedge; amber "lantern rivers" flowing downhill |
| **The Silence / Age of Chaos** (post-event) | same geometry, drained | colour bleeds to grey; gold goes dead | as above but unlit, ash-filmed | the *absence* of the Song — flat, sourceless, cold |

**The theology behind the two elven cultures** (canon — see `Canon_Notes.md`): the **Solari** worship
**Solara**, Weaver of Light (the gold, the Song, ordered time — their iconography is sun-discs and the
first stars); the **Noctari** are aligned with **Umbrion**, Weaver of Shadow (void, dream, the
Dreamweave — their iconography is star-crystal, the void-as-presence). Reality is the **Elder Song**;
magic is manipulating it; the Night of Silence *silences the Song*. Let Solari assets glow with the Song
and Noctari assets hold the void.

**The three eras a model may need to exist in:** Age of Order (lush, lit), the Night itself (draining —
the Song going out), the Age of Chaos/Renewal (347 AR — ruined; only for the *other* game). Default to
Age of Order.

---

## 1. CHARACTERS — hero & named (3D models, rigged)

Real characters need modelling + rigging + a small non-combat animation set (idle, walk, sit/write,
gesture, the Silence reactions). Until then the primitive `CharacterModel3D` (hooded figure, `robe_color`)
stands in for all of them. Portraits (PO-###) stay 2D for the dialogue box.

| ID | Name | Race / role | 3D model notes | Part | Status |
|---|---|---|---|---|---|
| CH-001 | **Elorin Voidweaver** (prime) | Noctari archmage | slender, reserved; dark void-scholar robes, silver trim, a faint void-black Aether Ring; the indigo palette. Signature: stillness. | P1 | SPEC |
| CH-002 | **Elorin** (aged/exile) | Noctari | same silhouette, stooped, weathered; travel cloak; carries the chalk map (IT-003 nbr). | P1 A3 / Coda vision | SPEC |
| CH-003 | **Grakkar** (young slave) | orc | 2.3 m, lean-not-yet-broad; iron collar (IT), ash-grey skin, laborer rags; barefoot. | P2 A1 | SPEC |
| CH-004 | **Grakkar** (prime) | orc | broad, scarred, deliberate; facility laborer garb over hidden scholar's discipline; collar-scar. | P2 A2 | SPEC |
| CH-005 | **Grakkar** (elder) | orc | grey, massive, weary-patient; the hand that turns the key. | P2 A3 | SPEC |
| CH-006 | **Talindir** (young) | elven scribe | earnest, plain scribe's robes, ink-stained; the satchel (PR-008). | Interlude | SPEC |
| CH-007 | **Talindir** (aged) | elven scribe | ancient, hollowed, grey; the ledger always near. **PLACEHOLDER exists** — player figure, grey-blue robe. | Cold Open / Coda | PLACEHOLDER (`CharacterModel3D`) |
| CH-008 | **Sera** | Solari structural enchantress | gold palette (foreign in Noctari Starfall); precise, guarded. | P1 | SPEC |
| CH-009 | **Coil** | Noctari theorist | young, anxious, eager; robes a size too formal. | P1 | SPEC |
| CH-010 | **Vara** | human prodigy | plain, proud, tired; no elven finery — the point. | P1 | SPEC |
| CH-011 | **Durak Ironthought** | Terran geomancer | short, granite-broad, stone-inlaid vestments; deliberate. | P1 | SPEC |
| CH-012 | **Seravin Hollow-Water** | Noctari elder (mentor) | Umbraveil twilight robes, amber-lantern warmth; memory-scene softness. | P1 memory | SPEC |
| CH-013 | **Corel** | Noctari archmagister | tired authority; layered administrator's robes; the weight of compromise. | P1 | SPEC |
| CH-014 | **Conclave officials** | Noctari/Solari | **faceless by design** — identical masked/hooded formal robes, gold sigils; a *set*, not individuals. | P1 | SPEC |
| CH-017 | **Void Wardens** | elven vault guard | uniform, silent, ward-marked armour; present in BOTH parts 300 yrs apart (same model). | P1 A3 / P2 A3 | SPEC |
| CH-019 | **Morga Steelheart** | orc elder | stout, grey-braided, steady; the conscience — warm eyes, hard jaw. | P2 | SPEC |
| CH-020 | **Kess** | young orc courier | small, quick, a smile over fear; light rags, courier satchel. | P2 | SPEC |
| CH-023 | **Overseer Ilvane** | elven security officer | crisp facility uniform, ward-baton; sincere, unsettlingly calm. | P2 | SPEC |
| CH-025 | **The Archivist** | ancient elf | impossibly old, robed, part of the Archive's furniture; never asks what he keeps. | P2 | SPEC |
| CH-027 | **Astra'Thalas citizen** | Solari/mixed | the Cold-Open festival crowd base; robed, hooded, varied robe colours. **PLACEHOLDER exists.** | Cold Open | PLACEHOLDER (`CharacterModel3D`) |
| CH-028 | **Grand Archmage Sulvaine** | Solari | *(add to bible)* the aged celebrant on the Tower at the apex; gold ceremonial regalia, arms raised. | Cold Open (distant) | TODO |

## 2. NPC & crowd archetypes (shared low-poly models, tinted/kitted)

Not every body needs a unique model. Build **archetype models** reused with material/kit swaps
(`robe_color`, headwear, tool), the way `CharacterModel3D` already tints the crowd.

| ID | Archetype | Reused for | Notes |
|---|---|---|---|
| NA-01 | **Hooded elf civilian** | Astra'Thalas crowd, Starfall citizens | the current `CharacterModel3D`; colour + small kit (mask, cup, staff) variants |
| NA-02 | **Robed scholar** | Academy students, scribes, Conclave clerks (the 778) | add a book/scroll prop; Noctari indigo vs Solari gold |
| NA-03 | **Orc laborer** | Ashpile, facility floors, Black Crag | collar, rags, tool (pick, hod, chain); ash palette |
| NA-04 | **Void Warden** | vault guard (both parts) | uniform + ward-baton; identical, deliberately |
| NA-05 | **Terran folk** | undercroft, Deep Ways | stone-broad body, geomantic inlay |
| NA-06 | **Facility overseer/guard** | P2 facility | uniform + baton; Ilvane is the hero version |

*(No monsters — there is no combat. "Creatures" in this game are ambient only: see §6 flora/fauna dressing.)*

---

## 3. ARCHITECTURE — modular building kits (`-K`)

Zones are procedural (GDD §10 / `Zone3D`), so architecture ships as **modular kits**: wall/floor/roof/
column/arch/stair/rail modules per culture, snapped on a grid, textured from §0. Build the kit once,
compose every building.

| ID | Kit | Culture | Modules | Used by (EN) |
|---|---|---|---|---|
| ARC-NOC-K | **Noctari observatory kit** | Noctari | domed observatory towers, thin spires, ring-terraces, star-crystal combs, moon-bridge arcs, dark-basalt walls, silvered rails | EN-001/002/003/004/005, EN-013 |
| ARC-SOL-K | **Solari radiant kit** | Solari | white-marble columns & terraces, great gilded gates, sun-disc pediments, balustrades, sun-mosaic floor tiles, the balcony parapet | EN-006/007, Cold Open (**parts exist**) |
| ARC-TOW-K | **Tower of Celestial Harmony kit** | Solari (hero) | the tapered spire, tiered ceremonial galleries, the lit apex, ward-floor rings, ceremonial doors | EN-007 |
| ARC-VLT-K | **Nullstone vault kit** | Noctari-arcane (hero) | the dais, three ward-pylon schemes (**PR-018a/b/c** — Lattice/Orbit/Seal), ward-floor glyph rings, blast doors | EN-008 |
| ARC-IND-K | **Arcano-industrial kit** | orc/industrial | furnaces, ore-lifts, scaffolds, riveted plate walls, chain-hoists, slag-brick, catwalks, bunk-shacks | EN-010/012 |
| ARC-TER-K | **Terran undercroft kit** | Terran | carved-stone halls, geomantic glyph-inlay, low vaulted ceilings, glow-stone lamps, the great mountain gate | EN-012 undercroft, Deep Ways |
| ARC-UMB-K | **Umbraveil terrace kit** | Umbraveil | **door-less** open archways, terraced dwellings, crystal light-farm blade-arrays, amber light-conduits, valley-floor great halls | EN-009 |
| ARC-CODA-K | **Lunaris exile kit** | Noctari (spare) | a small stone study, a single great window on the sea, document chests, shelving | EN-014 (**scriptorium parts exist**) |

---

## 4. FURNITURE & fixtures

Reusable low-poly furniture, kitted per culture (wood tone, metal, form). **Several exist as
`PropModels3D` placeholders already** (built for the Cold Open scriptorium).

| ID | Item | Cultures | Build |
|---|---|---|---|
| FUR-01 | **Desk / writing table** | all (scribe register) | PLACEHOLDER (`PropModels3D "desk"`) |
| FUR-02 | **Scroll rack** (with scrolls) | Noctari/archive | PLACEHOLDER (`"scroll_rack"`) |
| FUR-03 | **Bookshelf / stacks** | Noctari/archive | PLACEHOLDER (`"bookshelf"`) |
| FUR-04 | **Cabinet / locked cabinet** | Noctari (indigo lacquer) | PLACEHOLDER (`"cabinet"`) |
| FUR-05 | **Document chest** | all | PLACEHOLDER (`"chest"`) |
| FUR-06 | **Roster / notice board** | all | PLACEHOLDER (`"roster"`) |
| FUR-07 | **Chair / stool / bench** | all | TODO |
| FUR-08 | **Lectern / glyph-board** | Noctari academy | TODO (theory wings) |
| FUR-09 | **Containment rig / lab bench** | arcane | TODO (containment halls) |
| FUR-10 | **The schematic table** (PR-010 host) | arcane hero | TODO |
| FUR-11 | **Hearth / brazier / sun-brazier** | Solari & common | TODO |
| FUR-12 | **Bunk / pallet / collar-station** | orc camp | TODO (Ashpile) |
| FUR-13 | **Furnace / ore-lift controls** | industrial | TODO (facility) |
| FUR-14 | **Market stall / inn table** | Starfall streets | TODO |
| FUR-15 | **Ward-gate** (Archive) | arcane | TODO |

## 5. PROPS & objects (interactables, hero items, dressing)

Canon PR-### props re-cut as 3D models. Several Cold-Open props exist as `PropModels3D` placeholders.

| ID | Prop | Notes / Build | Part |
|---|---|---|---|
| PR-001/002/003 | **The Nullstone** (proto / sealed / active) | HERO. Carved from **void-touched obsidian** around **the heart of a dying star**, powered by the sacrificed potential of 100 mages (canon; project codename *Aethelburg*). A dark stone that **drinks light**; the active form drains colour outward. Never speaks; the gravity of the game. | P1/P2 |
| PR-024 | **Echo Stones** | Smaller Nullstone fragments seeded across elven lands that extend the suppression — the Night is a *network* activation. Grakkar's are **modified** to circumvent Elorin's safeguards. Dressing/interactable in P2 + the Silence. | P2 |
| PR-008 | **The ledger / scribe papers / letter / broadsheet / roster / seal-kit / Volume the First** | scribe-set. **PLACEHOLDERS exist** (`"book"`, `"papers"`, `"satchel"`, `"seal"`, `"roster"`). | Cold Open/Coda |
| PR-009 | **Elorin's journal** (hero item, IT-016) | HERO. Indigo-bound, void-sealed; THE READER's payload. | P1→P2 |
| PR-010 | **The safeguard schematic** | HERO. A drafting sheet / the schematic table's plate; the buried flaw lives here. | P1 A2 |
| PR-007 | **Scroll racks / library stacks** | see FUR-02/03. | P1/P2 archive |
| PR-014 | **Collar, chain, roll-call post** | orc-camp dressing; the iron collar fragment is an item. | P2 A1 |
| PR-015/016 | **Academy dressing** (notice board, fountain, moon-bridge, market, canal bridges) | Starfall street & academy props. | P1 |
| PR-017 | **Sun-braziers, gilded gates, star-lamps, ceremonial doors** | Solari capital & Tower dressing. **star-lamp glow exists.** | P1 A3/P2 A3/Cold Open |
| PR-018a/b/c | **Ward pylons** — Lattice / Orbit / Seal | HERO, Legacy-critical (§5.1). Built once, designed in P1, defeated in P2. | P1/P2 A3 |
| PR-019 | **The vault dais** | HERO. Where the Stone sits / is activated. | P1/P2 A3 |
| PR-020/021 | **Festival & common dressing** (banner, telescope, sun-mask, wine cups, garlands, chest, cabinet) | **PLACEHOLDERS exist** (`"banner"`, `"telescope"`, `"mask"`, `"cups"`, `"chest"`, `"cabinet"`). | Cold Open |
| PR-022 | **Lunaris study dressing** | the window on the sea, chests, the sealing wax. | Coda |
| PR-023 | **Stairs (room-to-room)** | **PLACEHOLDER exists** (Zone3D `_build_stair`). | Cold Open |

## 6. FLORA & natural dressing (`-F`)

New for 3D — the 2D bible had backdrops, not placeable plants. Low-poly, per-biome.

| ID | Set | Contents | Zones |
|---|---|---|---|
| FLO-UMB-F | **Umbraveil shadow-gardens** | twilight ferns, moon-moss, pale night-blooms, hanging amber-lit vines, terraced planters | EN-009 |
| FLO-STA-F | **Starfall / caldera** | hardy alpine scrub, terrace-garden hedges, water-reeds at the star-lake shore, lichen on basalt | EN-001/004 |
| FLO-SOL-F | **Astra'Thalas** | sun-gardens, gilded topiary, festival garlands & flowers, palm-analogues | EN-006 |
| FLO-ASH-F | **Ashpile / slag-plain** | dead scrub, ash-grass, slag crystals, no living trees — the point | EN-010/011 |
| FLO-TER-F | **Terran / undercroft** | cave lichen, glow-fungus, geomantic crystal growths, root intrusions | EN-012 undercroft |
| FAU-01 | **Ambient fauna** (no combat) | night-birds, moths at lamps, fish-shadows in the star-lake, camp rats — atmosphere only | various |

## 7. TERRAIN & material sets (`-T`)

Ground/rock/water modules + the tiling textures (`tools/gen_3d_textures.py` — some exist).

| ID | Set | Notes |
|---|---|---|
| TER-CAL-T | **Caldera** | terraced basalt rings, black-basalt strand, the **star-lake** (a "water" plane that shows stars — the Starfall conceit) | 
| TER-VAL-T | **Umbraveil valley** | sheer contour walls, terrace steps, valley-floor, the silver river, amber conduits |
| TER-SLA-T | **Slag-plain** | ash flats, slag heaps, cracked industrial ground, Black Crag rock |
| TER-CAP-T | **Astra'Thalas** | white marble plazas, sun-mosaic inlay (**exists**), gilded stone |
| TER-CAVE-T | **Undercroft/Deep Ways** | carved rock, ore veins, glyph-inlaid floors |
| TEX-EXISTING | **In-engine textures** | marble_floor, stone, scriptorium_floor/wall, shelf_wood, city_windows, star_dome, window_glow (all in `art/3d/`) |

## 8. SKYBOXES, BACKGROUNDS & distant vistas (`-T`/`SKY-`)

3D needs skydomes and distant massing, not painted backdrops (GDD: "never a bare black void").

| ID | Asset | Notes |
|---|---|---|
| SKY-01 | **Noctari star-dome** | the equirect starfield sky (**exists** as `star_dome`); Starfall/Umbraveil/Cold Open night |
| SKY-02 | **Solari day/festival sky** | warm gold-to-indigo solstice dusk for Astra'Thalas |
| SKY-03 | **The two-hour sun** (Umbraveil) | a hard gold wedge crossing a dark valley slot — diegetic, not just a skybox |
| SKY-04 | **Slag-plain overcast** | low ash-grey industrial sky, furnace-glow horizon |
| SKY-05 | **The Silence sky** | the star-dome + city draining to dark (**the drain exists**, `Zone3D.drain_to_dark`) |
| VIS-01 | **Distant city massing** | Starfall's far terraces, Astra'Thalas skyline, the Tower on the horizon (low-poly impostor massing — **Cold Open city/Tower exist**) |

## 9. VFX (essence, the Song, the Silence)

| ID | Effect | Notes |
|---|---|---|
| FX-01 | **Aether Ring** | the glowing iris-ring on Ring-Bearers; per-character eye glow |
| FX-02 | **Live essence / the Song** | ambient warm-gold motes, the star-lamp hum-glow, Songlines under streets |
| FX-03 | **Void-essence** (Elorin/Nullstone) | the *absence* rendered — a light-drinking dark shimmer |
| FX-04 | **The Silence** | colour-drain + light-death spreading district by district (**core logic exists**, `drain_to_dark`) |
| FX-05 | **Umbraveil lantern rivers** | flowing amber light-channels (emissive, animated) |
| FX-06 | **Vision / crossing-point overlay** | star-void vignette + glyph drift (UI-017) for The Glance / Reader / Same Night |

## 10. STILL-2D assets that stay 2D (not modelled)

Portraits **PO-001…014** (dialogue busts, 96×96), story panels **VS-001…010** (1920×1080 painterly),
the cartographic **plates EN-017 Starfall / EN-018 Umbraveil** (engraved-map register — see the map
prompt docs), all **UI-001…018**, and the key-art (§ `Master_KeyArt_Prompts.md`). 3D is the *world*;
these framed 2D registers are deliberate contrast and carry over unchanged.

---

## Coverage note
Every asset ID named in GDD §15 (Content Manifest) and §10 (Environments) is represented above, re-cut
for 3D, plus the new 3D-only categories (kits, furniture, flora, terrain, skyboxes, VFX). Items marked
`PLACEHOLDER` already exist in `godot/threed/`. This is a living doc — new zones add rows; when a real
model lands, flip its status and note the file. Precise zone specs (dimensions, layout, counts) live in
`Zone_Atlas.md`; art-generation prompts for the hero characters and locations live in
`Master_KeyArt_Prompts.md`.
