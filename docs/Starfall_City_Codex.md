# Starfall — City Codex

> _Generated from `docs/city/starfall_city.json` by `tools/gen_starfall_codex.py`. Do not hand-edit — edit the JSON and re-run. Companion map: `art/blueprints/Starfall_CityPlan.svg`._

**Second city of the Noctari, seat of the Academy of Astral Harmony**  
*Part One — The Architect, c. 1450 AO (Age of Order, the city alive)* · population target **3,000** · Noctari (night elf); Umbrion-aligned; scholars of the heavens

**The theme (read this first).** Two maps of one city. The Plate (this visible survey) and the Ledger-map beneath it (the Under-Terraces) do not contain each other. That omission is the story of Part One.

**Coordinates.** polar around the caldera centre (0,0). r = metres from centre; a_deg = degrees where 0 = +Z (front / the Grand Processional & causeway), increasing toward +X. world x = r*sin(a), z = r*cos(a). y = terrace top height (metres). Screen/plate angle = 180 - a_deg.

**Status.** FOUNDATION + two wedges fully specified (House Vael'Suran H0, House Serenthil H8 — the pair flanking the Grand Processional). Seven Houses + the Academy island still stubbed. Geometry LOCKED to godot/threed/StarfallCity3D.gd & docs/Scale_Reference.md.

## Districts

| ID | District | Kind | Radius (m) | Top y |
|---|---|---|---|---|
| D-RIM | The Rim & the Nine Towers | elite/observatory | 395–452 | 45 |
| D-UPPER | The Upper Terraces | senior-scholar housing | 340–395 | 34 |
| D-MID | The Middle Terraces | lesser-scholar & guild | 285–340 | 23 |
| D-CANAL | The Canal Quarter | artisan/common | 225–285 | 12 |
| D-SHORE | The Shore & Processionals | civic/threshold | 210–225 | 0 |
| D-MIRROR | The Mirror & Causeway | sacred/void | 0–210 | -1 |
| D-ACADEMY | The Academy of Astral Harmony (island) | institution | 0–75 | 2 |
| D-UNDER | The Under-Terraces | service/hidden | 200–300 | -8 |

- **The Rim & the Nine Towers** (D-RIM) — The rim walk crowned by the nine House observatory towers (one dead). Each House seats itself here, highest and coldest, above its own wedge.
- **The Upper Terraces** (D-UPPER) — Sparse villas of senior astronomers, each with a surveyed, legally-protected sightline down to the Mirror (the 'ray-lines' of the Plate). To lose your sightline is to lose your rank.
- **The Middle Terraces** (D-MID) — Lecture annexes, scribe-halls, chart-makers and lens-guilds, and the dwellings of lesser scholars who serve the Houses without a sightline of their own.
- **The Canal Quarter** (D-CANAL) — The dense, warm, lowest visible ring: three star-water canals, footbridges, instrument-workshops, market rows, inns, a shrine. Where the city actually lives.
- **The Shore & Processionals** (D-SHORE) — Black basalt strand where the four processionals meet the star-lake; the armillary monument; customs posts where goods arrive from below.
- **The Mirror & Causeway** (D-MIRROR) — The star-lake — a hole showing sky — crossed by the single railless causeway to the Academy island.
- **The Academy of Astral Harmony (island)** (D-ACADEMY) — Dead centre: the great observatory, theory wings, moon-bridge, the warded containment structure. Elorin, Corel, Coil, Sera and the Nullstone team work here.
- **The Under-Terraces** (D-UNDER) — THE OMITTED CITY. Beneath the canal quarter and shore: barge locks that raise cargo from the world below, conduit galleries carrying the Song to the star-lamps, bunk-halls of Terran deep-wrights and orc labour, the canteens and foremen. Not on the Plate. Not by conspiracy — the cartographers simply never considered it part of the city.

## The Nine Houses of the Rim

Each rim observatory tower is a House — an astronomical dynasty that owns the wedge of city below it. One is dead. Houses marked ★ are fully specified below; the rest are stubbed (name, domain, wedge) and rolled out next. Wedges are deliberately *not* clones — each takes its social texture from its celestial domain (see the design note at the end).

| ID | House | Epithet | Domain | Tower a° | Wedge a° | Status |
|---|---|---|---|---|---|---|
| H0 | House Vael'Suran ★ | Keepers of the Fixed Stars | The unmoving stars; the master survey from which every sig… | 20 | 0–40 | living |
| H1 | House Nyx'Talar | Wardens of the Occultation | Eclipses, transits, and every moment one light passes behi… | 60 | 40–80 | living |
| H2 | House Oravelle | Trackers of the Wanderers | The wandering lights (planets); ephemerides and prediction… | 100 | 80–120 | living |
| H3 | House Sabreth | Readers of the Long-Haired Stars | Comets and omens; the House everyone consults and no one a… | 140 | 120–160 | living |
| H4 | House Ilmyra | Keepers of the Tides of the Song | The moons and the slow tides the Song makes in all things;… | 180 | 160–200 | living |
| H5 | House Corvane | Scholars of the Deep Field | The dark between the stars — the void itself. The most Umb… | 220 | 200–240 | living |
| H6 | House ———— | the Dead House | Unknown / struck from the record. Its dome is dark, its si… | 260 | 240–280 | dead |
| H7 | House Duskmere | Watchers of the Horizon | The twilight band, risings and settings, the last and firs… | 300 | 280–320 | living |
| H8 | House Serenthil ★ | Keepers of the Meridian | The meridian and the hour; timekeepers of Starfall. They r… | 340 | 320–360 | living |

### House Vael'Suran — *Keepers of the Fixed Stars* (H0)
- **Domain:** The unmoving stars; the master survey from which every sightline in Starfall is measured. The eldest and proudest House; its charts are the city's ground truth.
- **Sigil:** a silver gnomon crossed by a single fixed star, on indigo
- **Wedge:** a° 0–40, tower at a° 20 · **living**  ·  ★ fully specified

### House Nyx'Talar — *Wardens of the Occultation* (H1)
- **Domain:** Eclipses, transits, and every moment one light passes behind another. Readers of what hides what.
- **Sigil:** a black disc crossing a silver ring
- **Wedge:** a° 40–80, tower at a° 60 · **living**

### House Oravelle — *Trackers of the Wanderers* (H2)
- **Domain:** The wandering lights (planets); ephemerides and prediction. The House the Conclave trusts with dates.
- **Sigil:** five linked circlets in a curve
- **Wedge:** a° 80–120, tower at a° 100 · **living**

### House Sabreth — *Readers of the Long-Haired Stars* (H3)
- **Domain:** Comets and omens; the House everyone consults and no one admits to consulting. Faintly disreputable, quietly wealthy.
- **Sigil:** a silver star trailing a fine comet-tail of gold
- **Wedge:** a° 120–160, tower at a° 140 · **living**

### House Ilmyra — *Keepers of the Tides of the Song* (H4)
- **Domain:** The moons and the slow tides the Song makes in all things; the House that tends the city's water-clocks and the canal locks' timing.
- **Sigil:** three crescents nested
- **Wedge:** a° 160–200, tower at a° 180 · **living**
- **Note:** Its wedge holds the Grand Processional's far (-Z/back) counterpart is NOT here; the front processional falls in the Vael'Suran/Serenthil gap.

### House Corvane — *Scholars of the Deep Field* (H5)
- **Domain:** The dark between the stars — the void itself. The most Umbrion-aligned House; feared a little, and the one whose theory feeds the Academy's void-work. Elorin's intellectual kin, though not her blood.
- **Sigil:** an empty silver ring around unmarked indigo
- **Wedge:** a° 200–240, tower at a° 220 · **living**

### House ———— — *the Dead House* (H6)
- **Domain:** Unknown / struck from the record. Its dome is dark, its sigil scraped from the ring, its name unsaid. No one has ever proposed relighting it; some absences are load-bearing.
- **Sigil:** none — a dome struck through with one black shard
- **Wedge:** a° 240–280, tower at a° 260 · **dead**
- **Note:** The dead House of the greybox (DEAD_TOWER index). Its wedge is the city's quiet scar — under-tended terraces, cheaper rents, the district people move to when they wish not to be measured.

### House Duskmere — *Watchers of the Horizon* (H7)
- **Domain:** The twilight band, risings and settings, the last and first light. The House of thresholds and departures; keeps the outer switchback stair and the rim gates.
- **Sigil:** a silver line of horizon under a half-sunk star
- **Wedge:** a° 280–320, tower at a° 300 · **living**

### House Serenthil — *Keepers of the Meridian* (H8)
- **Domain:** The meridian and the hour; timekeepers of Starfall. They ring the bells, including the ninth-bell count of every Luminarae — and the same bells that toll the festival toll the labour-shifts in the dark below. The House the whole city depends on and none reveres: a utility, not a glory. Flanks the Grand Processional opposite Vael'Suran.
- **Sigil:** a vertical silver meridian line through a single gold point
- **Wedge:** a° 320–360, tower at a° 340 · **living**  ·  ★ fully specified

## House Vael'Suran — *Keepers of the Fixed Stars* — structure by structure

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### VS-T01 · The Gnomon Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 20**, footprint **⌀22 m**, h 56 m, 6 storeys, base y 45. Residents: **7**.

The master survey of the fixed stars is kept and corrected here; every protected sightline in Starfall is a copy of a line first drawn in this tower. The House's authority is literally the instrument on its top floor.

| Room | Size (m) | Purpose |
|---|---|---|
| The Meridian Hall | 20×20×8 | ground instrument hall; the great mural quadrant fixed to the north wall |
| The Chart Vault | 10×8×4 | fireproof silver-lined vault of the master plates; only the House head and First Surveyor hold keys |
| Head's Study | 8×7×4 | Magister Ysolde's study, sightline due to the Mirror |
| Computers' Room | 12×8×4 | where junior scholars reduce the night's readings by hand; ink, tables, and quiet |
| The Gnomon Chamber | 12×12×10 | top floor; the great gnomon and the roof aperture; the reading is taken standing in the cold |
| Servants' stair & lamp-room | 4×4×30 | the spiral stair; the star-lamp that crowns the dome is tended from here |

**Occupants:** Magister Ysolde Vael'Suran; First Reader Pan-Ostrel; the junior computers (4).

> 3 named + 4 live-in junior computers (dormitory on the 4th floor). The dome's lit finial is one of the nine on the greybox rim.

#### VS-M01 · The Vael'Suran Seat
*great house (manor)* — **r 438 m, a° 27**, footprint **34×22 m**, h 14 m, 3 storeys, base y 45. Residents: **19**.

The living seat of the House on the rim beside its tower — cold, immaculate, and arranged so that every principal room holds the same framed view of the star-lake. Status here is measured in windows.

| Room | Size (m) | Purpose |
|---|---|---|
| The Hall of Sightlines | 14×10×7 | reception; nine framed sightline-drawings, one per generation of heads |
| Ysolde's chambers | 10×8×4 | the matriarch's rooms, the best sightline in the House |
| Family wing | 16×8×4 | four chambers for the near family |
| Cold-court | 12×12×12 | an open inner court left deliberately unroofed to the sky — the House takes readings without leaving home |
| Kitchen & stores | 10×7×4 | below the hall |
| Staff quarters | 12×6×4 | attic rooms for the household staff |

**Occupants:** Magister Ysolde Vael'Suran; Ilvenor Vael'Suran; the near family (3); the Seat household staff (13).

> Ysolde + near family (5) + 13 household staff (cook, chart-porters, lamp-tender, a gate-lodge keeper, maids). Ysolde also keeps a study in the tower.

### The Upper Terraces

#### VS-U01 · The Corrected Chart (the Open House)
*senior astronomer's villa* — **r 373 m, a° 5 (world x,z = 30, 372)**, footprint **14×12 m**, h 6 m, 1 storeys, base y 34. Residents: **1**.

Home and working room of Sub-Magister Aeliston Vael'Suran, a cousin of the House who keeps the running correction of the caldera's own sky from this terrace. A lifetime's chart is pinned to the lectern, corrected in a fine hand.

| Room | Size (m) | Purpose |
|---|---|---|
| The Reading Room | 13×11×6 | one open room; the star-chart lectern against the back wall, a cot, a stove, a cold-shelf of instruments |

**Occupants:** Sub-Magister Aeliston Vael'Suran.

> Ties the built Open House interior into canon. Aeliston lives alone by choice; the whole House thinks him eccentric for keeping his own hours and his own door.

#### VS-U02 · Sightline Villa — Halvenor
*senior astronomer's villa* — **r 368 m, a° 14**, footprint **15×13 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

The household of First Surveyor Halvenor Daskei, the House's most important commoner-born scholar — the man who actually runs the survey Ysolde signs.

| Room | Size (m) | Purpose |
|---|---|---|
| Ground hall & study | 14×7×4 | study with the protected sightline; a second-best mural quadrant |
| Family rooms (x3) | 14×6×4 | Halvenor, his wife, three children |
| Roof platform | 8×8×0 | a private observing platform — the perquisite of his post |

**Occupants:** First Surveyor Halvenor Daskei; Renne Daskei & 4 (family).

> Halvenor (First Surveyor), spouse Renne, 3 children, 1 live-in aunt.

#### VS-U03 · Sightline Villa — Corvane-in-marriage
*senior scholar's villa* — **r 372 m, a° 23**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **5**.

A Vael'Suran daughter married into House Corvane (the Deep Field) and kept her sightline; the villa quietly does void-adjacent work the fixed-star House disowns in public and funds in private.

| Room | Size (m) | Purpose |
|---|---|---|
| Study of the Dark | 10×8×5 | shuttered by day; the sightline used at new-moon only |
| Living rooms | 14×6×4 | the couple + 2 children |
| Servant's room | 4×4×4 | one maid |

**Occupants:** Magistra Ivrenne (née Vael'Suran, m. Corvane).

> Magistra Ivrenne (née Vael'Suran) + husband + 2 children + 1 maid. A thread that connects wedge 0 to House Corvane (H5).

#### VS-U04 · Sightline Villa — the Widow Sarrent
*senior scholar's villa (declining)* — **r 366 m, a° 32**, footprint **13×11 m**, h 7 m, 2 storeys, base y 34. Residents: **3**.

A villa whose sightline is being slowly, legally encroached by a neighbour's new roofline — the great terror of the upper terrace. The widowed astronomer Sarrent is fighting it in the House court and losing.

| Room | Size (m) | Purpose |
|---|---|---|
| Contested study | 9×7×4 | the sightline here is 4 degrees narrower than it was a decade ago |
| Rooms | 12×6×4 | Sarrent + a companion |

**Occupants:** Astronomer Sarrent.

> Sarrent + companion Ol + one servant. A ready side-quest seed (the sightline suit).

### The Middle Terraces

#### VS-L01 · The Scribes' Hall of the Fixed Stars
*guild-hall + lodging* — **r 312 m, a° 11**, footprint **22×14 m**, h 11 m, 3 storeys, base y 23. Residents: **14**.

Where the House's charts are fair-copied and bound, and where the apprentice scribes lodge. A young Noctari apprentice named Talindir keeps a cot and a candle here — he is eighty, which for an elf is a boy, and he copies faster and more beautifully than anyone will admit.

| Room | Size (m) | Purpose |
|---|---|---|
| The Copying Floor | 20×10×5 | ranked sloped desks under high comb-crystal windows |
| The Binding Room | 10×8×4 | presses, thread, silver leaf |
| Apprentices' dormitory | 18×6×4 | 12 cots; Talindir's is by the window |
| Master-scribe's room | 6×5×4 | the hall's warden |

**Occupants:** Master-scribe Ovinn; Talindir.

> Master-scribe Ovinn + 13 apprentices incl. Talindir (CH-006, here as an apprentice ~1450 AO — 550 years before the Cold Open). Canonical anchor.

#### VS-L02 · The Lens-Grinders' Court
*workshop + dwelling* — **r 320 m, a° 20**, footprint **18×16 m**, h 8 m, 2 storeys, base y 23. Residents: **9**.

Optical glass for the whole wedge is ground and figured here — the slow, wet, patient trade that makes the Houses' instruments possible and gets none of the credit. A family firm, three generations deep.

| Room | Size (m) | Purpose |
|---|---|---|
| The Grinding Shed | 12×8×5 | pitch laps, abrasive tubs, the great figuring wheel |
| The Testing Room | 8×6×4 | a dark room with a slit; lenses proved against a star-lamp |
| Family dwelling | 14×6×4 | the Marn family above the shed |
| The Court | 8×8×0 | open drying/working court |

**Occupants:** Master optician Delu Marn + household (9).

> Master optician Delu Marn + spouse + 4 children + 3 journeymen (lodged).

#### VS-L03 · Lesser Scholars' Row
*terrace of 6 small dwellings* — **r 300 m, a° 30**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **22**.

Six joined narrow houses of the wedge's lesser scholars — the reducers, correctors, and lecture-assistants who serve the Houses without a sightline of their own. Respectable, cramped, sightless.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: ground room + 2 up | 6×7×4 | each of the 6 houses: a work-room and two small chambers |

**Occupants:** Lesser Scholars' Row (22).

> 6 households, ~22 souls total (the reducer Kessa Von and family named; the rest counted). No protected sightline — a social border made of geometry.

### The Canal Quarter

#### VS-K01 · The Sounding-Glass
*inn (Strain-relief haven)* — **r 268 m, a° 9**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **5**.

The wedge's inn, on the canal — warm, low-ceilinged, loud, and the one place a sightless scholar, an off-shift deep-wright, and a slumming House son drink in the same room. In game terms, the Strain-relief haven for this quarter (Zone_Atlas Z-06).

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, long tables, the cracked sounding-glass over the bar that gives the place its name |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above for travellers and the newly-evicted |
| Cellar | 8×6×3 | canal-cooled store; a hatch to the Under-Terraces the innkeeper pretends not to know about |

**Occupants:** Bruin Hale + house (5).

> Innkeeper Bruin Hale + 2 family + 2 staff. The cellar hatch is a real connection to VS-X05 (a thing the Plate does not know).

#### VS-K02 · The Instrument Market
*market row (brassworkers & opticians)* — **r 258 m, a° 18**, footprint **30×10 m**, h 6 m, 2 storeys, base y 12. Residents: **34**.

Ten stalls and shopfronts: brass-founders, tube-makers, engravers of scales, a dealer in second-hand quadrants, a paper-and-ink merchant. Live-over-the-shop trade.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + workshop + room above | 3×8×4 | 10 units, most with a family living above |

**Occupants:** The Instrument Market (34).

> 10 shops, ~34 souls. Named: brass-founder Ossa Kellen (whose foundry vents to an Under-Terrace flue), engraver the elder Pim.

#### VS-K03 · The Deepening
*shrine (Umbrion)* — **r 250 m, a° 26**, footprint **12×12 m**, h 9 m, 1 storeys, base y 12. Residents: **1**.

A small windowless shrine to Umbrion, Weaver of Shadow — dark on purpose, entered to sit in the friendly void the Noctari call presence, not absence. A keeper tends one silver lamp that is never lit.

| Room | Size (m) | Purpose |
|---|---|---|
| The Dark Cell | 8×8×7 | no light; a bowl of still star-water; you find the seat by touch |
| Keeper's cell | 4×4×3 | the shrine-keeper's room |

**Occupants:** Serae the shrine-keeper.

> The keeper, blind Serae — chosen for the post because the dark costs her nothing. A quiet counterpoint to the Solari sun-worship of the Cold Open.

#### VS-K04 · Vara's Garret
*rented room over a workshop* — **r 262 m, a° 33**, footprint **6×6 m**, h 3 m, 1 storeys, base y 20. Residents: **1**.

A single rented attic room where Vara — the human prodigy the Academy uses and under-credits — lives. Books to the ceiling, a borrowed quadrant she is not supposed to have, and the longest walk to the island of anyone on the team, because a human is not given rooms on the rim.

| Room | Size (m) | Purpose |
|---|---|---|
| The Garret | 6×6×3 | bed, desk, and more paper than floor; a skylight she uses as a poor man's aperture |

**Occupants:** Vara.

> Vara (CH-010, PO-008) — canonical Nullstone-team anchor placed in wedge 0. 'Twice as good, half as credited' is literally spatial here: she has the worst room and the best mind in the wedge.

#### VS-K05 · Canal Dwellings — Lockside
*block of common dwellings* — **r 245 m, a° 14**, footprint **24×14 m**, h 11 m, 3 storeys, base y 12. Residents: **38**.

The densest housing on the visible city: eight dwellings stacked three storeys over the canal, home to the artisans, boatwrights, lamplighters and canal-workers who keep the quarter running.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 8 dwellings, families of 3-6 |

**Occupants:** Lockside dwellings (38).

> ~38 souls. Named: lamplighter Corrun, who climbs the whole wedge every dusk, and knows a stair down that isn't drawn.

#### VS-C01 · The Vael'Suran Canal & its two bridges
*waterway* — **r 255 m, a° 20**, footprint **60×6 m**, h ? m, base y 12. Residents: **0**.

Star-water — black, still, faintly starred — runs the canal that both drains the quarter and, through the lock below, connects to the barges of the Under-Terraces. Two arched stone footbridges cross it.

> The canal is the visible top of an invisible system: what looks like a decorative channel is the throat of the cargo route the Plate omits (see VS-X01, the lock).

### The Shore & Processionals

#### VS-S01 · The Processional Foot & Customs Post
*civic threshold* — **r 228 m, a° 3**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **3**.

Where the Grand Processional meets the shore on the wedge's side: a customs post that weighs and tallies everything coming up from below before it is allowed onto the terraces. The one official door between the two cities — and it faces up, never down.

| Room | Size (m) | Purpose |
|---|---|---|
| The Weighing Hall | 10×7×4 | scales, tally-desks, a wardsealed strongroom |
| Officers' room | 5×4×4 | the customs officer and two clerks |

**Occupants:** Customs officer Trell + 2 clerks.

> Customs officer Trell + 2 clerks (day post, not resident overnight — counted at their canal homes; listed here as workplace).

### The Under-Terraces

#### VS-X01 · Cael's Lock
*barge lock (service)* — **r 240 m, a° 20**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

A stone chamber-lock that raises cargo barges from the world below the caldera up into the wedge's canal. The whole visible quarter's stone, glass, food and fuel arrives through here, lifted by chain-gangs. The Plate draws the pretty canal above it and stops.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the flooding/emptying basin; the great counter-weighted gates |
| The Capstan Floor | 12×8×4 | where the lift-gangs walk the capstans; named for a worker who died at them |
| Tally hole | 4×4×3 | the under-clerk's niche |

**Occupants:** Lock-master Dregg.

> Worked, not lived-in. Named: lock-master Dregg. The under-clerk here keeps the OTHER tally — the real one, on ledger-paper, in charcoal.

#### VS-X02 · The Conduit Gallery
*Song-conduit service tunnel* — **r 260 m, a° 15**, footprint **70×5 m**, h 4 m, base y -10. Residents: **0**.

The Song does not fill the wedge's star-lamps by magic that tends itself. It is carried up this gallery in tuned crystal conduits that must be kept clean, aligned, and singing — hand-work, done in the dark, by people the light above never sees. When a lamp on the terrace 'simply burns,' someone down here made it.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 4×70×4 | the conduit run; access ladders up to each terrace's lamp-stems |
| Tuning niches (x4) | 3×3×3 | where conduit-wrights kneel to true the crystal |

**Occupants:** Conduit-wrights (crew of 6).

> Worked by conduit-wrights (mostly Terran). Thematically the literal machinery behind the Cold Open's 'the star-lamps burn without flame because the Song fills them.'

#### VS-X03 · The Deep-Wrights' Hall
*Terran bunk-hall & enclave* — **r 250 m, a° 24**, footprint **26×18 m**, h 6 m, base y -16. Residents: **44**.

Home and hall of the Terran stone-wrights who cut and maintain the Under-Terraces — the deep folk who literally hold the beautiful city up. Carved, warm with glow-stone, and prouder than anything on the rim. Durak Ironthought, the geomancer the Academy consults and the Houses condescend to, lodges here among his own kind when he is in Starfall.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | a communal hall; a long stone table; the deep-folk do not build separate boxes to eat in |
| Sleeping galleries | 22×6×3 | bunk-niches for ~40 wrights |
| Durak's cell | 5×5×4 | a plain stone room; a geomancer's tuning-forks and a basin of still water |
| The Shrine of Petrocore | 6×6×5 | a Stone-Voice shrine — the wrong god for this city, kept anyway |

**Occupants:** Durak Ironthought; The Deep-Wrights (43).

> Durak Ironthought (CH-011, PO-009) + ~43 Terran deep-wrights. Canonical anchor; explains why Durak argues 'we would build a basin' — he lives with the people who build.

#### VS-X04 · The Lift-Gang Bunks
*orc labour bunk-hall* — **r 235 m, a° 28**, footprint **20×14 m**, h 4 m, base y -18. Residents: **30**.

The bunk-hall of the orc lift-gangs who walk the lock capstans and carry what the barges bring. This is where the young Elorin, come down on some errand of theory, first SEES the labour the Academy is built on — the beat the Narrative Outline gives Ch2. Cruelty here is not spectacle; it is routine, and the routine is the point.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk rows | 16×10×4 | riveted double-bunks for ~30; no window, because there is no outside to have one onto |
| The Collar-room | 6×4×3 | where shift-tallies are logged; a quiet, bureaucratic horror |

**Occupants:** The Lift-Gang (30) — elder Ghesh.

> ~30 orc labourers. Named: the elder Ghesh, who counts. Foreshadows Part Two's Ashpile without stating it. Part of the unnamed 778 the whole game is about.

#### VS-X05 · The Underspill Canteen
*canteen / commons* — **r 248 m, a° 19**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The one warm shared room of the Under-Terraces: a canteen at the crossing of the galleries where deep-wrights, lift-gangs, conduit-crews and the occasional lost scholar eat the same grey, good stew. The real social heart of the wedge — the thing the Plate has no symbol for.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestle tables, a great range, a wall where the dead are chalked |
| Kitchen & store | 6×5×3 | run by the canteen-keeper |

**Occupants:** Mother Vesh + 3.

> Canteen-keeper Mother Vesh + 3 helpers (resident in a back nook). The cellar hatch of the Sounding-Glass (VS-K01) comes out near here — the only informal seam between the two cities.

#### VS-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 12**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

A small hard office at the foot of the stair up to the customs post — the point where the under-city answers to the over-city. The foreman is the only person who routinely crosses between the two maps, and is trusted by neither.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a lamp, a locked shift-book |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Adric.

> Foreman Adric — over-city clothes, under-city hands. A natural quest-broker character.

### Who lives here — the House Vael'Suran roster

Every NPC has a home. Named principals carry canon codes where they are canonical characters.

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Ysolde Vael'Suran | Noctari | Head of House Vael'Suran; Keeper of the Master Survey | The Vael'Suran Seat | The Gnomon Tower |
| First Reader Pan-Ostrel | Noctari | senior observer, the Gnomon Chamber | The Gnomon Tower | The Gnomon Tower |
| the junior computers (4) (×4) | Noctari | live-in calculating clerks | The Gnomon Tower | The Gnomon Tower |
| Ilvenor Vael'Suran | Noctari | Ysolde's heir, bored and dangerous with it | The Vael'Suran Seat | — |
| the near family (3) (×3) | Noctari | House family | The Vael'Suran Seat | — |
| the Seat household staff (13) (×13) | Noctari & 2 human | cook, chart-porters, lamp-tender, gate-keeper, maids | The Vael'Suran Seat | The Vael'Suran Seat |
| Sub-Magister Aeliston Vael'Suran | Noctari | cousin of the House; keeper of the running correction of the caldera's own sky | The Corrected Chart (the Open House) | The Corrected Chart (the Open House) |
| First Surveyor Halvenor Daskei | Noctari | commoner-born scholar who actually runs the survey | Sightline Villa — Halvenor | The Gnomon Tower |
| Renne Daskei & 4 (family) (×5) | Noctari | Halvenor's household | Sightline Villa — Halvenor | — |
| Magistra Ivrenne (née Vael'Suran, m. Corvane) | Noctari | void-adjacent scholar; the House's disowned-and-funded research | Sightline Villa — Corvane-in-marriage | Sightline Villa — Corvane-in-marriage |
| Astronomer Sarrent | Noctari | widowed scholar losing a sightline suit | Sightline Villa — the Widow Sarrent | Sightline Villa — the Widow Sarrent |
| Master-scribe Ovinn | Noctari | warden of the Scribes' Hall | The Scribes' Hall of the Fixed Stars | The Scribes' Hall of the Fixed Stars |
| Talindir — *CH-006/007, PO-004/005* | Noctari (elven) | apprentice scribe, the fastest and finest hand in the hall | The Scribes' Hall of the Fixed Stars | The Scribes' Hall of the Fixed Stars |
| Master optician Delu Marn + household (9) (×9) | Noctari | lens-grinders | The Lens-Grinders' Court | The Lens-Grinders' Court |
| Lesser Scholars' Row (22) (×22) | Noctari & 1 human household | reducers, correctors, lecture-assistants; sightless | Lesser Scholars' Row | — |
| Bruin Hale + house (5) (×5) | Noctari | innkeeper of the Sounding-Glass | The Sounding-Glass | The Sounding-Glass |
| The Instrument Market (34) (×34) | Noctari, 3 human, 1 Terran | brass-founders, tube-makers, engravers, a paper merchant | The Instrument Market | The Instrument Market |
| Serae the shrine-keeper | Noctari | keeper of the Deepening (Umbrion shrine) | The Deepening | The Deepening |
| Vara — *CH-010, PO-008* | Human | structural theorist on the Nullstone team; the wedge's best mind, worst room | Vara's Garret | D-ACADEMY |
| Lockside dwellings (38) (×38) | Noctari, some human | artisans, boatwrights, lamplighters, canal-workers | Canal Dwellings — Lockside | — |
| Customs officer Trell + 2 clerks (×3) | Noctari | weighs everything that comes up from below | Canal Dwellings — Lockside | The Processional Foot & Customs Post |
| Lock-master Dregg | Terran | runs Cael's Lock | The Deep-Wrights' Hall | Cael's Lock |
| Conduit-wrights (crew of 6) (×6) | Terran | keep the Song singing up to the star-lamps | The Deep-Wrights' Hall | The Conduit Gallery |
| Durak Ironthought — *CH-011, PO-009* | Terran (geomancer) | geomancer; Nullstone-team consultant; lodges among the deep-wrights | The Deep-Wrights' Hall | D-ACADEMY |
| The Deep-Wrights (43) (×43) | Terran | cut and hold up the Under-Terraces | The Deep-Wrights' Hall | — |
| The Lift-Gang (30) — elder Ghesh (×30) | Orc | walk the lock capstans; carry what the barges bring | The Lift-Gang Bunks | — |
| Mother Vesh + 3 (×4) | Orc | canteen-keeper of the Underspill | The Underspill Canteen | The Underspill Canteen |
| Foreman Adric | Human | the seam between the two cities; answers to the over-city, works the under | The Foreman's Post | The Foreman's Post |

### Population — House Vael'Suran (computed)

| Band | Souls |
|---|---|
| Rim / House seat | 26 |
| Upper terraces | 15 |
| Middle terraces | 45 |
| Canal quarter | 79 |
| Shore | 3 |
| Under-Terraces | 79 |
| **Total** | **247** |

> ≈ 247 souls in this wedge; **79 of them in the Under-Terraces**, on no official map. Target ≈ 333/wedge for a 3,000-soul city.

## House Serenthil — *Keepers of the Meridian* — structure by structure

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### SR-T01 · The Meridian Tower
*clock-and-bell tower (House seat, upper)* — **r 422 m, a° 340**, footprint **⌀22 m**, h 58 m, 6 storeys, base y 45. Residents: **6**.

Where Starfall's time is made and rung. Not a House hiding its instrument but a House whose instrument the whole city can hear — the nine bells that mark the hours, the ceremonies, and (a fact the rim prefers not to dwell on) the labour-shifts below. Vael'Suran keeps the eye; Serenthil keeps the ear.

| Room | Size (m) | Purpose |
|---|---|---|
| The Bell-Chamber | 14×14×12 | the nine verdigris bells in their frame; the ninth is the great one, rung only at the solstice count |
| The Clockwork Hall | 18×16×8 | the master escapement driven by star-water from the cistern below; a floor of turning brass |
| The Meridian Slit | 8×6×10 | a north-south roof-slit; noon is the instant a fixed star crosses it — time proved against the sky |
| Strike-Master's watch-room | 8×7×4 | someone watches the clock every hour of every night; the post is never empty |
| Ringers' loft & rope-race | 10×6×30 | the ropes drop from here — some to the belfry, some straight down into the dark to the shift-bells |

**Occupants:** Magister Toll Serenthil; Strike-Master Venn Ostreth; the Tower ringers & watch (4).

> Head + Strike-Master + 4 live-in ringers/watch-keepers. Its lit finial is one of the greybox's nine rim domes.

#### SR-M01 · The Serenthil Seat
*great house (manor)* — **r 438 m, a° 333**, footprint **30×20 m**, h 13 m, 3 storeys, base y 45. Residents: **18**.

Plainer than Vael'Suran's Seat and closer to the street — Serenthil money is civic money, made from keeping everyone's time, and the House wears its usefulness where the fixed-star grandees wear their view. Every room is on time; not one clock in it agrees to be wrong.

| Room | Size (m) | Purpose |
|---|---|---|
| The Striking Hall | 12×9×6 | reception; a wall of the House's retired clocks, each stopped at the hour of a death |
| Head's chambers | 9×7×4 | Magister Toll Serenthil's rooms |
| Family & apprentice rooms | 16×7×4 | family + two horology apprentices boarded in |
| Kitchen, stores, staff | 12×8×4 | household below and attic |

**Occupants:** the Serenthil family (5); the Seat household staff (11).

> Toll + family (5) + 2 boarded apprentices + 11 staff. Less grand, more lived-in than VS-M01.

### The Upper Terraces

#### SR-U01 · The Strike-Master's Villa
*senior officer's villa* — **r 370 m, a° 355**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

Home of the Strike-Master, the commoner-born officer who actually decides when the bells ring — a heavier hand on the city's day than most House heads. His sightline matters less to him than his hearing-line: he can tell a mistuned bell from three terraces off.

| Room | Size (m) | Purpose |
|---|---|---|
| The Listening Room | 9×7×5 | shuttered, bare, acoustically true; he checks the bells' pitch from here |
| Family rooms (x3) | 13×6×4 | the Strike-Master, spouse, 3 children |

**Occupants:** Venn Ostreth's household (5).

> Strike-Master Venn Ostreth + household.

#### SR-U02 · The Horologist's Villa
*senior scholar's villa* — **r 366 m, a° 347**, footprint **13×11 m**, h 9 m, 2 storeys, base y 34. Residents: **5**.

The villa of the House's chief horologist — the theorist of time itself, who argues that the Song has a beat and that a perfect clock would simply count it. Half the Academy thinks him a crank; the other half quietly borrows his figures.

| Room | Size (m) | Purpose |
|---|---|---|
| The Escapement Study | 9×7×4 | a study full of half-built regulators, each trying to find the Song's beat |
| Living rooms | 12×6×4 | the horologist + a companion + one apprentice |

**Occupants:** Chief Horologist Marn Ilve.

> Chief horologist Marn Ilve + household. Provides a theory-thread toward the Academy's Song-work.

#### SR-U03 · Sightline Villa — the Quiet House
*senior dwelling (let out)* — **r 372 m, a° 326**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **5**.

A Serenthil villa let, unusually, to a tenant from outside the House — an aged Noctari astronomer who wanted only quiet and a view, and pays for both. The House takes the coin and pretends the arrangement is temporary; it has been temporary for ninety years.

| Room | Size (m) | Purpose |
|---|---|---|
| The Study | 9×7×4 | an outsider's sightline, rented |
| Rooms | 12×6×4 | the tenant + a single servant |

**Occupants:** Tenant-astronomer Ollisan.

> Tenant-astronomer Ollisan + 4 (companion, servant, 2 boarders). A wedge with rented rooms reads differently from Vael'Suran's closed bloodline.

### The Middle Terraces

#### SR-L01 · The Bell-Foundry
*foundry + guild-hall* — **r 318 m, a° 349**, footprint **22×16 m**, h 10 m, 2 storeys, base y 23. Residents: **14**.

Loud, hot, and the opposite of everything the rim pretends to be: the wedge's bells and clock-brass are cast and tuned here. A bell is tuned by shaving metal from its inside until its note is true — a craft of subtraction, done by ear, over weeks. The most important trade in Serenthil and the least gentrified.

| Room | Size (m) | Purpose |
|---|---|---|
| The Casting Floor | 16×10×7 | the bell-pit, the furnace, the crane; a floor no scholar visits twice |
| The Tuning Bay | 8×6×5 | where a cast bell is shaved to its true note against a monochord |
| Founders' dwelling | 14×6×4 | the master founder's family above the heat |
| Journeymen's loft | 12×5×3 | boarded workers |

**Occupants:** Master founder Hessa Drun + household (14).

> Master founder Hessa Drun + family + 8 journeymen. The vent-flue drops to the under-forge (SR-X04).

#### SR-L02 · The Horologists' Hall
*guild-hall + workshop* — **r 312 m, a° 340**, footprint **20×13 m**, h 9 m, 3 storeys, base y 23. Residents: **9**.

The clockmakers: escapement-fitters, gear-cutters, dial-engravers, and the water-clock wrights who keep the city's public clepsydrae running. Fine, patient, indoor work — the bench-craft that turns the founder's raw brass into time.

| Room | Size (m) | Purpose |
|---|---|---|
| The Bench Floor | 16×8×5 | ranked benches under north light; a wall of running regulators for comparison |
| The Wheel-Cutting Room | 8×6×4 | the dividing engine that cuts gear-teeth — the Hall's guarded secret |
| Apprentices' dormitory | 14×5×3 | boarded apprentices |

**Occupants:** Guild-warden Pel Corriden + hall (9).

> Guild-warden Pel Corriden + 8 (fitters & apprentices).

#### SR-L03 · Lesser Timekeepers' Row
*terrace of 6 dwellings* — **r 300 m, a° 328**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **22**.

Six joined houses of the wedge's lesser timekeepers — the hour-callers, dial-readers, water-tenders and rope-boys who serve the Tower without ever entering the bell-chamber. Respectable, sightless, and paid in the House's steady, unglamorous coin.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: work-room + 2 chambers | 6×7×4 | 6 households |

**Occupants:** Lesser Timekeepers' Row (22) — hour-caller Renn.

> 6 households, ~22 souls. Named: hour-caller old Renn, whose voice the whole wedge wakes to.

### The Canal Quarter

#### SR-K01 · The Ninth Bell
*inn (Strain-relief haven)* — **r 268 m, a° 351**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **5**.

The wedge's inn, named for the great solstice bell you can feel in your chest from here — and the one place the day's timekeeping stops mattering. Rope-boys, off-shift founders, and the occasional deaf old ringer drink under a cracked bell hung over the bar. This wedge's Strain-relief haven.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, long tables, the cracked bell; a clock deliberately kept five minutes wrong, as a joke that is also a mercy |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above |
| Cellar | 8×6×3 | a canal-cooled store; a grille here opens onto the shift-bell undercroft — you hear the dark ringing through it |

**Occupants:** Innkeeper Wenna Kob + house (5).

> Innkeeper Wenna Kob + 2 family + 2 staff. The cellar grille is Serenthil's over/under seam (to SR-X01).

#### SR-K02 · The Clepsydra-Works
*waterworks + workshop* — **r 258 m, a° 344**, footprint **18×14 m**, h 8 m, 2 storeys, base y 12. Residents: **12**.

The public water-clocks of the whole city are built and regulated here, tapping the canal's star-water — the works that turns flowing water into counted time. A calm, dripping, faintly hypnotic place; its overflow feeds back to the canal, and its intake comes up from the Great Cistern below.

| Room | Size (m) | Purpose |
|---|---|---|
| The Flow Hall | 12×8×5 | tiered basins, float-gauges, the master clepsydra whose drip sets the Tower's water-drive |
| The Regulator Room | 8×6×4 | where flow is trimmed to a true hour |
| Wrights' dwelling | 12×5×4 | the water-wrights above |

**Occupants:** Water-warden Iss Vellun + works (12).

> Water-warden Iss Vellun + 11 (wrights & families). Mechanically ties the canal, the cistern and the Tower into one water-driven clock.

#### SR-K03 · Sera's Lodging
*rented rooms above the works* — **r 262 m, a° 357**, footprint **7×6 m**, h 3 m, 1 storeys, base y 20. Residents: **1**.

Two small rented rooms where Sera lodges — a Solari structural enchantress, a sun-elf alone in the night-city, on the Nullstone team and trusted by no faction on it. She chose the timekeepers' wedge on purpose: their bells are the one thing in Starfall that keep to a schedule she recognises, and she keeps a single forbidden sun-lamp she lights only when the shutters are closed.

| Room | Size (m) | Purpose |
|---|---|---|
| Work-room | 7×3×3 | structural models in silver wire; a Solari sun-disc turned to the wall |
| Sleeping room | 4×3×3 | a cot, a shuttered window, the sun-lamp |

**Occupants:** Sera.

> Sera (CH-008, PO-006) — 'the outsider's outsider.' Canonical Nullstone-team anchor in this wedge, deliberately mirroring Vara's garret in the Vael'Suran wedge.

#### SR-K04 · Canal Dwellings — Watergate
*tenement block, 8 dwellings* — **r 245 m, a° 330**, footprint **24×14 m**, h 11 m, 3 storeys, base y 12. Residents: **40**.

Dense canalside housing by the watergate, home to the rope-boys, water-tenders, dial-runners and canal-hands who keep the wedge's time-machinery fed and moving. The block wakes to old Renn's hour-call and sleeps to the ninth-of-night bell.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 8 dwellings, families of 3-6 |

**Occupants:** Watergate dwellings (40) — the widow Ferrun.

> ~40 souls. Named: the widow Ferrun, whose late husband fell from the belfry, and who counts every bell since.

#### SR-K05 · The Hour-Market
*market row (timed)* — **r 252 m, a° 336**, footprint **28×10 m**, h 6 m, 2 storeys, base y 12. Residents: **22**.

A market that opens and closes to the bell — nine stalls and shops selling by strict tolled hours (a Serenthil custom, and a small tyranny): a baker, a dial-shop, a candle-and-oil merchant, a rope-walk, a cook-stall, a scrivener, a herbalist. Live-over-the-shop trade timed to the death by the very House that sells them the clocks.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + room above | 3×8×4 | 9 units, most with a family above |

**Occupants:** The Hour-Market (22) — the baker Doln.

> 9 shops, ~22 souls. Named: the baker Doln, who bribes a rope-boy to ring his opening a half-minute early.

### The Shore & Processionals

#### SR-S01 · The Bell-Gate & Processional Foot
*civic threshold* — **r 228 m, a° 357**, footprint **14×10 m**, h 7 m, 1 storeys, base y 0. Residents: **0**.

Where the Grand Processional meets the shore on Serenthil's side: a gate with its own small bell that opens and closes the processional to ceremony, and a customs post twinned with Vael'Suran's across the way. The two Houses' gate-bells answer each other across the stair — the city's front door, in stereo.

| Room | Size (m) | Purpose |
|---|---|---|
| The Gate Hall | 10×7×5 | the gate-bell rope, a tally-desk, a warded night-strongroom |
| Gatekeepers' room | 5×4×4 | the gate-warden and a clerk |

**Occupants:** Gate-warden Ospren + clerk.

> Gate-warden Ospren + clerk (day post; counted at their canal homes).

### The Under-Terraces

#### SR-X01 · The Shift-Bell Undercroft
*under-belfry (service)* — **r 250 m, a° 340**, footprint **16×14 m**, h 8 m, base y -12. Residents: **8**.

The dark twin of the bell-chamber. The same ropes that ring the festival's ninth bell drop through the whole city to here, where under-ringers pull the SHIFT-bells that govern the labour below — the cistern-gangs, the bell-wrights, the lift-crews. To the rim, the bell is glory; to the dark, the identical bell is a whip you can hear but not see. Serenthil rings both and calls it one service.

| Room | Size (m) | Purpose |
|---|---|---|
| The Under-Belfry | 12×8×8 | the shift-bells and the drop-ropes; a board chalked with the shift-count |
| Under-ringers' bunk | 10×5×3 | the ringers live at their ropes; they have not seen a festival in years |

**Occupants:** The Under-Ringers (8).

> Under-ringer crew (8). The Sounding-metaphor made literal: one bell, two meanings, and only the dark hears both. The Ninth Bell inn's cellar grille opens near here.

#### SR-X02 · The Clock-Water Gallery
*conduit + water-race gallery* — **r 260 m, a° 345**, footprint **68×5 m**, h 4 m, base y -10. Residents: **6**.

Twin runs in one gallery: the tuned Song-conduits that feed this wedge's star-lamps (as under Vael'Suran) AND the star-water race that carries the Great Cistern's water up to the clepsydra-works and the Tower's clock-drive. When a lamp burns or a clock ticks on the terraces above, its cause is in this tunnel, tended in the dark.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 5×68×4 | conduit + water-race side by side; access ladders to each terrace |
| Sluice niches (x3) | 3×3×3 | where water-wrights set the race's flow |

**Occupants:** The Conduit-and-Race Crew (6).

> Conduit-and-race crew (6, mixed Terran & human). The literal plumbing of both light and time.

#### SR-X03 · The Great Cistern
*reservoir (novel civic works)* — **r 245 m, a° 335**, footprint **40×34 m**, h 12 m, base y -26. Residents: **12**.

Starfall's hidden heart of star-water: a vast pillared vault of black, still, faintly-starred water that drives every clock, feeds every canal-lock, and cools the whole under-city — a subterranean night sky underneath the lake that is a night sky. The single most impressive space in Starfall, and it is on no map, because the people who need it are not on the map either. Reached by boat across its own black surface.

| Room | Size (m) | Purpose |
|---|---|---|
| The Vault | 34×28×12 | forty stone pillars standing in still water; a rowed jetty; the water doubles the lamplight into a false depth |
| The Pump-Floor | 12×8×4 | the great treadwheel pumps that lift water to the race — walked by the cistern-gangs |
| Keepers' rooms | 8×6×3 | the cistern-keepers, who live beside the water and learn to read its level like a face |

**Occupants:** The Cistern-Keepers & pump-crew (12) — keeper Mave.

> Cistern-keepers + pump-crew (12). The wedge's 'novel and unique' landmark — a cathedral of dark water no citizen above has ever seen. Strong future hero-set-piece.

#### SR-X04 · The Bell-Wrights' & Cistern-Gangs' Hall
*mixed bunk-hall & under-forge* — **r 250 m, a° 330**, footprint **30×20 m**, h 6 m, base y -18. Residents: **46**.

The largest under-dwelling of the wedge: Terran bell-wrights (who tune the shift-bells and cast the clock-brass at an under-forge the foundry's flue feeds) alongside the human and orc cistern-gangs who walk the pumps. A rare mixed hall — the Song does not reach here, so the races that the city above keeps carefully apart share one warm, loud, glow-lit room.

| Room | Size (m) | Purpose |
|---|---|---|
| The Under-Forge | 12×8×6 | a small casting floor fed by the Bell-Foundry's flue; shift-bells are born and tuned here |
| The Long Hall | 16×8×5 | shared eating-and-living hall; a Petrocore shrine and a scratched orc tally-board share a wall |
| Sleeping galleries | 26×6×3 | bunk-niches for ~46 wrights and gang-hands |

**Occupants:** The Bell-Wrights (30) — under-founder Kragg; The Cistern-Gangs (16).

> ~30 Terran bell-wrights + ~16 human/orc cistern-gang. The mixed hall varies the texture from Vael'Suran's segregated Terran/orc halls, and is a natural place for a cross-race scene.

#### SR-X05 · The Undertoll Canteen
*canteen / commons* — **r 248 m, a° 342**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The under-city's warm room for this wedge, named for the toll-bell that calls its meal-shifts. Under-ringers, cistern-gangs, bell-wrights and conduit-crews eat here between shifts; the canteen-keeper rings her own small bell for meals and, once a year, quietly rings it nine times for the dead.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, a wall of chalked names |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Canteen-keeper Old Sable + 3.

> Canteen-keeper Old Sable + 3 helpers. Sister-room to Vael'Suran's Underspill; the two under-canteens know each other's runners.

#### SR-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 348**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office of Serenthil's under-city, at the foot of the stair up to the Bell-Gate — where the shift-count is reconciled against the toll and sent up to the House. The foreman keeps time for people the timekeepers never count.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a shift-book, a small answering bell wired to the undercroft |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Quill.

> Foreman Quill — keeps the honest count in charcoal and the House's count in ink, and knows they differ.

### Who lives here — the House Serenthil roster

Every NPC has a home. Named principals carry canon codes where they are canonical characters.

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Toll Serenthil | Noctari | Head of House Serenthil; Keeper of the Meridian | The Serenthil Seat | The Meridian Tower |
| Strike-Master Venn Ostreth | Noctari | commoner-born officer who decides when the bells ring | The Strike-Master's Villa | The Meridian Tower |
| the Tower ringers & watch (4) (×4) | Noctari | live-in bell-ringers and clock-watchers | The Meridian Tower | The Meridian Tower |
| the Serenthil family (5) (×7) | Noctari | House family + 2 boarded horology apprentices | The Serenthil Seat | — |
| the Seat household staff (11) (×11) | Noctari & 2 human | cook, clock-keeper, porters, maids | The Serenthil Seat | The Serenthil Seat |
| Venn Ostreth's household (5) (×5) | Noctari | the Strike-Master's spouse & 3 children | The Strike-Master's Villa | — |
| Chief Horologist Marn Ilve (×5) | Noctari | theorist of time; argues the Song has a beat a perfect clock would count | The Horologist's Villa | The Horologist's Villa |
| Tenant-astronomer Ollisan (×5) | Noctari | outside tenant of a Serenthil villa; wanted only quiet and a view | Sightline Villa — the Quiet House | Sightline Villa — the Quiet House |
| Master founder Hessa Drun + household (14) (×14) | Noctari | runs the Bell-Foundry; tunes bells by ear over weeks | The Bell-Foundry | The Bell-Foundry |
| Guild-warden Pel Corriden + hall (9) (×9) | Noctari | clockmakers' guild; keeps the dividing engine's secret | The Horologists' Hall | The Horologists' Hall |
| Lesser Timekeepers' Row (22) — hour-caller Renn (×22) | Noctari, 1 human household | hour-callers, dial-readers, water-tenders, rope-boys | Lesser Timekeepers' Row | — |
| Innkeeper Wenna Kob + house (5) (×5) | Noctari | keeps The Ninth Bell | The Ninth Bell | The Ninth Bell |
| Water-warden Iss Vellun + works (12) (×12) | Noctari | runs the Clepsydra-Works; regulates the city's water-clocks | The Clepsydra-Works | The Clepsydra-Works |
| Sera — *CH-008, PO-006* | Solari (sun elf) | structural enchantress on the Nullstone team; a sun-elf alone in the night-city | Sera's Lodging | D-ACADEMY |
| Watergate dwellings (40) — the widow Ferrun (×40) | Noctari, some human | rope-boys, water-tenders, dial-runners, canal-hands | Canal Dwellings — Watergate | — |
| The Hour-Market (22) — the baker Doln (×22) | Noctari, 2 human | baker, dial-shop, chandler, rope-walk, cook-stall, scrivener, herbalist | The Hour-Market | The Hour-Market |
| Gate-warden Ospren + clerk (×2) | Noctari | works the Bell-Gate; twin to Vael'Suran's customs across the stair | Canal Dwellings — Watergate | The Bell-Gate & Processional Foot |
| The Under-Ringers (8) (×8) | Noctari & human | pull the shift-bells that govern the labour below | The Shift-Bell Undercroft | The Shift-Bell Undercroft |
| The Conduit-and-Race Crew (6) (×6) | Terran & human | keep the Song-conduits and the clock-water race | The Bell-Wrights' & Cistern-Gangs' Hall | The Clock-Water Gallery |
| The Cistern-Keepers & pump-crew (12) — keeper Mave (×12) | Terran, human, orc | tend the Great Cistern; walk the treadwheel pumps; read the water-level like a face | The Great Cistern | The Great Cistern |
| The Bell-Wrights (30) — under-founder Kragg (×30) | Terran | cast and tune the shift-bells and clock-brass at the under-forge | The Bell-Wrights' & Cistern-Gangs' Hall | — |
| The Cistern-Gangs (16) (×16) | human & orc | walk the pumps; haul; the muscle of the water-system | The Bell-Wrights' & Cistern-Gangs' Hall | — |
| Canteen-keeper Old Sable + 3 (×4) | Orc | keeps the Undertoll Canteen | The Undertoll Canteen | The Undertoll Canteen |
| Foreman Quill | Human | the seam of Serenthil's under-city; reconciles the shift-count to the toll | The Foreman's Post | The Foreman's Post |

### Population — House Serenthil (computed)

| Band | Souls |
|---|---|
| Rim / House seat | 24 |
| Upper terraces | 16 |
| Middle terraces | 45 |
| Canal quarter | 80 |
| Shore | 0 |
| Under-Terraces | 77 |
| **Total** | **242** |

> ≈ 242 souls in this wedge; **77 of them in the Under-Terraces**, on no official map. Target ≈ 333/wedge for a 3,000-soul city.

---

**City so far:** 2 of 9 wedges fully specified — **≈ 489 souls placed, every one with a home.** Remaining: House Nyx'Talar, House Oravelle, House Sabreth, House Ilmyra, House Corvane, House Duskmere, the dead House, and the Academy island. The schema and generators already carry them — they only need their structures and NPCs authored.

> **Design note.** Wedges must not read as clones. Vael'Suran = the eye, pride, protected sightlines, a closed bloodline. Serenthil = the ear, the hour, civic utility, rented rooms, a mixed under-city. Each further House should get its own social texture from its celestial domain.
