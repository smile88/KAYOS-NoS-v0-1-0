# Starfall — City Codex

> _Generated from `docs/city/starfall_city.json` by `tools/gen_starfall_codex.py`. Do not hand-edit — edit the JSON and re-run. Companion map: `art/blueprints/Starfall_CityPlan.svg`._

**Second city of the Noctari, seat of the Academy of Astral Harmony**  
*Part One — The Architect, c. 1450 AO (Age of Order, the city alive)* · population target **3,000** · Noctari (night elf); Umbrion-aligned; scholars of the heavens

**The theme (read this first).** Two maps of one city. The Plate (this visible survey) and the Ledger-map beneath it (the Under-Terraces) do not contain each other. That omission is the story of Part One.

**Coordinates.** polar around the caldera centre (0,0). r = metres from centre; a_deg = degrees where 0 = +Z (front / the Grand Processional & causeway), increasing toward +X. world x = r*sin(a), z = r*cos(a). y = terrace top height (metres). Screen/plate angle = 180 - a_deg.

**Status.** FOUNDATION + exemplar wedge (House Vael'Suran) fully specified; other eight Houses stubbed. Geometry LOCKED to godot/threed/StarfallCity3D.gd & docs/Scale_Reference.md.

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

Each rim observatory tower is a House — an astronomical dynasty that owns the wedge of city below it. One is dead. The exemplar wedge fully specified below is **House Vael'Suran**; the other eight are stubbed (name, domain, wedge) and rolled out next.

| ID | House | Epithet | Domain | Tower a° | Wedge a° | Status |
|---|---|---|---|---|---|---|
| H0 | House Vael'Suran ★ | Keepers of the Fixed Stars | The unmoving stars; the master survey from which every sight… | 20 | 0–40 | living |
| H1 | House Nyx'Talar | Wardens of the Occultation | Eclipses, transits, and every moment one light passes behind… | 60 | 40–80 | living |
| H2 | House Oravelle | Trackers of the Wanderers | The wandering lights (planets); ephemerides and prediction. … | 100 | 80–120 | living |
| H3 | House Sabreth | Readers of the Long-Haired Stars | Comets and omens; the House everyone consults and no one adm… | 140 | 120–160 | living |
| H4 | House Ilmyra | Keepers of the Tides of the Song | The moons and the slow tides the Song makes in all things; t… | 180 | 160–200 | living |
| H5 | House Corvane | Scholars of the Deep Field | The dark between the stars — the void itself. The most Umbri… | 220 | 200–240 | living |
| H6 | House ———— | the Dead House | Unknown / struck from the record. Its dome is dark, its sigi… | 260 | 240–280 | dead |
| H7 | House Duskmere | Watchers of the Horizon | The twilight band, risings and settings, the last and first … | 300 | 280–320 | living |
| H8 | House Serenthil | Keepers of the Meridian | The meridian and the hour; timekeepers of Starfall. They rin… | 340 | 320–360 | living |

★ = fully specified this pass.

### House Vael'Suran — *Keepers of the Fixed Stars* (H0)
- **Domain:** The unmoving stars; the master survey from which every sightline in Starfall is measured. The eldest and proudest House; its charts are the city's ground truth.
- **Sigil:** a silver gnomon crossed by a single fixed star, on indigo
- **Wedge:** a° 0–40, tower at a° 20 · **living**

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
- **Domain:** The meridian and the hour; timekeepers of Starfall. They ring the bells, including the ninth-bell count of every Luminarae. Flanks the Grand Processional opposite Vael'Suran.
- **Sigil:** a vertical silver meridian line through a single gold point
- **Wedge:** a° 320–360, tower at a° 340 · **living**

## House Vael'Suran — the exemplar wedge, structure by structure

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

## Who lives here — the House Vael'Suran roster

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

## Population — this wedge

| Band | Souls |
|---|---|
| Rim House | 26 |
| Upper Terraces | 20 |
| Middle Terraces | 45 |
| Canal Quarter | 82 |
| Shore | 0 |
| Under Terraces | 128 |
| **Total** | **301** |

> ≈ 301 souls in House Vael'Suran's wedge (target ~333/wedge for a 3,000-city). The Under-Terraces hold nearly as many as the visible quarter above them, and appear on no official map — which is the whole point.

---

*Next: roll the same treatment across the other eight Houses (H1–H8), then the Academy island (D-ACADEMY) and the Mirror/causeway. The generator and schema already carry them — they only need their structures and NPCs authored.*
