# KAYOS: The Night of Silence — Zone Atlas (precise 3D specifications)

Buildable, near-mathematically precise specs for every zone in the game — dimensions, layout, structure
positions, counts, materials, lighting, interactables, and connections. For the 3D build (`Zone3D`
conventions: **1 unit = 1 metre**, ground = XZ plane, Y up, **+Z toward the default camera / "front"**,
floors' top surface at **y = 0**). Every zone is procedural (built in code in `_ready()`), so these are
the numbers you type.

**Precision key:** ▣ = **measured** (already built in engine — exact). ◆ = **specified** (designed here to
buildable precision, grounded in canon/map docs). ○ = **extrapolated** (my call beyond canon — flag if wrong).
Canon sources: GDD §10 (zone table), §4 (narrative), the map prompts (`KAYOS_Starfall_Map_Prompt.md`,
`KAYOS_Umbraveil_Map_Prompt.md`), and the world lore set summarised in **`Canon_Notes.md`** (the Song,
the gods, the Nullstone spec, the timeline). Culture kits & materials: `3D_Asset_Bible.md` §0/§3.

**Scale reference:** adult elf/human model ≈ 2.1 m; orc ≈ 2.3 m; door ≈ 2.4 m; storey ≈ 3.5 m;
comfortable single-room zone ≈ 18–24 m across; a "walk it in 20 s" plaza ≈ 40–60 m.

---

## COLD OPEN — "The Same Night" (Astra'Thalas, 2000 AO) — BUILT

### Z-01 ▣ Astra'Thalas Balcony (EN-006/016) — `Balcony3D.gd`
- **Footprint:** marble platform **18 m (X) × 11 m (Z)**, 0.4 m thick, top at y = 0 (`PLATFORM_HALF_X 9`,
  `PLATFORM_HALF_Z 5.5`). Substructure: a dark tower-mass **18 × 14 × 11 m** centred at y = −7.4 beneath it
  (reads as elevation; occludes the room 40 m below).
- **Balustrade:** far edge at **z = −5.3** (`RAIL_Z`); top rail 18 m long at y = 1.05; ~26 balusters at
  0.7 m spacing.
- **City:** 3 receding rows of emissive dark-masonry boxes at z = −9 / −14 / −20, tops at y = −1.5 / −2.5 /
  −3.5, spanning x[−22, 22], seed 20260718.
- **Tower of Celestial Harmony:** tapered cylinder, bottom r = 2.4, top r = 0.6, **height 30 m**, at
  (7, ~11, −19); emissive apex sphere r = 1.1 + OmniLight (energy 4, range 26) 15.5 m above it.
- **Festival star-lamps:** 5 emissive orbs + warm OmniLights along the rail at x = −7/−3.5/0/3.5/7, y = 1.55.
- **Sun mosaic:** 4.5 × 4.5 m emissive quad at (0, 0.02, 0.5).
- **Stair down:** 5 steps (2.4 m wide, 0.25 m rise) at near-left corner ≈ (−7.4, 0, +4.1); invisible
  `RoomStair3D` zone → scriptorium.
- **Sky:** inverted star-dome sphere r = 180 (unshaded), centred at origin.
- **Content:** 12 examinables (banner, telescope, satchel, ledger, mask, broadsheet, mosaic, balustrade,
  rail-carving, 2 star-lamps, 2 cups), 7 wandering NPCs + 1 festival-goer. Player spawn (0, 0, 1.5).
- **Lighting:** WorldEnvironment ambient (0.28,0.30,0.42) energy 0.9, glow threshold 1.1; cool MoonLight
  DirectionalLight energy 0.5.
- **Orientation:** rail + city + Tower at −Z (the establishing view looks out over them).
- **Canon context:** the festival is the **Luminarae**, honouring **Solara** and the **Elder Song**
  (canon — `Canon_Notes.md`). The star-lamps burn without flame because the **Song** fills them; on the
  Tower the Grand Archmage's **Celestial Invocation** draws the Song up through the spire. The Silence is
  the **Song going out** — so `drain_to_dark` is theologically literal, not just a lighting effect.

### Z-02 ▣ Talindir's Scriptorium (EN-014/019) — `Scriptorium3D.gd`
- **Footprint:** floor **19 m (X) × 13 m (Z)** (`HALF_X 9.5`, `HALF_Z 6.5`), parented at **world y = −40**
  (40 m below the balcony; rooms never overlap). Walls 4 m tall on 3 sides (back at z = −6.5, sides at
  x = ±9.5); **front open, no ceiling** (keeps the orbit camera usable).
- **2D→local mapping:** x = x₂ₐ/1280·18 − 9; z = (y₂ₐ − 720)/720·12 − 6.
- **Window:** 2.4 × 2.6 m warm emissive quad in the back wall at (3.66, 1.7, −6.25) + warm OmniLight.
- **Shelving:** 3 shelf_wood masses (2.4 × 3.2 × 0.6 m) along the back wall at x = −6.2/−3.1/0.
- **Content:** 13 examinables (roster, 3 scroll racks, window, cabinet, 2 desks, cup, seal, book, chest,
  reading lamp) as 3D models; stair-up at ≈ (−7.3, 0, −2.1) → balcony. Player descent spawn (−5.5, 0, −0.5).
- **Lighting:** warm archive OmniLamps (energy 1.4, range 8) + the reading-lamp pool — candlelit vs the
  balcony's moonlight.

*(These two are the reference implementation of every spec pattern below.)*

---

## PART ONE — "The Architect" (Starfall & Astra'Thalas, ~1450–1460 AO)

### Z-03 ◆ Starfall — Academy Exterior / island (EN-001, PR-015/016)
Canon: the Academy sits on a small island at the **dead centre of the star-lake**, reached by one narrow
railless causeway; slender towers, a great central observatory dome, a moon-bridge between two wings,
courtyards, one heavily-warded structure (`KAYOS_Starfall_Map_Prompt.md`).
- **Island disc:** ◆ ~**70 m diameter**, dark basalt, ringed by a low silvered rail; edges drop to the
  star-lake (a reflective plane at y = −0.3 textured with the **star-dome** — the "hole showing sky").
- **Causeway:** ◆ **3 m wide × ~40 m long**, no rails, entering from −Z (mainland shore), meeting the
  island at a gate plaza (12 × 12 m).
- **Central observatory dome:** ◆ domed drum, base r = 10 m, dome apex ~16 m; ARC-NOC-K.
- **Two wings + moon-bridge:** ◆ two 3-storey (≈10.5 m) tower-blocks ~24 m apart, joined by an arched
  moon-bridge (span 24 m, rise 4 m) at 2nd-storey height (~7 m).
- **Warded structure:** ◆ one squat glyph-marked building (the containment approach), gold ward-glyph floor.
- **Interactables (§10):** notice board, fountain (centre plaza), students (NA-02 crowd), the moon-bridge.
- **Hosts:** Act I arrival; SQ-P1-01 (Vara's Name), SQ-P1-02 (Geomancer's Terms) hubs.
- **Palette/light:** Noctari indigo-black + silver, gold only on the ward-ring; cool starlight + warm
  window-glow; star-lake reflecting the dome. Sky = SKY-01.
- **Connections:** causeway → city streets (Z-06); interior doors → theory wings (Z-04), containment (Z-05).

### Z-04 ◆ Academy — Theory Wings (EN-002, PR-007/015)
- **Form:** ◆ a long galleried library-hall, **28 m (X) × 12 m (Z) × 8 m** tall (2 storeys of stacks), plus
  2–3 side study alcoves (6 × 6 m). Mezzanine walkway at y = 3.6 m along both long walls.
- **Fixtures:** library stacks (FUR-03) lining walls, ~6 lecterns/glyph-boards (FUR-08) on the floor,
  reading tables (FUR-01). Star-crystal comb windows (Noctari) high on the walls.
- **Hosts:** team assembly; Coil & Vara scenes; SQ-P1-03 seed.
- **Light:** cool, low, focused reading-pools; indigo dark between stacks.

### Z-05 ◆ Academy — Containment Halls (EN-003, PR-004/001/010)
- **Form:** ◆ an industrial-arcane hall, **24 m (X) × 16 m (Z) × 9 m** tall, heavier stone than the theory
  wings; a central **containment rig pit** (8 m diameter, recessed 1.5 m) where prototype tests run.
- **The schematic table (PR-010):** ◆ a 3 × 1.5 m drafting table on a raised 6 × 6 m dais at one end — the
  **SAFEGUARD DESIGN** happens here (the single most important sequence); the buried flaw is authored at
  this table.
- **The prototype (PR-001):** on/above the rig pit in Act II.
- **Hosts:** Act II core; SQ-P1-03 (What Coil Saw), SQ-P1-06 (The Buried Flaw); the half-failed first test.
- **Light:** cold arcane blue from the rig, warm work-lamps at the table; the drift from "containment" to
  "control" can be shown by the rig's glow shifting cooler/harsher across the act.

### Z-06 ◆ Starfall — City Streets (EN-004, PR-016)
Canon: lower terraces + a **canal quarter** — dense concentric rings threaded by 3 curving canals with
small arched footbridges, descending toward the star-lake shore.
- **Playable slice:** ◆ a **~50 × 35 m** terraced quarter (density over breadth), 2–3 stepped levels
  (0 / −3.5 / −7 m), one **canal** 4 m wide crossed by 2 arched footbridges (span 6 m).
- **Fixtures:** market stalls (FUR-14), the **inn** (Strain-relief haven — a warm 10 × 8 m interior),
  canal bridges, terrace rails. The **Under-Terraces** (the omitted service rings, per the map's "Other
  Map") are implied by stairs/hatches going down and out of play — a thematic beat.
- **Hosts:** SQ-P1-04 (Sera's Divided House), SQ-P1-05 (Northreach Widow); inn = Strain relief.
- **Light:** warm window-rows against cold stone; the star-lake glow below.

### Z-07 ○ Starfall — Common Interiors (EN-005)
- **Form:** ○ a small set of reusable interiors (hearth-room 8 × 7 m, shop 6 × 6 m, home 7 × 6 m), single
  storey (3.5 m), ARC-NOC-K + warm hearths (FUR-11). Side content; the Northreach widow's home.

### Z-08 ◆ Umbraveil (memory) (EN-009)
Canon: the Noctari homeland — a deep narrow valley of **two hours' sun**, terraced door-less dwellings,
**amber lantern-rivers** flowing downhill, light-farms high on the sunlit wall, the noble seat on the
*shaded* valley floor (down = up). Experienced only in **memory** — "dreamlike softness."
- **Playable slice:** ◆ a **vertical ribbon**, ~**16 m wide (X) × 60 m long (Z)** between two sheer contour
  walls rising 25 m+; the ribbon steps *down* along +Z toward the shaded valley-floor seat.
- **The two-hour sun:** ◆ a single hard **pale-gold light wedge** (SKY-03) striking the upper west wall
  (x = −8, y = 12+) — a *geometric* beam, not ambient glow; everything is arranged relative to where it lands.
- **Light-farms:** ◆ ranked crystal blade-arrays (ARC-UMB-K) terraced on the upper wall in the wedge;
  cramped worker dwellings between them (the poor live *high, in the light*).
- **Lantern rivers:** ◆ 2–3 emissive **amber channels** (FX-05), 0.5 m wide, running down the walls and
  threading through the door-less houses — the only warm thing; branch/rejoin like a delta.
- **Valley floor:** ◆ the deepest, darkest, most spacious district — great halls cut into the cliff base +
  1–2 shaded observatory domes (gold sigils). Silver river down the centre; **lower gate** to Terran roads
  at the far (−Z... here +Z, deepest) throat.
- **Doors:** ◆ **none** — open archways everywhere (the anti-hoarding custom; "nothing ever closed").
- **Memory treatment:** soft edges, bloom-haze, desaturated warmth; enter via the **chalk-map** transition
  image (see the Umbraveil map doc's chalk variant / IT-003 neighbour).
- **Hosts:** Seravin (CH-012) Mender dialogue; Strain relief. Palette: twilight blue-violet + rationed amber.

### Z-09 ◆ Astra'Thalas — Capital Exterior (EN-006, PR-017/021)
Shared by Part One Act III (arrival) and Part Two Act III. The Solari golden capital.
- **Playable slice:** ◆ a grand **~60 × 40 m** marble processional plaza rising toward the Tower's base;
  white-marble terraces (ARC-SOL-K), **sun-braziers** and **gilded gates** (PR-017), sun-mosaic inlay
  (TER-CAP-T). The Cold-Open **balcony (Z-01)** is one high terrace off this plaza.
- **Light:** warm, high, generous gold (Age of Order) — but at the Night, drains to void (SKY-05).
- **Connections:** plaza → Tower (Z-10) ceremonial doors.

### Z-10 ◆ Tower of Celestial Harmony (EN-007, PR-017)
- **Form:** ◆ the interior of the great spire — a vertical stack of **tiered ceremonial galleries**, drum
  base r ≈ 12 m, rising ~120 m to the lit apex (the exterior is Z-01's 30 m stub scaled up for the hero
  interior). Ceremonial doors, ward-floor rings (gold glyphs) at each tier.
- **Playable slices:** the **testimony gallery** (P1 A3 — Elorin attests before the Conclave: a 16 m-drum
  gallery with a speaker's dais) and the **descent** to the vault (both parts).
- **Hosts:** the safeguards testimony (P1); the infiltration (P2, solstice, wards lowered for the festival).

### Z-11 ◆ The Nullstone Vault (EN-008, PR-002/018/019) — **HERO, Legacy-generated**
The flagship reuse: **designed by Elorin in Part One, defeated by Grakkar in Part Two.** Its defences are
assembled at P2 A3 load-time from Part One flags (GDD §5.1).
- **Form:** ◆ a circular arcane vault beneath the Tower, **~24 m diameter × 10 m** tall, dark basalt +
  glyph-floor; a central **dais (PR-019)** 4 m diameter, 0.6 m high, holding the Stone.
- **Ward-pylons (PR-018a/b/c):** ◆ a ring of **8 pylons** at ~9 m radius, 6 m tall. Scheme by `P1_WARD_SCHEME`:
  - **LATTICE** (018a): interlocking pylons + a lattice of light-beams between them → bypass = pattern/Acumen.
  - **ORBIT** (018b): pylons on a slow rotating ring → bypass = timing/Celerity.
  - **SEAL** (018c): monolithic sealed pylons → bypass = force/Vigor **or** the flaw.
- **Legacy assembly:** `P1_FAILSAFE_CUT` opens a gap in the ring; `P1_FLAW_*` sets whether a clean
  activation route exists; `P1_TESTIMONY == EXPOSED` thins the Void Wardens (CH-017) posted here.
- **The Stone (PR-001/002/003):** **void-touched obsidian** carved around **the heart of a dying star**
  (canon; project codename *Aethelburg*) — a void-well that **drinks light**; the active form (003) drains
  colour outward (FX-03/04). **THE SAME NIGHT happens on this dais.** Note the activation is really a
  **network** event via seeded **echo stones (PR-024)** — the vault is the hand on the key, not the whole
  mechanism.
- **Light:** cold arcane glow from the pylons; the Stone eats it; at activation → SKY-05 drain.

---

## PART TWO — "The Unbound" (1780–2000 AO)

### Z-12 ◆ The Ashpile (EN-010, PR-014)
- **Form:** ◆ an orc labor-camp on an endless grey **slag-plain** (TER-SLA-T) under low ash sky (SKY-04);
  a playable **~50 × 40 m** camp yard: a central **roll-call post**, a **collar-station**, rows of ~8
  riveted **bunk-shacks** (5 × 4 m each), a furnace-glow horizon.
- **Fixtures:** roll-call post (centre), collar-station, shacks, chains, coal heaps (ARC-IND-K, FUR-12).
- **Hosts:** Act I; SQ-P2-01 (The First Book — literacy); Morga (CH-019) intro. Cruelty via routine.
- **Light:** harsh cold slag-grey + distant ember-orange furnace; no warmth that isn't industrial.

### Z-13 ◆ Black Crag (flashback) (EN-011, VS-007)
- **Form:** ◆ a jagged black-rock height on the slag-plain, largely **scripted/scene** (no combat) — a
  ~30 × 30 m broken plateau of black basalt at night, firelit, banners and scattering figures. The
  Rebellion breaks here; the player chooses Grakkar's role (`P2_BLACKCRAG_ROLE`), Morga lives or dies.
- **Treatment:** aftermath and shadow, not battle; ember, ash, blood-black.

### Z-14 ◆ Research Facility — Labor Floors (EN-012, PR-011/012/013)
- **Form:** ◆ an arcano-industrial interior, **~30 m (X) × 20 m (Z)**, 2 working levels (0 / −4 m) linked by
  ore-lifts and catwalks (y = 3.5 m); furnaces, ore-lifts, chain-hoists, riveted-plate walls (ARC-IND-K).
- **The undercroft:** ◆ a Terran-carved sub-level (ARC-TER-K, glow-stone) — the Deep Ways route (opens if
  `P1_DURAK_TRUST` high). A **ward-gate** separates the labor floor from the Archives (Z-15).
- **Hosts:** Act II infiltration hub; SQ-P2-02 (Kess's Debt), SQ-P2-04 (Overseer's Doubt); Ilvane (CH-023).

### Z-15 ◆ Archives of Astral Wisdom (EN-013, PR-007/008) — **the Legacy corpus, THE READER**
- **Form:** ◆ a cathedral of knowledge — a tall **~28 m (X) × 14 m (Z) × 12 m** hall of receding silver
  **scroll-stacks** (FUR-02/03) into indigo dark, mezzanine galleries (y = 4 / 8 m), warded restricted
  stacks behind a **ward-gate**, the **Archivist** (CH-025) at a central desk.
- **The Legacy:** what Grakkar can find here **is exactly what the player preserved as Elorin** (`P1_ARCHIVE_*`,
  `P1_WARNING`, per-document `_FATE` flags). SQ-P2-03 (Vara's Heirs) opens the cleanest route if
  `P1_VARA_CREDITED`. SQ-P2-05/06 host here. **THE READER** crossing point fires here.
- **Light:** cold, still, sacred; reading-pools; the restricted stacks colder and forbidden.

*(Part Two Act III reuses Z-09 Astra'Thalas, Z-10 Tower, Z-11 Vault — the same finale zones the player
secured as Elorin. That reuse is the point.)*

---

## CODA & CROSSINGS

### Z-16 ▣/◆ Lunaris — Talindir's Study (EN-014, PR-008/022)
The Cold-Open **scriptorium (Z-02)** *is* the Lunaris study model — reuse it. ◆ For the Coda, dress it
as the exile study: one great **window on a night sea** (replace the city-glow window with a moonlit sea
plane), walls of document-chests (FUR-05), the great indigo **ledger** on the desk under one candle.
- **Hosts:** the Chronicle (a tour through the player's cumulative Legacy flags as documents on the desk);
  the three endings; the closing Crossing. Palette: cold silver-blue night, one warm candle-pool.

### Z-17 ◆ Vision Space (EN-015, VS-002/003/004/005)
- **Form:** ◆ not a room — a **void stage**: a small platform (~8 m) in an infinite star-void (SKY-01 with
  no floor beyond), glyph-drift, the vision overlay (UI-017 / FX-06). Hosts the three Crossing Points:
  **The Glance** (Elorin ↔ young Grakkar, one second, two viewpoints), **The Reader** (Grakkar reads
  Elorin's words), **The Same Night** (the activation, both halves). Content selected by Legacy flags.

---

## SUMMARY TABLE (all zones)

| Z | Zone | EN | Part | Footprint (m) | Culture kit | Status |
|---|---|---|---|---|---|---|
| 01 | Astra'Thalas Balcony | 006/016 | Cold Open | 18×11 platform | Solari | ▣ built |
| 02 | Talindir's Scriptorium | 014/019 | Cold Open | 19×13 @ y−40 | Noctari-spare | ▣ built |
| 03 | Starfall Academy island | 001 | P1 | ~70 dia island + 40 causeway | Noctari | ◆ |
| 04 | Academy Theory Wings | 002 | P1 | 28×12×8 | Noctari | ◆ |
| 05 | Academy Containment Halls | 003 | P1 | 24×16×9 | arcane | ◆ |
| 06 | Starfall City Streets | 004 | P1 | ~50×35, 3 levels | Noctari | ◆ |
| 07 | Starfall Common Interiors | 005 | P1 | 6–8 m rooms | Noctari | ○ |
| 08 | Umbraveil (memory) | 009 | P1 | 16×60 ribbon | Umbraveil | ◆ |
| 09 | Astra'Thalas Capital Exterior | 006 | P1A3/P2A3 | ~60×40 plaza | Solari | ◆ |
| 10 | Tower of Celestial Harmony | 007 | P1A3/P2A3 | drum r12, ~120 tall | Solari hero | ◆ |
| 11 | The Nullstone Vault | 008 | P1A3/P2A3 | ~24 dia × 10 | arcane hero | ◆ Legacy-gen |
| 12 | The Ashpile | 010 | P2 | ~50×40 yard | industrial | ◆ |
| 13 | Black Crag | 011 | P2 | ~30×30 scripted | industrial | ◆ |
| 14 | Research Facility | 012 | P2 | ~30×20, 2 levels + undercroft | industrial/Terran | ◆ |
| 15 | Archives of Astral Wisdom | 013 | P2 | 28×14×12 | Noctari | ◆ |
| 16 | Lunaris Study (Coda) | 014 | Coda | reuse Z-02 | Noctari-spare | ▣/◆ |
| 17 | Vision Space | 015 | Both | ~8 m void stage | none | ◆ |

*Living doc. Numbers on ▣ zones are exact (in engine); ◆/○ numbers are buildable targets — tune on
render, and update here first (same discipline as GDD §13). When a zone is built, mark it ▣ and cite the
`Zone3D` file.*
