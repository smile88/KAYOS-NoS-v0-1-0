# Starfall — City Codex

> _Generated from `docs/city/starfall_city.json` + `docs/city/wedges/*.json` by `tools/gen_starfall_codex.py` (via `build_city.py`). Do not hand-edit — edit the data and re-run. Companion map: `art/blueprints/Starfall_CityPlan.svg`._

**Second city of the Noctari, seat of the Academy of Astral Harmony**  
*Part One — The Architect, c. 1450 AO (Age of Order, the city alive)* · population target **3,000** · Noctari (night elf); Umbrion-aligned; scholars of the heavens

**The theme (read this first).** Two maps of one city. The Plate (this visible survey) and the Ledger-map beneath it (the Under-Terraces) do not contain each other. That omission is the story of Part One.

**Coordinates.** polar around the caldera centre (0,0). r = metres from centre; a_deg = degrees where 0 = +Z (front / the Grand Processional & causeway), increasing toward +X. world x = r*sin(a), z = r*cos(a). y = terrace top height (metres). Screen/plate angle = 180 - a_deg.

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

Each rim observatory tower is a House — an astronomical dynasty that owns the wedge of city below it. One is dead. Wedges are deliberately *not* clones — each takes its social texture from its celestial domain.

| ID | House | Epithet | Domain | Tower a° | Wedge a° | Status |
|---|---|---|---|---|---|---|
| H0 | House Vael'Suran ★ | Keepers of the Fixed Stars | The unmoving stars; the master survey from which every sig… | 20 | 0–40 | living |
| H1 | House Nyx'Talar ★ | Wardens of the Occultation | Eclipses, transits, and every moment one light passes behi… | 60 | 40–80 | living |
| H2 | House Oravelle ★ | Trackers of the Wanderers | The wandering lights (planets); ephemerides and prediction… | 100 | 80–120 | living |
| H3 | House Sabreth ★ | Readers of the Long-Haired Stars | Comets and omens; the House everyone consults and no one a… | 140 | 120–160 | living |
| H4 | House Ilmyra ★ | Keepers of the Tides of the Song | The moons and the slow tides the Song makes in all things;… | 180 | 160–200 | living |
| H5 | House Corvane ★ | Scholars of the Deep Field | The dark between the stars — the void itself. The most Umb… | 220 | 200–240 | living |
| H6 | House ———— ★ | the Dead House | Unknown / struck from the record. Its dome is dark, its si… | 260 | 240–280 | dead |
| H7 | House Duskmere ★ | Watchers of the Horizon | The twilight band, risings and settings, the last and firs… | 300 | 280–320 | living |
| H8 | House Serenthil ★ | Keepers of the Meridian | The meridian and the hour; timekeepers of Starfall. They r… | 340 | 320–360 | living |

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
- **Domain:** The meridian and the hour; timekeepers of Starfall. They ring the bells, including the ninth-bell count of every Luminarae — and the same bells that toll the festival toll the labour-shifts in the dark below. The House the whole city depends on and none reveres: a utility, not a glory. Flanks the Grand Processional opposite Vael'Suran.
- **Sigil:** a vertical silver meridian line through a single gold point
- **Wedge:** a° 320–360, tower at a° 340 · **living**

## House Vael'Suran — *Keepers of the Fixed Stars*
*structure by structure*

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

### Who lives here — roster (28 records)

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

| Band | Souls |
|---|---|
| Rim / House seat | 26 |
| Upper terraces | 15 |
| Middle terraces | 45 |
| Canal quarter | 79 |
| Shore | 3 |
| Under-Terraces | 79 |
| **Total** | **247** |

> ≈ 247 souls here; **79 of them in the Under-Terraces**, on no official map.

## House Nyx'Talar — *Wardens of the Occultation*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### NX-T01 · The Umbral Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 60**, footprint **⌀22 m**, h 55 m, 6 storeys, base y 45. Residents: **7**.

Where the House measures the exact instant one light passes behind another — an eclipse, a transit, an occultation — and, from that, the exact instant of everything else. The instruments here can time a shadow to the breath; the House long ago learned that whoever owns the timing of a concealment owns the concealment. Its readings are never published entire.

| Room | Size (m) | Purpose |
|---|---|---|
| The Occultation Hall | 20×20×8 | the ground instrument floor; a wall of shuttered apertures opened one at a time |
| The Timed Vault | 10×8×4 | a lead-lined room of dated observations; each is a record of who or what was hidden, and precisely when |
| Head's shuttered study | 8×7×4 | Magister Suvane's study; the only window in the House that is never opened by day |
| Reckoners' room | 12×8×4 | juniors reduce the eclipse-tables; taught to forget the names attached to the timings |
| The Shadow-Chamber | 12×12×10 | top floor; a single north aperture and a graduated dark-glass; the reading is taken alone, always alone |
| Servants' stair & lamp-room | 4×4×30 | the spiral stair; the dome's finial is lit but hooded, so it shows as the dimmest of the nine |

**Occupants:** First Occulter Dess; the live-in reckoners (6).

> First Occulter + 6 live-in reckoners. Alone of the nine rim domes, its lit finial is deliberately hooded — the House prefers to be the one watching, not the one seen.

#### NX-M01 · The Shuttered Seat
*great house (manor)* — **r 438 m, a° 54**, footprint **32×22 m**, h 14 m, 3 storeys, base y 45. Residents: **17**.

The living seat of the House — and the only rim manor whose principal rooms face away from the Mirror. Nyx'Talar built to see the terraces below, not the lake: a house that watches the city more attentively than it watches the sky. Every window has an inner shutter, and the shutters are the point.

| Room | Size (m) | Purpose |
|---|---|---|
| The Hall of Screens | 14×10×7 | reception behind carved lattices; guests are seen long before they are received |
| Suvane's chambers | 10×8×4 | the head's rooms; a listening-tube to the gate-lodge runs behind the wall |
| Family wing | 16×8×4 | chambers for the near family, each with its own lock |
| The Muffled Room | 10×8×5 | a felt-hung room where the House says aloud the things it will say nowhere else |
| Kitchen & stores | 10×7×4 | below the hall |
| Staff quarters | 12×6×4 | attic rooms; the staff are chosen for what they can be trusted not to repeat |

**Occupants:** Magister Suvane Nyx'Talar; the Nyx'Talar near family (5); the Shuttered Seat staff (11).

> Suvane + near family (5) + 11 household staff. The Seat faces the city, not the sky — the whole House's character in one architectural decision.

### The Upper Terraces

#### NX-U01 · The Villa Behind the Lattice
*senior warden's villa* — **r 370 m, a° 68**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **5**.

Home of a senior Warden of the House, and shuttered so completely that neighbours cannot say whether anyone is home from one month to the next. Its protected sightline is real and legally registered, but the shutters over it are almost never drawn — a sightline held as an asset, not used as a view.

| Room | Size (m) | Purpose |
|---|---|---|
| The Registered Study | 9×7×4 | the sightline is on file; the shutter over it has a dust-seal that has not been broken in years |
| Family rooms | 13×6×4 | Warden Ottress and household |

**Occupants:** Warden Ottress + household (5).

> Warden Ottress + household of 5. A villa that hoards a view it will not spend — the local definition of wealth.

#### NX-U02 · The Second Warden's Villa
*senior scholar's villa* — **r 366 m, a° 62**, footprint **15×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

The household of the Second Warden — the House officer who, on paper, catalogues transits, and, off paper, arranges that certain observations are never made. The most-visited villa on the terrace after dark, though its visitors come by the back stair and are never seen to arrive.

| Room | Size (m) | Purpose |
|---|---|---|
| The Cataloguing Room | 10×7×4 | the ostensible work; ledgers of who observed what and when |
| The Back Parlour | 8×6×4 | the real work; a room reached only from the servants' stair |
| Family rooms | 13×6×4 | Warden Coreth and household |

**Occupants:** Warden Coreth + household (6).

> Warden Coreth + household of 6. The House's discreet fixer; a rich vein of side-content — every favour has a timing, and a price paid in silence.

#### NX-U03 · The Kept Villa
*senior dwelling (maintained tenancy)* — **r 372 m, a° 74**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **4**.

A villa the House maintains for the widow Halissa — not of Nyx'Talar blood, but of Nyx'Talar knowledge. She saw something, once, at an occultation, and has been comfortably, silently kept ever since. She has never been asked to leave, and understands perfectly why.

| Room | Size (m) | Purpose |
|---|---|---|
| The Quiet Study | 9×7×4 | a sightline she was granted and does not use; she prefers the shutters |
| Rooms | 12×6×4 | Halissa, a companion, a House-appointed servant who is also a watcher |

**Occupants:** the widow Halissa + household (4).

> Halissa + household of 4 (one of whom reports to the Seat). Kept comfortable to be kept quiet — the House's method in one household.

#### NX-U04 · The Furnished Absence
*villa (maintained empty)* — **r 368 m, a° 47**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **1**.

A villa kept fully furnished, warmed, dusted, and empty — a House property held ready for a guest who is never named in advance and never stays twice. A single caretaker lives in the back rooms and asks nothing. On the Plate it is a dwelling like any other; in truth it is a room the House keeps so that certain meetings can happen at an address that belongs to no one.

| Room | Size (m) | Purpose |
|---|---|---|
| The Ready Rooms | 12×7×4 | kept warm and made up; a decanter always full, a fire always laid |
| Caretaker's rooms | 8×5×4 | the one soul who lives here, and forgets faces professionally |

**Occupants:** Caretaker Pell.

> Caretaker Pell alone. A furnished alibi — the wedge's quiet novelty at ground level, before you even reach the Hall of Occultations below.

### The Middle Terraces

#### NX-L01 · The Sealwrights' Hall
*guild-hall + lodging* — **r 316 m, a° 66**, footprint **22×14 m**, h 11 m, 3 storeys, base y 23. Residents: **13**.

Wax, lead, wire and cipher: the makers of the city's seals and locks work here, and the House that owns them makes very sure the trade stays in the wedge. A seal is a promise that a thing was not opened; Nyx'Talar built its fortune on being the people you trust to certify that a thing stayed shut.

| Room | Size (m) | Purpose |
|---|---|---|
| The Sealing Floor | 20×8×5 | matrices, melting-pots, the die-safe; each sealwright's dies are numbered and never leave |
| The Cipher Room | 8×6×4 | where letter-locks and cipher-wheels are cut for private clients |
| Master's dwelling | 14×6×4 | the master sealwright's family above the floor |
| Journeymen's loft | 12×5×3 | boarded sealwrights, oathbound |

**Occupants:** Master-sealwright Ordell Craze + hall (13).

> Master-sealwright Ordell Craze + 12 (family & oathbound journeymen). Every wax seal in Starfall's official post is struck from a die kept in this room.

#### NX-L02 · The Sealed Copyists
*scriptorium (confidential)* — **r 320 m, a° 58**, footprint **20×13 m**, h 9 m, 2 storeys, base y 23. Residents: **9**.

Discreet copyists who reproduce documents they are trained not to read — contracts, testaments, sealed depositions, the occasional thing that must exist in exactly two copies and no third. They work at screened desks, each blind to the next, and are paid partly in coin and partly in the House's protection.

| Room | Size (m) | Purpose |
|---|---|---|
| The Screened Floor | 16×8×5 | single desks in felt booths; a copyist never sees the whole of what they copy |
| The Warden's window | 4×4×4 | the overseer sees every desk and every desk knows it |
| Copyists' dormitory | 14×5×3 | boarded copyists, sworn to the House |

**Occupants:** the Sealed Copyists (9).

> Overseer plus 8 copyists. The honest twin of the Sealwrights: one House makes the thing that stays shut, the other makes the thing that quietly exists twice.

#### NX-L03 · Lesser Wardens' Row
*terrace of 6 small dwellings* — **r 300 m, a° 72**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **22**.

Six joined houses of the wedge's lesser wardens — the watchers without a sightline, who keep the House's real survey: not of the stars, but of the streets. Who came up the Processional and when; whose shutters opened; which barge ran late. Sightless, respectable, and never off duty.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: watch-room + 2 chambers | 6×7×4 | each of the 6 houses: a front room with a good view of the stair, and two chambers behind |

**Occupants:** Lesser Wardens' Row (22) — Nessa Ptol.

> 6 households, ~22 souls. Named principal: the ledger-warden Nessa Ptol, who has a memory for faces the House cannot afford to lose.

### The Canal Quarter

#### NX-K01 · The Blind Eye
*inn (Strain-relief haven)* — **r 268 m, a° 64**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **5**.

The wedge's inn, and the one place in the House of watchers where, by long custom, no one is watched. The rule is enforced by the innkeeper and honoured by everyone, because a city this observed needs exactly one room in which to be unseen. This quarter's Strain-relief haven.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, deep booths, the painted-over eye above the bar that gives the place its name and its promise |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above; the register records only false names, on purpose |
| Cellar | 8×6×3 | canal-cooled store; a low door, never mentioned, that opens toward the under-galleries |

**Occupants:** Mistress Oll + house (5).

> Innkeeper Mistress Oll (one-eyed, and pointed about it) + 2 family + 2 staff. The cellar door is the wedge's over/under seam.

#### NX-K02 · The Unlabelled Market
*market row (discreet goods)* — **r 258 m, a° 57**, footprint **30×10 m**, h 6 m, 2 storeys, base y 12. Residents: **30**.

Ten shopfronts, and not one of them a painted sign — you are meant to already know which door you want. Letter-writers, a lock-fitter, a dealer in second-hand seals, a discreet apothecary, a fence who calls himself a valuer, and a tea-house where introductions are made. Live-over-the-shop trade, conducted at a murmur.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + workshop + room above | 3×8×4 | 10 units, most with a family living above; the signless door is the local etiquette |

**Occupants:** the Unlabelled Market (30) — the 'valuer' Sim Onrey.

> 10 shops, ~30 souls. Named: the 'valuer' Sim Onrey, who can find the owner of anything for a fee, and the letter-writer old Fenn.

#### NX-K03 · The Shrine of the Passing Shadow
*shrine (Umbrion)* — **r 250 m, a° 70**, footprint **12×12 m**, h 9 m, 1 storeys, base y 12. Residents: **1**.

An Umbrion shrine kept by Nyx'Talar custom: not merely dark, but built around a single slow aperture that lets one blade of star-lamp light cross the floor and pass, once, each night. You come to watch the light be hidden — to practise, the House would say, the one grace it truly believes in: that some things are meant to pass out of sight and be let go.

| Room | Size (m) | Purpose |
|---|---|---|
| The Transit Cell | 8×8×7 | the moving blade of light and the long dark on either side of it; you sit and watch it occulted |
| Keeper's cell | 4×4×3 | the shrine-keeper's room |

**Occupants:** Keeper Threnn.

> Keeper Threnn, who has watched the same blade of light vanish for a hundred and forty years and calls it the only honest clock in the city.

#### NX-K04 · Canal Dwellings — Shutterside
*block of common dwellings* — **r 245 m, a° 50**, footprint **24×14 m**, h 11 m, 3 storeys, base y 12. Residents: **38**.

Dense canalside housing named for its most-remarked feature: every window has a shutter, and on this stretch the shutters stay closed even in warm weather. Home to the wedge's boatwrights, runners, sealwrights' families and market-hands — folk who have learned that the House rewards those who see much and say little.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 8 dwellings, families of 3-6 |

**Occupants:** Shutterside dwellings (38) — Corra Sel.

> ~38 souls. Named: the boatwoman Corra Sel, who runs the night-barge and knows which cargoes are never weighed.

#### NX-K05 · The Watcher's Rooms
*rented rooms over a shop* — **r 262 m, a° 76**, footprint **7×6 m**, h 3 m, 1 storeys, base y 20. Residents: **2**.

Two rented rooms taken by a professional watcher — a freelance who sells the House what its lesser wardens miss. The window commands the canal-mouth and the foot of the terrace stair; the rooms hold a chair, a good glass, and a wall of dated notes in a private shorthand no one else can read.

| Room | Size (m) | Purpose |
|---|---|---|
| The Watching Room | 7×3×3 | one chair, one glass, one window that sees the whole approach |
| Sleeping room | 4×3×3 | a cot; the watcher sleeps by day and works the dark |

**Occupants:** the watcher Aline Voss + apprentice.

> The watcher Aline Voss + an apprentice she is training to disappear. A freelance eye the House uses and does not quite trust — a quest-broker with her own agenda.

### The Shore & Processionals

#### NX-S01 · The Watch-Customs
*civic threshold (customs + watch)* — **r 228 m, a° 56**, footprint **14×10 m**, h 7 m, 2 storeys, base y 0. Residents: **3**.

The wedge's customs post, and unlike its neighbours' it is staffed around the clock — because Nyx'Talar cares less what a cargo weighs than who is standing next to it. Everything that comes up from below is weighed here; everyone that comes up is noted. The watch lives above the scales, so the door is never unmanned.

| Room | Size (m) | Purpose |
|---|---|---|
| The Weighing Hall | 10×7×4 | scales, tally-desks, a wardsealed strongroom, and a second ledger that records faces, not freight |
| The Watch-loft | 8×5×4 | the live-in watch; a window onto the shore that is never dark |

**Occupants:** Watch-officer Delm + 2 clerks.

> Watch-officer Delm + 2 clerks, resident above the scales (unlike the day-only posts of other wedges). The House's official eye on the one door up from the under-city.

### The Under-Terraces

#### NX-X01 · The Silent Lock
*barge lock (service)* — **r 240 m, a° 61**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

The wedge's barge lock, greased and counter-weighted so that it runs without the crash and clang of the others — Nyx'Talar's cargoes prefer to arrive without announcing themselves. It lifts the ordinary stone and grain of the quarter, and, on certain nights, one crate more that is not on the manifest and is never weighed at the post above.

| Room | Size (m) | Purpose |
|---|---|---|
| The Muffled Chamber | 20×8×14 | the lock basin; the gates run on felted rollers so a lift can be made at midnight and heard by no one |
| The Capstan Floor | 12×8×4 | walked by the lift-gang; the overseer here logs everything except what he is paid to forget |
| The Off-Manifest Niche | 4×4×3 | a walled recess for the crate that has no paper |

**Occupants:** Lock-master Bront.

> Worked, not lived-in. Lock-master Bront (homes in the Warren). The quietest lock in Starfall, by design — the throat of the wedge's unseen economy.

#### NX-X02 · The Listening Gallery
*Song-conduit + acoustic gallery* — **r 260 m, a° 54**, footprint **68×5 m**, h 4 m, base y -10. Residents: **6**.

Twin function in one tunnel: it carries the tuned Song-conduits up to the wedge's star-lamps, like every wedge's gallery — but Nyx'Talar shaped its vaults so that sound gathers and travels, and set listeners in its niches. Voices from certain rooms above, spoken near a hearth or a drain, arrive here thinned but legible. The House does not call it eavesdropping. It calls it acoustics.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 5×68×4 | conduit run + focusing vaults; access ladders to each terrace's lamp-stems |
| Listening niches (x4) | 3×3×3 | where the listeners sit their shifts; each niche hears a different quarter of the wedge above |

**Occupants:** the Listeners (6).

> A crew of 6 who both tend the Song-conduits and man the niches. They live at their posts and are relieved rarely; what they hear goes up in a sealed hand to the Hall of Occultations.

#### NX-X03 · The Deep-Wrights' Warren
*Terran bunk-hall & tunnelling enclave* — **r 250 m, a° 66**, footprint **26×18 m**, h 6 m, base y -16. Residents: **48**.

Home and hall of the Terran stone-wrights who cut this wedge's under-galleries — and, more than in any other wedge, its hidden passages: the House pays well for tunnels that appear on no wright's plan but their own. The deep folk hold the beautiful city up and also, quietly, riddle it with ways to move unseen. Proud, glow-warm, and closer-mouthed even than the House above them.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | a communal hall; a long stone table; the wrights eat together and speak little of the day's digging |
| Sleeping galleries | 22×6×3 | bunk-niches for ~46 wrights |
| The Unmapped Room | 6×5×4 | where the warren-master keeps the only true plan of what has been dug, in Terran stone-script |
| The Shrine of Petrocore | 6×6×5 | a Stone-Voice shrine — the wrong god for this city, kept anyway |

**Occupants:** Lock-master Bront; the warren-elders (with Bront); the Deep-Wrights (46).

> Warren-master Bront + lock-master (same Bront works the Silent Lock) + ~46 Terran deep-wrights. They know every hidden way in the wedge, and sell that knowledge to no one — the one thing the House cannot buy outright.

#### NX-X04 · The Runners' Bunks
*bunk-hall (message-runners & porters)* — **r 236 m, a° 71**, footprint **22×15 m**, h 4 m, base y -18. Residents: **52**.

The bunk-hall of the wedge's runners: the human and orc porters who carry sealed things through the under-galleries by hand, because a thing that never touches the official post can never be intercepted at it. They run the dark between the two cities all night, memorise routes and never write them, and are paid to have poor memories for everything else. The largest, youngest, most disposable population in the wedge.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk rows | 18×10×4 | double-bunks for ~52; the runners sleep in shifts, so a bunk is never cold |
| The Route-room | 6×4×3 | where a runner is given a destination and a seal to match, and nothing in writing |

**Occupants:** the Runners (52) — the runner-elder Vosk.

> ~52 runners (human & orc). The muscle and legs of the unseen economy; part of the unnamed 778. Named: the runner-elder Vosk, who has never once been caught and teaches the young ones how not to be.

#### NX-X05 · The Underquiet Canteen
*canteen / commons* — **r 248 m, a° 59**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The wedge's under-city commons, and the one place its habitual silence lifts a little: runners, wrights, lift-gang and listeners eat the same grey good stew and, for the length of a meal, say true things. The canteen-keeper enforces the Blind Eye's rule down here too — what is said over the pot is not carried out of the room.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, a wall where the dead are chalked and no name is ever a false one |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Ma Dell + 3.

> Canteen-keeper Ma Dell + 3 helpers. Sister-room to the Underspill and the Undertoll; the three under-canteens' keepers know each other, and between them know everything.

#### NX-X06 · The Keeper of the Seam
*overseer post* — **r 242 m, a° 51**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office where the under-city answers to the watch above — and where, uniquely in this wedge, the foreman's real job is to decide what the watch is told. He keeps two shift-books: the one that goes up, and the one that is true. He is trusted by neither map, and knows more than both.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a lamp, two locked shift-books that do not agree |
| Bunk | 3×3×3 | the foreman sleeps at the seam, as they all do |

**Occupants:** Foreman Karse.

> Foreman Karse. In a House of secrets the seam-keeper is the most dangerous man in the wedge, because he is the one who edits the record before it rises. A natural quest-broker — and a natural blackmail target.

#### NX-X07 · The Hall of Occultations
*sealed-record vault & confidential drop (novel landmark)* — **r 255 m, a° 63**, footprint **22×18 m**, h 8 m, base y -22. Residents: **12**.

The wedge's — and secretly the city's — true archive: the place where secrets are timed, sealed, and kept. Sealed depositions, testaments held against a death, confessions bought and never used, and the dated occultation-records that prove who was hidden from what and when. A message left here at a named hour is delivered at another named hour to a named hand and no other; a thing sealed here is opened only when its condition falls due. The House sells not information but its safekeeping — and the whole city, from Conclave down, quietly depends on it. It is on no plate, because a vault of everyone's secrets cannot be allowed to have an address.

| Room | Size (m) | Purpose |
|---|---|---|
| The Timed Vault | 12×10×6 | ranked warded drawers, each dated to open; the Sealed Warden alone knows which fall due tonight |
| The Drop | 6×6×5 | a screened chamber where a client leaves or collects without ever seeing another face |
| The Keepers' cells | 10×6×4 | the record-keepers live sealed inside; they take an oath of the vault and are not seen above for years at a time |

**Occupants:** the Sealed Warden Ilex; the record-keepers (11).

> The Sealed Warden Ilex + 11 record-keepers who live within the vault. THE novel landmark of the wedge and a franchise-grade set-piece: whoever holds this hall holds a lever on every House in Starfall — including, one imagines, a record or two the Academy would rather did not exist.

#### NX-X08 · The Ferry-Warren
*bunk-hall (night-barge crews)* — **r 238 m, a° 46**, footprint **22×14 m**, h 5 m, base y -20. Residents: **47**.

Where the crews of the night-barges live — the polemen and gate-hands who work the world-below cargo up through the Silent Lock in the dark. They keep the same hours as the runners and the same silence, and their children grow up knowing the black under-water better than the terraces of light above their heads, which most of them have never seen by day.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk galleries | 18×8×4 | family bunk-niches along the loading water; whole lives lived below the waterline of the city |
| The Wet Floor | 10×6×4 | where barges are made fast and unladen out of the light |

**Occupants:** the Ferry-Warren (47).

> ~47 barge-folk (human, orc, a few Terran). A community entirely of the under-city, born to it — the sharpest edge of the two-maps theme in this wedge: people the Plate cannot omit, because it never knew to include them.

### Who lives here — roster (28 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Suvane Nyx'Talar | Noctari | Head of House Nyx'Talar; Warden-in-Chief of the Occultation | The Shuttered Seat | The Umbral Tower |
| First Occulter Dess | Noctari | senior observer; times the eclipses and transits | The Umbral Tower | The Umbral Tower |
| the live-in reckoners (6) (×6) | Noctari | reduce the eclipse-tables | The Umbral Tower | The Umbral Tower |
| the Nyx'Talar near family (5) (×5) | Noctari | House family | The Shuttered Seat | — |
| the Shuttered Seat staff (11) (×11) | Noctari & 2 human | cook, gate-lodge keeper, chart-porters, maids | The Shuttered Seat | The Shuttered Seat |
| Warden Ottress + household (5) (×5) | Noctari | senior Warden; holds a registered sightline he never opens | The Villa Behind the Lattice | The Umbral Tower |
| Warden Coreth + household (6) (×6) | Noctari | Second Warden; catalogues transits by day, arranges silences by night | The Second Warden's Villa | The Second Warden's Villa |
| the widow Halissa + household (4) (×4) | Noctari | kept tenant; saw something once at an occultation | The Kept Villa | — |
| Caretaker Pell | Noctari | keeps the Furnished Absence warm and empty | The Furnished Absence | The Furnished Absence |
| Master-sealwright Ordell Craze + hall (13) (×13) | Noctari | makes the city's official seals, locks and ciphers | The Sealwrights' Hall | The Sealwrights' Hall |
| the Sealed Copyists (9) (×9) | Noctari | reproduce documents they are trained not to read | The Sealed Copyists | The Sealed Copyists |
| Lesser Wardens' Row (22) — Nessa Ptol (×22) | Noctari, 1 human household | sightless street-watchers; keep the House's survey of the city | Lesser Wardens' Row | — |
| Mistress Oll + house (5) (×5) | Noctari | innkeeper of the Blind Eye | The Blind Eye | The Blind Eye |
| the Unlabelled Market (30) — the 'valuer' Sim Onrey (×30) | Noctari, 2 human | letter-writers, a lock-fitter, a seal-dealer, a fence, a tea-house | The Unlabelled Market | The Unlabelled Market |
| Keeper Threnn | Noctari | keeper of the Shrine of the Passing Shadow | The Shrine of the Passing Shadow | The Shrine of the Passing Shadow |
| Shutterside dwellings (38) — Corra Sel (×38) | Noctari, some human | boatwrights, runners' families, sealwrights' kin, market-hands | Canal Dwellings — Shutterside | — |
| the watcher Aline Voss + apprentice (×2) | Human | freelance watcher; sells the House what its wardens miss | The Watcher's Rooms | — |
| Watch-officer Delm + 2 clerks (×3) | Noctari | runs the round-the-clock Watch-Customs | The Watch-Customs | The Watch-Customs |
| Lock-master Bront | Terran | runs the Silent Lock; warren-master of the deep-wrights | The Deep-Wrights' Warren | The Silent Lock |
| the Listeners (6) (×6) | Noctari & human | tend the Song-conduits and man the listening niches | The Listening Gallery | The Listening Gallery |
| the warren-elders (with Bront) (×1) | Terran | keepers of the Unmapped Room | The Deep-Wrights' Warren | The Deep-Wrights' Warren |
| the Deep-Wrights (46) (×46) | Terran | cut the under-galleries and the hidden ways | The Deep-Wrights' Warren | — |
| the Runners (52) — the runner-elder Vosk (×52) | human & orc | carry sealed things by hand through the dark | The Runners' Bunks | — |
| Ma Dell + 3 (×4) | Orc | canteen-keeper of the Underquiet | The Underquiet Canteen | The Underquiet Canteen |
| Foreman Karse | Human | keeper of the seam; edits the record before it rises to the watch | The Keeper of the Seam | The Keeper of the Seam |
| the Sealed Warden Ilex | Noctari | keeper of the Hall of Occultations; times, seals and releases the city's secrets | The Hall of Occultations | The Hall of Occultations |
| the record-keepers (11) (×11) | Noctari | live sealed within the vault, keeping the timed drawers | The Hall of Occultations | — |
| the Ferry-Warren (47) (×47) | human, orc, some Terran | night-barge crews of the Silent Lock | The Ferry-Warren | — |

| Band | Souls |
|---|---|
| Rim / House seat | 24 |
| Upper terraces | 16 |
| Middle terraces | 44 |
| Canal quarter | 76 |
| Shore | 3 |
| Under-Terraces | 170 |
| **Total** | **333** |

> ≈ 333 souls here; **170 of them in the Under-Terraces**, on no official map.

## House Oravelle — *Trackers of the Wanderers*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### OR-T01 · The Wanderers' Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 100**, footprint **⌀22 m**, h 54 m, 6 storeys, base y 45. Residents: **8**.

The wandering lights are tracked from here and their positions turned, floor by floor, into the ephemeris the whole realm sets its calendar by. Vael'Suran keeps the stars that never move; Oravelle keeps the five that do, and has learned that a thing which moves can be sold a prediction of where it will be. The Conclave dates its decrees from readings taken in this drum, which is the quiet root of the House's fortune.

| Room | Size (m) | Purpose |
|---|---|---|
| The Observing Drum | 20×20×8 | the equatorial mounting and the graduated circles; the five wanderers logged against the fixed stars each clear night |
| The Reckoning Floor | 18×16×5 | banks of computers reducing positions into the running ephemeris; the loudest quiet room in Starfall, all pen-scratch and abacus |
| The Ephemeris Vault | 10×8×4 | brass-bound, humidity-sealed; the master tables back two thousand years, the only copy the House will not sell |
| Head's cabinet | 8×7×4 | Magister Corandine's study, sightline to the Mirror, a wall of sealed contracts framed like art |
| Computers' dormitory | 12×8×4 | cots for the live-in reckoners, who are paid in board and the promise of a clerkship |
| Servants' stair & lamp-room | 4×4×28 | the spiral stair; the crowning star-lamp is tended from here |

**Occupants:** Magister Corandine Oravelle; First Reckoner Hessa Vun; the live-in computers (6).

> Head + First Reckoner + 6 live-in computers. One of the nine lit rim domes of the greybox.

#### OR-M01 · The Oravelle Counting-Seat
*great house (manor + counting-house)* — **r 438 m, a° 107**, footprint **36×24 m**, h 15 m, 3 storeys, base y 45. Residents: **24**.

The richest seat on this arc of the rim, and the only one that is also a place of business: half manor, half counting-house, its ground floor a hall of sealing-desks where the House's bonded almanacs are stamped and its guarantees underwritten. The Oravelle do not measure status in windows, as Vael'Suran do, but in ledgers — and theirs are the longest in the city. Every room smells of sealing-wax and money.

| Room | Size (m) | Purpose |
|---|---|---|
| The Sealing Hall | 16×12×7 | public-facing; long counters, the great House seal on a chained press, clients who arrive by appointment and leave with a stamped future |
| The Strongroom | 8×6×4 | warded; the bond-reserve that backs the guarantees, and the register of who owes the House a favour |
| Corandine's chambers | 10×8×4 | the head's private rooms, best sightline in the House |
| Family wing | 16×8×4 | chambers for the near family and the two clerk-cousins being groomed to inherit the desks |
| Kitchen, stores, staff | 14×8×4 | household below and attic rooms above |

**Occupants:** Magister Corandine Oravelle; the Oravelle near family (6); the Counting-Seat staff (17).

> Corandine + near family (6) + 17 household and counting-house staff. The seat doubles as the House's public office, unusual for the rim.

### The Upper Terraces

#### OR-U01 · Sightline Villa — the First Reckoner
*senior officer's villa* — **r 372 m, a° 86**, footprint **15×13 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

Home of First Reckoner Hessa Vun, the commoner-born computer who actually derives the ephemeris the House sells and Corandine signs. Her sightline is real and her figures are exact, and she is the one person in Starfall who could ruin House Oravelle with a single honest sentence about how often the guarantees are simply bets the House can afford to lose.

| Room | Size (m) | Purpose |
|---|---|---|
| The Working Study | 10×8×5 | the protected sightline; a private reckoning-desk and a locked drawer of the errors the published tables do not admit |
| Family rooms | 14×6×4 | Hessa, her husband, two children |

**Occupants:** Hessa Vun's household (5).

> Hessa Vun + household of 6. The Halvenor-role of this wedge: the mind behind the signature. A strong side-quest lever (what the errata drawer holds).

#### OR-U02 · Sightline Villa — the Bonded Notary
*senior scholar's villa* — **r 368 m, a° 95**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

The villa of Notary-Magister Selvane, whose seal turns a computed date into a binding one. A prosperous, cautious household that has grown rich witnessing other people's certainty; the study is lined with the counterfoils of forty years of stamped tomorrows.

| Room | Size (m) | Purpose |
|---|---|---|
| The Sealing Study | 9×7×4 | the notarial seal, the witness-bench, a sightline used mostly to impress clients |
| Living rooms | 14×6×4 | Selvane, a spouse, one grown child, two servants |

**Occupants:** Notary-Magister Selvane + household (6).

> Notary-Magister Selvane + household of 6.

#### OR-U03 · Sightline Villa — the Voided Magister
*senior scholar's villa (in disgrace)* — **r 366 m, a° 114**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **4**.

The villa of Magister Orrin Tallowe, who once sealed a planting-date for an entire Terran province and was wrong by a season, ruining a harvest and, quietly, himself. The House honoured the guarantee — that is the whole point of the guarantee — but it took the cost out of Orrin, who now keeps a sightline he can no longer afford and computes, obsessively, the single reading he got wrong, looking for the House's error instead of his own.

| Room | Size (m) | Purpose |
|---|---|---|
| The Reproach Study | 9×7×4 | one wall entirely given to the recomputation of a date fourteen years gone |
| Rooms | 12×6×4 | Orrin, an unpaid companion, one loyal old servant |

**Occupants:** Magister Orrin Tallowe + household (4).

> Orrin Tallowe + household of 4. Side-quest seed: was the voided date his error or the House's? Hessa Vun's errata drawer may know.

### The Middle Terraces

#### OR-L01 · The Ephemeris Manufactory
*computing-and-copying manufactory (guild-hall + lodging)* — **r 318 m, a° 90**, footprint **24×16 m**, h 11 m, 3 storeys, base y 23. Residents: **28**.

A factory of paper and patience: rooms of clerks who take the tower's raw readings and grind them into thousands of fair-copied almanacs, tide-tables and lucky-day sheets for sale across the realm. The work is divided so finely that no single clerk understands the whole calculation — a deliberate arrangement, since a clerk who understood the whole could set up in competition, or in blackmail.

| Room | Size (m) | Purpose |
|---|---|---|
| The Calculating Floor | 20×10×5 | ranked desks; each clerk performs one step of a computation they are forbidden to see the ends of |
| The Fair-Copy Room | 16×8×4 | scribes multiplying the finished tables by hand under the manufactory's tallow reek |
| The Binding & Sealing Loft | 14×6×4 | where sheets become bonded almanacs and take the small House seal |
| Clerks' dormitory | 20×6×4 | boarded clerks, four to a room, docked for a blotted line |

**Occupants:** Overseer Marn Quell + clerks (28).

> Overseer Marn Quell + ~27 boarded clerks and copyists. The engine of the House's fortune, and the least-credited labour in the wedge above ground.

#### OR-L02 · The Sealers' & Notaries' Hall
*guild-hall + workshop* — **r 312 m, a° 101**, footprint **20×13 m**, h 9 m, 3 storeys, base y 23. Residents: **12**.

The guild that makes and guards the seals — the bonded matrices without which no Oravelle guarantee is worth its wax. Engravers cut the dies, assayers weigh the wax, and a warden keeps the register of which seals are live and which have been struck void, because a stolen live seal could counterfeit the future itself.

| Room | Size (m) | Purpose |
|---|---|---|
| The Die-Cutting Room | 10×7×4 | engravers at the bonded matrices; a guarded, jeweller-quiet trade |
| The Register | 8×6×4 | the warden's book of live and voided seals; a locked room within a locked room |
| Guild dormitory | 14×5×3 | boarded engravers and apprentices |

**Occupants:** Seal-warden Ippa Dross + guild (12).

> Seal-warden Ippa Dross + 11 engravers/apprentices.

#### OR-L03 · Lesser Clerks' Row
*terrace of 7 small dwellings* — **r 300 m, a° 112**, footprint **48×8 m**, h 7 m, 2 storeys, base y 23. Residents: **24**.

Seven joined narrow houses of the wedge's tenured clerks — the reckoners, sealers'-assistants and register-keepers who have risen just high enough to hold a lease and a title but never a sightline. The most anxious street in Starfall: every family here is one blotted ledger from the dormitory they climbed out of.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: counting-room + 2 chambers | 6×7×4 | each of the 7 houses: a private desk and two small rooms |

**Occupants:** Lesser Clerks' Row (24) — register-keeper Voss.

> 7 households, ~24 souls. Named: register-keeper Voss, who knows exactly what everyone above and below him earns and resents both.

### The Canal Quarter

#### OR-K01 · The Ledger & Compass
*inn (Strain-relief haven)* — **r 268 m, a° 85**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **6**.

The wedge's inn, and the one place in House Oravelle where nobody keeps a tally: the innkeeper runs a slate but rubs it clean at year's turn, a small local heresy in a district that binds everything else in triplicate. Clerks come here to be, for one evening, a person rather than a step in a calculation. The wedge's Strain-relief haven.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, long tables, an old ship's compass over the bar that no longer points anywhere and is beloved for it |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above for travellers come to buy dates and for clerks between lodgings |
| Cellar | 8×6×3 | canal-cooled store; a grille to the Under-Terraces the innkeeper swears is only for the draught |

**Occupants:** Innkeeper Delph Ravin + house (6).

> Innkeeper Delph Ravin + 3 family + 2 staff. The cellar grille is this wedge's over/under seam (to OR-X05).

#### OR-K02 · The Almanac Market
*market row (calendars, almanacs, date-charts)* — **r 258 m, a° 96**, footprint **32×10 m**, h 6 m, 2 storeys, base y 12. Residents: **30**.

Eleven stalls and shopfronts where the House's product meets the street: printed almanacs, wedding-date charts, sailing-tables, cheap lucky-day sheets, and the second-hand almanac dealer who sells last year's certainties at a discount. The public face of prediction — retail fate, sold over a canal counter with the small seal that makes it feel binding.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + back-room + room above | 3×8×4 | 11 units, most with a family living above |

**Occupants:** The Almanac Market (30) — the widow Pell & the dealer Osk.

> 11 shops, ~30 souls. Named: almanac-seller the widow Pell, and the second-hand dealer Osk, who reads the discounted sheets to the illiterate for a coin.

#### OR-K03 · The Chapel of Variables
*shrine (Path of Adaptation — human faith)* — **r 250 m, a° 104**, footprint **10×10 m**, h 8 m, 1 storeys, base y 12. Residents: **3**.

A small human-kept chapel to the Architect of Variables and the Observer of Outcomes — a faith that holds the world to be a running experiment — tolerated in this wedge alone because a House that sells prediction finds it good for morale that its human clerks worship a god of odds. The Noctari majority think it charmingly superstitious; the clerks who pray here think the same of the almanacs they copy.

| Room | Size (m) | Purpose |
|---|---|---|
| The Chapel | 7×7×6 | two facing altars — one for the change, one for the watching; a wall of votive tokens, each a settled bet |
| Keeper's cell | 3×3×3 | the lay-keeper's room |

**Occupants:** Lay-keeper Ansel Roe + 2.

> Lay-keeper Ansel Roe (human) + 2 lodging pilgrims. Canon-aware: the human Path of Adaptation (Canon_Notes) given a foothold in a prediction House. A quiet counterweight to Noctari Umbrion-worship.

#### OR-K04 · The Assurance House
*date-guarantee office (NOVEL — proto-insurance)* — **r 240 m, a° 110**, footprint **18×14 m**, h 9 m, 2 storeys, base y 12. Residents: **10**.

The wedge's novel invention and its most quietly sinister room: a canalside office where, for a fee, House Oravelle will not merely predict a date but GUARANTEE it — underwriting your harvest, your voyage, your wedding against the sky being wrong. In practice the House pools the fees, pays the rare claim, and keeps the difference, so a hall of scholars has become, without ever quite noticing, a bank that sells the future as a hedge. The queue outside is the real proof of the House's power: the whole city has agreed to be afraid of dates on Oravelle's terms.

| Room | Size (m) | Purpose |
|---|---|---|
| The Assuring Hall | 12×8×5 | petition-desks where a farmer or a captain buys certainty; the great odds-board chalked and rechalked |
| The Pool-Room | 6×5×4 | warded; the fee-reserve that pays out the losing guarantees, and the actuary's forbidden tables |
| Assurers' lodging | 10×5×4 | the resident assurers, who sleep above the money |

**Occupants:** Chief Assurer Wend Colu + assurers (10).

> Chief Assurer Wend Colu + 9 resident assurers/clerks. The wedge's novel landmark: prediction turned into a hedge-fund. Rich quest and theme material — the actuary's tables know the House loses more guarantees than it admits.

#### OR-K05 · Canal Dwellings — Inkside
*tenement block, 9 dwellings* — **r 245 m, a° 90**, footprint **26×14 m**, h 11 m, 3 storeys, base y 12. Residents: **46**.

Dense canalside housing stained perpetually blue-black at the ground floor, home to the printers, ink-makers, paper-porters and copy-runners who feed the manufactory above. Ink comes up the canal by barge and the whole block smells of iron-gall and reed; the children are born with stained hands.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 9 dwellings, families of 3-6 |

**Occupants:** Inkside dwellings (46) — ink-master Corrl.

> ~46 souls. Named: ink-master Corrl, whose recipe the whole wedge depends on and whose lungs it is quietly ruining.

#### OR-C01 · The Oravelle Canal & its two bridges
*waterway* — **r 255 m, a° 98**, footprint **60×6 m**, h ? m, base y 12. Residents: **0**.

Star-water and cargo-water both: the canal drains the quarter and, through the lock below, carries in the reed, rag and ink the paper-machine runs on, and carries out the crated almanacs by barge. Two arched footbridges cross it, their parapets chained with the small brass tallies of goods that have passed — the canal itself kept as a ledger.

> The visible throat of the invisible paper-supply chain (see OR-X01 the lock and OR-X04 the pulp-works).

### The Shore & Processionals

#### OR-S01 · The Reckoners' Gate & Customs Post
*civic threshold* — **r 228 m, a° 98**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **0**.

Where this wedge's processional meets the shore: a customs post that does not merely weigh what comes up from below but DATES it, stamping every barge-load with the licensed day it may be sold — a small, profitable tyranny by which the House converts the labour of the under-city into paper the moment it surfaces. The one official door here faces up, and it charges for the privilege.

| Room | Size (m) | Purpose |
|---|---|---|
| The Dating Hall | 10×7×4 | scales, tally-desks, the licensing-stamp, a wardsealed strongroom |
| Officers' room | 5×4×4 | the customs-dater and two clerks |

**Occupants:** Customs-dater Ollen + 2 clerks.

> Customs-dater Ollen + 2 clerks (day post; counted at their canal homes; listed here as workplace).

### The Under-Terraces

#### OR-X01 · The Reed-Lock
*barge lock (service)* — **r 240 m, a° 96**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

A stone chamber-lock that lifts the barges of reed, rag, lime and ink up from the world below into the wedge's canal — the raw throat of the paper-machine. The whole glittering trade in printed certainty begins as sodden reed hauled up this shaft in the dark by gangs the almanacs will never mention. The Plate draws the canal and stops at the waterline.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the flooding basin; the counter-weighted gates; a permanent stink of wet reed |
| The Capstan Floor | 12×8×4 | where the lift-gangs walk the capstans against the barge-weight |
| Tally hole | 4×4×3 | the under-clerk's niche, where the real weight is logged before the over-city halves it |

**Occupants:** Lock-master Bral.

> Worked, not lived-in. Lock-master Bral. The under-clerk keeps the honest tonnage in charcoal — the Other Map's paper.

#### OR-X02 · The Conduit Gallery
*Song-conduit service tunnel* — **r 260 m, a° 92**, footprint **70×5 m**, h 4 m, base y -10. Residents: **0**.

The wedge's run of tuned crystal conduits, carrying the Song up to the star-lamps of the counting-terraces so that the manufactory can compute through the night. The clerks above write by a light that people down here keep singing by hand; when a lamp over a desk 'simply burns,' a conduit-wright in the dark is the reason the ledger can be balanced past dusk.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 4×70×4 | the conduit run; access ladders to each terrace's lamp-stems |
| Tuning niches (x4) | 3×3×3 | where the wrights kneel to true the crystal |

**Occupants:** Conduit-wrights (crew of 6).

> Worked by conduit-wrights (mostly Terran), lodged in OR-X03. The literal machinery behind the manufactory's endless light.

#### OR-X03 · The Under-Reckoners' Hall
*Terran bunk-hall & enclave* — **r 250 m, a° 106**, footprint **26×18 m**, h 6 m, base y -16. Residents: **44**.

Home of the Terran deep-wrights and conduit-crews who cut and hold up the counting-house wedge — and, unusually, of a knot of Terran under-reckoners the House quietly employs to check the manufactory's figures below the record, because the deep-folk count in a base the elves find awkward and cannot easily cook. A proud, warm, glow-lit hall that does the House's most trusted arithmetic and receives none of its credit.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | a communal hall; a long stone table scored with a reckoning-grid the deep-folk compute on directly |
| Sleeping galleries | 22×6×3 | bunk-niches for ~40 wrights and under-reckoners |
| The Shrine of Petrocore | 6×6×5 | a Stone-Voice shrine; the deep-folk keep the right god in the wrong city |

**Occupants:** Deep-warden Torv Greel; The Under-Reckoners & Deep-Wrights (43).

> Deep-warden Torv Greel + ~43 Terran deep-wrights, conduit-crew and under-reckoners. Novel wrinkle: the House's most trusted sums are done, off the books, by the people it will not seat.

#### OR-X04 · The Pulp-Works & Rag-Halls
*paper manufactory & bunk-hall (NOVEL)* — **r 246 m, a° 112**, footprint **34×22 m**, h 8 m, base y -20. Residents: **58**.

The hidden factory that MAKES the paper the whole glittering House is printed on: a sweating, roaring vault of stamping-hammers, lime-vats and rag-halls where reed and cast-off cloth are beaten to pulp, drawn into sheets, and hung to dry on endless underground lines. Every bonded almanac and stamped guarantee in Starfall began as filth boiled in this dark by human and orc gangs who cannot read a word of what they make. The single most industrial space in Starfall, and the most invisible — a paper-mill directly beneath a House that sells paper.

| Room | Size (m) | Purpose |
|---|---|---|
| The Stamping Floor | 18×10×6 | water-driven trip-hammers beating rag to pulp; a noise you feel in the teeth |
| The Vat-Hall | 14×8×5 | the lime and pulp vats; the vat-workers, whose hands go pale and then numb |
| The Drying Lofts | 20×8×5 | warm racks of drying sheets, lit by waste-heat; the one comfortable air in the under-city, and forbidden to linger in |
| Rag-hall bunks | 22×6×3 | bunk-niches for the pulp-gangs, who live inside the noise |

**Occupants:** The Pulp- & Rag-Gangs (58) — elder Osma.

> ~58 human and orc pulp- and rag-workers, elder Osma of the rag-halls named. The wedge's second novel landmark: a paper-mill under a paper-House, the literal ground of the Other Map's theme. Part of the unnamed 778.

#### OR-X05 · The Reed-Bottom Canteen
*canteen / commons* — **r 248 m, a° 100**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The warm shared room of this under-city: a canteen at the gallery-crossing where deep-wrights, pulp-gangs, conduit-crews and lock-hands eat the same grey, good stew and, at the long table, teach each other to read from stolen almanac off-cuts — the one place in the wedge where the House's paper is used against the House's grain.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, a wall where the dead are chalked and a corner where letters are learned |
| Kitchen & store | 6×5×3 | run by the canteen-keeper |

**Occupants:** Canteen-keeper Old Ghu + 3.

> Canteen-keeper Old Ghu + 3 helpers. The clandestine literacy corner foreshadows Part Two's SQ-P2-01 (The First Book) 300 years early. The Ledger & Compass cellar grille surfaces near here.

#### OR-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 89**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office at the foot of the stair up to the Reckoners' Gate, where the under-city's real tonnage is reconciled against the dated, halved, licensed figure the over-city will accept. The foreman keeps both numbers and the arithmetic between them, and is the only person permitted to know how large the difference is.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a lamp, a locked reconciliation-book |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Sarn.

> Foreman Sarn — keeps the honest tonnage in charcoal and the House's in ink, and is paid precisely to know they differ. Twin to Foreman Adric (H0).

#### OR-X07 · The Dead-Letter Vault
*archive of voided predictions (NOVEL)* — **r 262 m, a° 116**, footprint **14×12 m**, h 5 m, base y -22. Residents: **2**.

A dry stone catacomb where House Oravelle buries its mistakes: every superseded ephemeris, voided guarantee and wrong-dated almanac, shelved and sealed rather than destroyed, because a prediction House cannot be seen to burn its errors and cannot bear to let a client find them. A silent underground library of every tomorrow the House got wrong — including, somewhere on the shelves, the voided date that ruined Magister Orrin Tallowe, and the errata that might exonerate him.

| Room | Size (m) | Purpose |
|---|---|---|
| The Stacks of Voided Days | 10×8×5 | sealed cases of failed predictions, filed by the date they were proved wrong |
| Registrar's cell | 4×4×3 | the one keeper's room, lit by a single conduit-lamp |

**Occupants:** Registrar of Voided Days Miral Enn + 1.

> Registrar of Voided Days Miral Enn + one assistant. Novel landmark: a bureaucratic catacomb of wrong futures. Direct quest hook to OR-U03 (Orrin's exoneration) and the Assurance House's hidden loss-rate.

### Who lives here — roster (25 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Corandine Oravelle | Noctari | Head of House Oravelle; Keeper of the Ephemeris; underwriter of the realm's dates | The Oravelle Counting-Seat | The Wanderers' Tower |
| First Reckoner Hessa Vun | Noctari | commoner-born chief computer; derives the ephemeris the House sells | Sightline Villa — the First Reckoner | The Wanderers' Tower |
| the live-in computers (6) (×6) | Noctari | junior calculating clerks reducing the wanderers' positions | The Wanderers' Tower | The Wanderers' Tower |
| the Oravelle near family (6) (×6) | Noctari | House family + 2 clerk-cousins in line for the desks | The Oravelle Counting-Seat | — |
| the Counting-Seat staff (17) (×17) | Noctari & 3 human | sealing-clerks, cook, porters, strongroom-warden, maids | The Oravelle Counting-Seat | The Oravelle Counting-Seat |
| Hessa Vun's household (5) (×5) | Noctari | the First Reckoner's husband and two children + a lodging aunt | Sightline Villa — the First Reckoner | — |
| Notary-Magister Selvane + household (6) (×6) | Noctari | bonded notary; his seal makes a computed date binding | Sightline Villa — the Bonded Notary | The Oravelle Counting-Seat |
| Magister Orrin Tallowe + household (4) (×4) | Noctari | disgraced date-sealer; recomputes the reading that ruined him | Sightline Villa — the Voided Magister | Sightline Villa — the Voided Magister |
| Overseer Marn Quell + clerks (28) (×28) | Noctari, several human | runs the Ephemeris Manufactory; keeps the computation divided so no clerk sees the whole | The Ephemeris Manufactory | The Ephemeris Manufactory |
| Seal-warden Ippa Dross + guild (12) (×12) | Noctari | warden of the bonded seals; keeps the register of live and voided matrices | The Sealers' & Notaries' Hall | The Sealers' & Notaries' Hall |
| Lesser Clerks' Row (24) — register-keeper Voss (×24) | Noctari, 1 human household | tenured reckoners, sealers'-assistants, register-keepers; sightless | Lesser Clerks' Row | — |
| Innkeeper Delph Ravin + house (6) (×6) | Noctari | keeps The Ledger & Compass; rubs his slate clean each year | The Ledger & Compass | The Ledger & Compass |
| The Almanac Market (30) — the widow Pell & the dealer Osk (×30) | Noctari, some human | almanac-sellers, chart-makers, a second-hand date dealer | The Almanac Market | The Almanac Market |
| Lay-keeper Ansel Roe + 2 (×3) | Human | keeper of the Chapel of Variables (Path of Adaptation) | The Chapel of Variables | The Chapel of Variables |
| Chief Assurer Wend Colu + assurers (10) (×10) | Noctari | runs the Assurance House; underwrites dates as a hedge | The Assurance House | The Assurance House |
| Inkside dwellings (46) — ink-master Corrl (×46) | Noctari, some human | printers, ink-makers, paper-porters, copy-runners | Canal Dwellings — Inkside | — |
| Customs-dater Ollen + 2 clerks (×3) | Noctari | dates and licenses everything that comes up from below | Canal Dwellings — Inkside | The Reckoners' Gate & Customs Post |
| Lock-master Bral | Terran | runs the Reed-Lock; lifts the paper-machine's raw reed from below | The Under-Reckoners' Hall | The Reed-Lock |
| Conduit-wrights (crew of 6) (×6) | Terran | keep the Song singing up to the manufactory's lamps | The Under-Reckoners' Hall | The Conduit Gallery |
| Deep-warden Torv Greel | Terran (geomancer-trained) | warden of the Under-Reckoners' Hall; leads the deep-wrights | The Under-Reckoners' Hall | The Under-Reckoners' Hall |
| The Under-Reckoners & Deep-Wrights (43) (×43) | Terran | cut and hold the wedge; check the manufactory's figures below the record | The Under-Reckoners' Hall | — |
| The Pulp- & Rag-Gangs (58) — elder Osma (×58) | human & orc | beat reed and rag to pulp; make the paper the House is printed on | The Pulp-Works & Rag-Halls | — |
| Canteen-keeper Old Ghu + 3 (×4) | Orc | keeps the Reed-Bottom Canteen; hosts the secret letters-corner | The Reed-Bottom Canteen | The Reed-Bottom Canteen |
| Foreman Sarn | Human | the seam of Oravelle's under-city; reconciles real tonnage to the dated figure | The Foreman's Post | The Foreman's Post |
| Registrar of Voided Days Miral Enn + 1 (×2) | Noctari | sole keeper of the Dead-Letter Vault of failed predictions | The Dead-Letter Vault | The Dead-Letter Vault |

| Band | Souls |
|---|---|
| Rim / House seat | 32 |
| Upper terraces | 16 |
| Middle terraces | 64 |
| Canal quarter | 95 |
| Shore | 0 |
| Under-Terraces | 109 |
| **Total** | **316** |

> ≈ 316 souls here; **109 of them in the Under-Terraces**, on no official map.

## House Sabreth — *Readers of the Long-Haired Stars*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### SB-T01 · The Long-Sight Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 140**, footprint **⌀22 m**, h 55 m, 6 storeys, base y 45. Residents: **8**.

Where the House watches for comets — the long-haired stars whose coming everyone fears and no one will be caught fearing. Sabreth reads them true and then sells them dressed: the same faint smear of light becomes a warning, a blessing, or a silence, depending on who is paying. The instrument on the top floor is genuinely excellent; it has to be, because a House that sold false omens would eventually be caught, and Sabreth is never caught.

| Room | Size (m) | Purpose |
|---|---|---|
| The Watch Floor | 18×18×8 | the sweep-telescopes and the comet-ledgers; every new smear of light logged before dawn and priced by noon |
| The Interpretation Room | 10×8×4 | windowless; where a true observation becomes a saleable omen — the House's real workshop, and the one room clients never see |
| The Client-Book Vault | 6×6×4 | silver-locked; who asked what, and what they were told — worth more than any chart in the city |
| Night-readers' loft | 12×8×4 | the live-in watchers who take the small hours; sworn to discretion, paid to keep it |
| The Signal Cupola | 6×6×6 | a shuttered lamp at the very top; a chosen colour shown at a chosen hour tells a waiting client, across the whole caldera, what the stars decided |

**Occupants:** the Night-Readers & interpreters (8).

> 8 live-in night-readers & interpreters. The lit finial is one of the greybox's nine rim domes. The signal cupola is a genuine over-city broadcast the Plate would never think to draw.

#### SB-M01 · The Sabreth Seat
*great house (manor)* — **r 438 m, a° 134**, footprint **34×24 m**, h 15 m, 3 storeys, base y 45. Residents: **24**.

Richer than a comet-House has any honest right to be, and dressed to make you notice and then decide not to ask. Gold leaf the fixed-star Houses would call vulgar; a hall built for arrivals; more doors than a house needs, several of which are for leaving unseen. Every grand thing in it is real, which is precisely how you know the money is not.

| Room | Size (m) | Purpose |
|---|---|---|
| The Hall of Welcomes | 16×12×8 | reception staged for effect; a ceiling painted with a comet whose tail points, if you follow it, at the strongroom |
| The Magistra's chambers | 11×8×5 | Aubrelle Sabreth's rooms; a private stair down that is not on the House's own plans |
| The Quiet Parlour | 9×7×5 | where the largest clients are received away from the Omen Court's theatre — no veils, no incense, just numbers |
| Family & guest wing | 18×8×4 | family and the House's ever-present 'guests' — leverage, mostly, kept comfortable |
| Kitchen, stores, staff & guard-room | 14×8×4 | a household larger and harder than a scholar's house should need |

**Occupants:** Magistra Aubrelle Sabreth; the Sabreth family (6); the Seat household & guard (17).

> Aubrelle + family (6) + 17 staff/guards. Grander than any other House Seat in the city, which everyone notices and no one mentions.

### The Upper Terraces

#### SB-U01 · The Long-Sight's Villa
*senior seer's villa* — **r 370 m, a° 152**, footprint **15×12 m**, h 10 m, 2 storeys, base y 34. Residents: **7**.

Home of Nemora Sabreth, the Long-Sight — the House's one genuine prodigy, the cousin who can actually read a comet's path a season ahead and finds the whole trade of selling it slightly nauseating. Her sightline is the best in the wedge and she uses it, most nights, to look at nothing anyone will pay for.

| Room | Size (m) | Purpose |
|---|---|---|
| The True Study | 10×8×5 | her real work, unsold; a wall of comet-paths drawn for their own sake |
| Living rooms | 13×6×4 | Nemora, a companion, an aunt, three staff |

**Occupants:** Nemora Sabreth, the Long-Sight.

> Nemora Sabreth + household of 7. The talent the whole House lives off, and the one Sabreth who'd leave if she had anywhere colder to go. A ready side-quest: buy, or free, an honest prediction.

#### SB-U02 · The Veilkeeper's Villa
*senior officer's villa* — **r 366 m, a° 144**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **8**.

Home of Sarnauld Vray, the Veilkeeper — not a Sabreth by blood but the man who decides which clients are seen, in what order, and at what price, and who remembers every one. He is the House's true engine and knows it; the family tolerate him the way a body tolerates its own heart, resentfully and without a choice.

| Room | Size (m) | Purpose |
|---|---|---|
| The Appointment Room | 9×7×4 | a desk, a locked diary, and a second door for clients who must not meet in the corridor |
| Living rooms | 14×6×4 | Vray, spouse, two children, four staff — comfortable, watchful, curtained |

**Occupants:** Sarnauld Vray, the Veilkeeper.

> Sarnauld Vray + household of 8. The commoner-born fixer who runs the wedge's real business, mirroring the commoner-First-Surveyor / Strike-Master pattern of the other Houses — but for vice, not science.

#### SB-U03 · The Comfortable House
*senior villa (front residence)* — **r 372 m, a° 126**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **7**.

A villa owned by no one in particular and lived in by 'Lady' Ombrise, a charming retired nobody with a suspicious lack of past and an unlimited line of credit. She hosts the parties where deals are agreed without ever being spoken, and her sightline is worth more as a place to be seen than as a place to see from.

| Room | Size (m) | Purpose |
|---|---|---|
| The Salon | 10×8×5 | where the wedge's laundered money puts on its best dress and dances |
| Rooms | 12×6×4 | Ombrise + companion + five staff, all better-paid than staff should be |

**Occupants:** 'Lady' Ombrise + household (7).

> 'Lady' Ombrise + 7. A front residence — the respectable face the dirty money wears on the terrace. Answers the Serenthil 'Quiet House' tenant, but for a very different quiet.

### The Middle Terraces

#### SB-L01 · The Ephemeris-House
*printworks + guild-hall* — **r 320 m, a° 150**, footprint **22×15 m**, h 9 m, 2 storeys, base y 23. Residents: **18**.

Where omens are turned into product: almanacs, fortune-sheets, dated warnings and charmed calendars, printed by the ream and sold across the elven lands. The presses run all night and the ink smells of camphor and money. Officially Sabreth reads the future; here they manufacture it, in editions, with margins.

| Room | Size (m) | Purpose |
|---|---|---|
| The Press Floor | 16×9×6 | silver-plate presses; the almanac in a dozen grades from gilt-vellum to gutter-pulp, each telling a slightly different fate |
| The Composing Room | 8×6×4 | where the interpreters' wordings are set — a craft of exact, deniable vagueness |
| Printers' dwelling | 14×6×4 | the master printer's family and the compositors above the presses |

**Occupants:** Master printer Pellon Sabreth + house (18).

> Master printer Pellon Sabreth + 17 (compositors, pressmen, families). The wedge's most respectable-looking trade and its most quietly cynical.

#### SB-L02 · The Fate-Scriveners' Row
*terrace of 7 dwellings/workshops* — **r 305 m, a° 133**, footprint **46×8 m**, h 7 m, 2 storeys, base y 23. Residents: **24**.

Seven joined houses of the small fate-trade: chart-copyists, charm-writers, street-criers who shout the day's printed omen, and the freelance readers too cheap or too honest for the Court. They live over their work, take the House's piecework, and dream of a client of their own.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: workroom + 2 chambers | 6×7×4 | 7 households of the fate-trade's underclass-that-still-counts-as-above |

**Occupants:** The Fate-Scriveners' Row (24) — the crier Vess, old Halden.

> 7 households, ~24 souls. Named: the crier Vess, whose morning shout the wedge sets its mood by; and old Halden, who reads true for free and is quietly hated for it.

#### SB-L03 · The Perfumers' & Veil-Makers' Hall
*guild-hall + workshop* — **r 312 m, a° 141**, footprint **18×12 m**, h 8 m, 2 storeys, base y 23. Residents: **12**.

The trade of atmosphere: the incense that makes the Omen Court smell of certainty, the veils clients hide behind, the dyed silks and dimmed lamps that turn a guess into a revelation. Sabreth understood before anyone that an omen is mostly staging, and this is where the staging is made.

| Room | Size (m) | Purpose |
|---|---|---|
| The Still-Room | 8×6×4 | resins and oils; the House's proprietary incense, whose recipe is a guild secret worth killing for and never has been |
| The Veil-Loom | 8×6×4 | the gauze veils, graded by opacity to the exact degree of anonymity a client pays for |
| Makers' dwelling | 12×5×4 | the guild families above |

**Occupants:** Guild-mistress Cael Onwe + hall (12).

> Guild-mistress Cael Onwe + 11. A trade that exists nowhere else in the city, because no other House needs to be believed.

### The Canal Quarter

#### SB-K01 · The Comet's Tail
*inn (Strain-relief haven)* — **r 270 m, a° 151**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **6**.

A canalside inn a cut too glamorous for its street — mirrored, warm, a little disreputable, the kind of place where a scholar can lose an evening and a secret at the same time. This wedge's Strain-relief haven, though the relief here comes with the faint sense of being read. The wine is good and the walls, it's said, are good listeners.

| Room | Size (m) | Purpose |
|---|---|---|
| The Mirror Room | 12×8×4 | hearth, silvered walls, a long bar; a resident 'reader' does palms for drinks and reports the interesting ones upstairs |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above, two with doors clients use and never the same night |
| Cellar | 8×6×3 | a canal-cooled store; a false wall gives onto the Veiled Water-Gate — how a client leaves without ever having arrived |

**Occupants:** Innkeeper Dosca Rell + house (6).

> Innkeeper Dosca Rell + 5. The cellar's false wall is Sabreth's over/under seam (to SB-X07). Every wedge's inn hides a stair down; this one hides a stair down for the guilty.

#### SB-K02 · The Omen Court
*night-market of fates (novel landmark)* — **r 260 m, a° 145**, footprint **26×22 m**, h 9 m, 2 storeys, base y 12. Residents: **12**.

The beautiful open secret of Starfall: a colonnaded court that stands empty by day and, by the ninth bell of night, fills with veiled clients moving between curtained stalls where fate is sold at every price — a copper charm at the edge, a whispered comet-reading at the centre, and, in the shuttered back rooms, things that are not readings at all. Respectable Houses send servants; respectable people come themselves, veiled, and pretend in the morning they did not. Everyone knows it is here. No map has ever admitted it.

| Room | Size (m) | Purpose |
|---|---|---|
| The Arcade | 22×6×5 | the public stalls: charms, printed fates, cheap readers — the honest-seeming edge that makes the rest plausible |
| The Inner Ring | 12×10×6 | curtained booths for the real trade; incense so thick the faces don't matter, which is the point |
| The Back Rooms | 8×6×4 | where a 'reading' becomes a loan, a threat, a name bought or a name buried |
| The Mistress's box | 5×5×4 | Dalveen watches the whole floor through a gauze and misses nothing |

**Occupants:** Dalveen, Mistress of the Omen Court.

> The wedge's 'novel and unique' landmark — a market of fates, live-in staff of 12 (readers, doormen, incense-boys, guards). A superb future set-piece: a level that is a social maze, not a physical one.

#### SB-K03 · The Charm-Market
*market row (superstition trade)* — **r 255 m, a° 137**, footprint **30×10 m**, h 6 m, 2 storeys, base y 12. Residents: **28**.

The daylight trade that feeds on the night one: charm-carvers, incense-sellers, ink-and-amulet shops, a dealer in 'comet-glass' (ordinary glass, sold with a story), a herbalist whose calming draughts the Court buys by the barrel. Live-over-the-shop, and every shopkeeper here owes the House a favour they can't quite name the size of.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + workshop + room above | 3×8×4 | 10 units, most with a family above, all leasing from Sabreth |

**Occupants:** The Charm-Market (28) — Sesk, Two-Fingers Voll.

> 10 shops, ~28 souls. Named: the charm-carver Sesk, honest and poor; the comet-glass dealer Two-Fingers Voll, dishonest and comfortable.

#### SB-K04 · Canal Dwellings — Lantern Walk
*tenement block, 10 dwellings* — **r 245 m, a° 129**, footprint **26×14 m**, h 11 m, 3 storeys, base y 12. Residents: **52**.

The wedge's densest housing, along the canal walk the Court's clients drift down by night — home to the readers, criers, doormen, incense-boys, boat-hands and market families who make the trade run and never rise in it. Warm, crowded, sharp-eyed, and full of people who have learned that the surest coin in Starfall is a secret.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 10 dwellings, families of 3-6 |

**Occupants:** Lantern Walk dwellings (52) — the boat-girl Nella.

> ~52 souls. Named: the boat-girl Nella, who ferries veiled clients and could name half the city if she ever chose to.

#### SB-K05 · The Shrine of the Turning
*shrine (Umbrion, fate-cast)* — **r 250 m, a° 156**, footprint **11×11 m**, h 9 m, 1 storeys, base y 12. Residents: **2**.

A shrine to Umbrion turned toward fate rather than dream: a dark room with a slow silver wheel that the keeper turns once a night, so that the future 'moves' whether or not anyone reads it. The genuinely devout come here to be reminded that the comet means nothing and comes anyway — a quiet rebuke to the whole wedge above it, kept by the House as a kind of alibi.

| Room | Size (m) | Purpose |
|---|---|---|
| The Wheel-Cell | 8×8×7 | the silver wheel; no omens sold, no coin taken — the one honest room in the district |
| Keeper's cell | 3×3×3 | the shrine-keeper's room |

**Occupants:** Shrine-keeper Anselm + novice.

> Keeper Anselm + a novice. The House funds it precisely because it undercuts the House — proof, to any suspicious Conclave visitor, of Sabreth's piety.

### The Shore & Processionals

#### SB-S01 · The Sabreth Customs & Processional Foot
*civic threshold* — **r 228 m, a° 154**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **0**.

The wedge's official customs post on the shore — the one the House makes sure is scrupulous, well-lit and slow, so that anyone watching the front door concludes Sabreth has nothing to hide. Everything worth hiding comes up through the Veiled Water-Gate below; the customs officer here is honest precisely so the House can afford to be watched.

| Room | Size (m) | Purpose |
|---|---|---|
| The Weighing Hall | 10×7×4 | scales, tally-desks, and a strongroom that has never held anything interesting |
| Officers' room | 5×4×4 | the customs officer and two clerks |

**Occupants:** Customs officer Bren + 2 clerks.

> Customs officer Bren + 2 clerks (day post; counted at their canal homes). Deliberately, performatively clean.

### The Under-Terraces

#### SB-X01 · The Slack-Water Lock
*barge lock (service)* — **r 240 m, a° 140**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

The wedge's public barge-lock, raising food, fuel and stone from the world below like any other — except that its lock-master keeps two logs, and the difference between them is the House's real import. What arrives on the honest log keeps the district fed; what arrives on the other keeps it rich.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the flooding basin and counter-weighted gates; worked by the lift-gangs |
| The Two-Log Office | 5×4×3 | the lock-master's niche; the honest ledger in ink, the other in a code only Vray can read |

**Occupants:** Lock-master Ferrun Oskt.

> Worked, not slept-in (crew home in SB-X04). Lock-master Ferrun Oskt keeps the double books — the point where the clean city and the dirty money change places.

#### SB-X02 · The Conduit Gallery
*Song-conduit service tunnel* — **r 260 m, a° 146**, footprint **68×5 m**, h 4 m, base y -10. Residents: **6**.

The tuned crystal conduits that carry the Song up to this wedge's star-lamps, tended in the dark by crews the glamour above never sees — the same unglamorous truth under every House. Here the gallery is also a message-run: a tapped code along the conduit-crystal lets the Court signal the water-gate without a soul crossing the terraces.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 5×68×4 | the conduit run; access ladders up to each terrace's lamp-stems |
| Tuning niches (x3) | 3×3×3 | where conduit-wrights kneel to true the crystal — and, quietly, to tap the House's signals |

**Occupants:** The Conduit-wrights (6).

> Conduit-wrights (6, mostly Terran; home in SB-X04). The machinery behind 'the lamps simply burn,' doubling as the House's private telegraph.

#### SB-X03 · The Counting-Vault
*laundering hall & strongroom (novel)* — **r 246 m, a° 134**, footprint **22×16 m**, h 7 m, base y -20. Residents: **16**.

Where the wedge's suspect wealth is made to look born-clean: coin weighed, recut, re-minted as Court fees, almanac sales and villa rents; debts bought and sold; the true client-books cross-checked against the false. A quiet, orderly, lamplit room of clerks and hard men, and the actual reason House Sabreth exists. The Plate draws a comet-House of scholars; this is the House.

| Room | Size (m) | Purpose |
|---|---|---|
| The Counting Floor | 14×8×5 | reckoners at long tables turning dirty coin into clean ledger-lines |
| The Strongroom | 6×5×4 | warded; the House's true reserve and its true client-book — the one worth more than the tower |
| Reckoners' & guards' cells | 10×5×3 | the live-in staff, sworn and paid never to climb the stair by day |

**Occupants:** The Reckoner, Old Kesk + counters & guards (16).

> The Reckoner Old Kesk + 15 (counters & guards), live-in for secrecy. The wedge's second 'novel' space — a laundering vault under a scholar-House, the Under-Terraces' darkest civic function.

#### SB-X04 · The Porters' Warren
*bunk-hall (Terran haulers)* — **r 250 m, a° 138**, footprint **28×18 m**, h 6 m, base y -18. Residents: **40**.

Home of the Terran haulers and conduit-crews who move what the Slack-Water Lock brings up and keep the wedge's dark plumbing running. Carved, glow-stone-warm, and pointedly incurious: the Warren's one rule is that you carry the crate and never ask what sings inside it. They are paid a little better than deep-folk elsewhere, which is how the House buys their lack of questions.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 16×9×6 | a communal hall; a Petrocore shrine, a long stone table, and a house rule chalked on the wall: ASK NOTHING |
| Sleeping galleries | 24×6×3 | bunk-niches for ~40 haulers and conduit-wrights |

**Occupants:** The Porters' Warren (40) — hall-elder Brud.

> ~40 Terran haulers & conduit-crew. Better-paid, better-fed, more silent than most under-halls — bought discretion has a texture of its own.

#### SB-X05 · The Blindside Canteen
*canteen / commons* — **r 248 m, a° 143**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The under-city's warm room for the wedge, so named because the one thing you learn to do here is not see. Haulers, reckoners' guards, water-gate crews and lock-hands eat the same grey stew and trade the same careful nothing; the canteen-keeper feeds everyone, keeps everyone's secrets, and is the most trusted person in the district precisely because she sells nothing.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, and no chalked names on the wall — here even the dead are discreet |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Canteen-keeper Mother Ollen + 3.

> Canteen-keeper Mother Ollen + 3. Sister-room to the other wedges' under-canteens; their runners meet, and Sabreth's runner is the one who listens more than she talks.

#### SB-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 151**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office where Sabreth's under-city answers to its over-city — but the foreman here reports to the Veilkeeper, not the customs hall, and the two counts he keeps are not honest-versus-official but public-versus-real. He is the man who knows exactly how much the House is lying, which is why he never, ever writes it down twice.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a burn-bowl, and a signal-cord to the Counting-Vault |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Adley.

> Foreman Adley — the seam-keeper who reports up the wrong stair. Twin-but-inverted to the other wedges' foremen: he protects a secret rather than reconciling a wrong.

#### SB-X07 · The Veiled Water-Gate
*private client dock (novel)* — **r 238 m, a° 150**, footprint **14×12 m**, h 6 m, base y -16. Residents: **6**.

How a client of the Omen Court arrives and leaves without ever having crossed a terrace or passed a customs desk: a low, lamplit, covered dock where a curtained boat slips in from the lock-water, and a veiled passenger climbs a stair that comes out behind a false wall in the Comet's Tail. The single most useful architecture in the wedge, and the one the House would burn the district to keep off any map.

| Room | Size (m) | Purpose |
|---|---|---|
| The Covered Dock | 10×6×5 | one boat-length of black water under a stone roof; no names spoken, no lamps bright |
| The Waiting Cells | 8×4×3 | curtained alcoves where clients wait unseen by one another; live-in gate-keepers who see everyone |

**Occupants:** The Veiled Water-Gate crew (6).

> 6 live-in gate-keepers/boatmen. The wedge's third novel space and the literal machinery of the 'beautiful open secret' — everyone knows the Court is here; no one can prove they came.

#### SB-X08 · The Nightside Bunks
*bunk-hall (human & orc labour)* — **r 252 m, a° 131**, footprint **22×15 m**, h 4 m, base y -18. Residents: **30**.

The bunk-hall of the human and orc labour who walk the lock capstans, pole the client-boats, and do the House's heavier and less mentionable errands. Kept apart from the Terran warren by old habit; kept quiet by the same well-paid discretion. The muscle of a House that pretends its trade is only paper and starlight.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk rows | 18×9×4 | riveted bunks for ~30; no window, and a foreman's whistle instead of a bell |
| The Cut-Room | 5×4×3 | where the boat-gangs are told their runs; a quiet, businesslike menace |

**Occupants:** The Nightside Bunks (30) — boat-gang leader Ghurr.

> ~30 human & orc labourers — the House's hands. Part of the unnamed 778; the ones who move the secrets and are the least allowed to keep their own.

### Who lives here — roster (24 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magistra Aubrelle Sabreth | Noctari | Head of House Sabreth; Reader of the Long-Haired Stars | The Sabreth Seat | The Long-Sight Tower |
| the Sabreth family (6) (×6) | Noctari | House family + resident 'guests' (leverage) | The Sabreth Seat | — |
| the Seat household & guard (17) (×17) | Noctari, 3 human, 2 orc | cook, dressers, doormen, guards, a discreet physician | The Sabreth Seat | The Sabreth Seat |
| the Night-Readers & interpreters (8) (×8) | Noctari | live-in comet-watchers who log the sky and price the omen | The Long-Sight Tower | The Long-Sight Tower |
| Nemora Sabreth, the Long-Sight (×7) | Noctari | the House's true prodigy; reads comet-paths a season ahead | The Long-Sight's Villa | The Long-Sight's Villa |
| Sarnauld Vray, the Veilkeeper (×8) | Noctari | commoner-born fixer; decides who is seen, when, and for what | The Veilkeeper's Villa | The Omen Court |
| 'Lady' Ombrise + household (7) (×7) | Noctari | charming front-resident; hostess of the deals no one speaks aloud | The Comfortable House | The Comfortable House |
| Master printer Pellon Sabreth + house (18) (×18) | Noctari | runs the Ephemeris-House; manufactures fate by the edition | The Ephemeris-House | The Ephemeris-House |
| The Fate-Scriveners' Row (24) — the crier Vess, old Halden (×24) | Noctari, some human | chart-copyists, charm-writers, criers, cheap freelance readers | The Fate-Scriveners' Row | — |
| Guild-mistress Cael Onwe + hall (12) (×12) | Noctari | perfumers & veil-makers; makers of the Court's atmosphere | The Perfumers' & Veil-Makers' Hall | The Perfumers' & Veil-Makers' Hall |
| Innkeeper Dosca Rell + house (6) (×6) | Noctari | keeps the Comet's Tail | The Comet's Tail | The Comet's Tail |
| Dalveen, Mistress of the Omen Court (×12) | Noctari | runs the night-market of fates; sees the whole floor, misses nothing | The Omen Court | The Omen Court |
| The Charm-Market (28) — Sesk, Two-Fingers Voll (×28) | Noctari, 3 human | charm-carvers, incense-sellers, comet-glass dealers, a herbalist | The Charm-Market | The Charm-Market |
| Lantern Walk dwellings (52) — the boat-girl Nella (×52) | Noctari, some human | readers, criers, doormen, incense-boys, boat-hands, market families | Canal Dwellings — Lantern Walk | — |
| Shrine-keeper Anselm + novice (×2) | Noctari | keeps the Shrine of the Turning; sells nothing | The Shrine of the Turning | The Shrine of the Turning |
| Customs officer Bren + 2 clerks (×3) | Noctari | runs the performatively-clean Sabreth customs post | Canal Dwellings — Lantern Walk | The Sabreth Customs & Processional Foot |
| The Conduit-wrights (6) (×6) | Terran | keep the Song singing to the star-lamps; tap the House's signal-code | The Porters' Warren | The Conduit Gallery |
| The Reckoner, Old Kesk + counters & guards (16) (×16) | Terran | master of the Counting-Vault; turns dirty coin into clean ledger-lines | The Counting-Vault | The Counting-Vault |
| The Porters' Warren (40) — hall-elder Brud (×40) | Terran | haulers & conduit-crew; carry what the lock brings and ask nothing | The Porters' Warren | — |
| Lock-master Ferrun Oskt | Terran | runs the Slack-Water Lock; keeps the two logs | The Porters' Warren | The Slack-Water Lock |
| Canteen-keeper Mother Ollen + 3 (×4) | Orc | keeps the Blindside Canteen | The Blindside Canteen | The Blindside Canteen |
| Foreman Adley | Human | seam-keeper who reports up the wrong stair, to the Veilkeeper | The Foreman's Post | The Foreman's Post |
| The Veiled Water-Gate crew (6) (×6) | human & Terran | boatmen & gate-keepers who bring clients in unseen | The Veiled Water-Gate | The Veiled Water-Gate |
| The Nightside Bunks (30) — boat-gang leader Ghurr (×30) | human & orc | capstan-labour, client-boat polers, the House's heavier errands | The Nightside Bunks | — |

| Band | Souls |
|---|---|
| Rim / House seat | 32 |
| Upper terraces | 22 |
| Middle terraces | 54 |
| Canal quarter | 100 |
| Shore | 0 |
| Under-Terraces | 103 |
| **Total** | **311** |

> ≈ 311 souls here; **103 of them in the Under-Terraces**, on no official map.

## House Ilmyra — *Keepers of the Tides of the Song*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### IL-T01 · The Tideglass Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 180**, footprint **⌀22 m**, h 56 m, 6 storeys, base y 45. Residents: **6**.

Where Starfall reads the moons and the slow tide the Song makes in all still water. Not a tower of fixed certainties like Vael'Suran's but a tower of returns: everything it measures comes back around. Its instrument is a tall glass column of star-water whose level rises and falls a finger's breadth on the Song's long cycle, and the whole House's calendar of locks and festivals is set by watching it.

| Room | Size (m) | Purpose |
|---|---|---|
| The Tideglass Hall | 16×16×10 | the great graduated water-column and its floating marker; the reading is taken at moonrise and moonset |
| The Moon-Room | 12×10×6 | an aperture aligned to the risings of the three moons; charts of their long braided cycle line the walls |
| Head's study | 8×7×4 | Magistra Vessa's study, its window framing the moon's path over the Mirror |
| Gaugers' room | 12×8×4 | junior gaugers reduce the tide-readings and copy the lock-tables the barge-masters buy |
| The Cistern-head & stair | 6×6×30 | the spiral stair; the tideglass is fed from the deep water far below by a single hair-fine pipe that must never be let run dry |

**Occupants:** Magistra Vessa Ilmyra; First Gauger Pallun Ree; the junior gaugers (4).

> Head + First Gauger + 4 live-in junior gaugers. Its lit finial is one of the greybox's nine rim domes; alone of the nine it is trimmed to burn brighter at the full moons.

#### IL-M01 · The Ilmyra Seat
*great house (manor)* — **r 438 m, a° 173**, footprint **32×20 m**, h 13 m, 3 storeys, base y 45. Residents: **18**.

A damp, beautiful, rhythmic house built around an open moon-court — a shallow reflecting pool at its centre that is filled and drained on the tide-calendar, so the Seat is mirror-bright some weeks and a dry tiled basin others. Ilmyra money is barge money and lock-toll money, made from moving water and what floats on it, and the House lives by rise and fall the way other Houses live by rank.

| Room | Size (m) | Purpose |
|---|---|---|
| The Moon-Court | 14×14×12 | an open inner court with a tiled reflecting pool, filled and drained to the calendar; the House takes its readings without leaving home |
| The Ebb Hall | 12×9×6 | reception; a frieze of the three moons in their braided cycle, and a tide-mark on the wall from the year the canals overtopped |
| Vessa's chambers | 9×8×4 | the matriarch's rooms, over the moon-court |
| Family wing | 14×7×4 | four chambers for the near family |
| Kitchen, stores, staff | 12×8×4 | household below and attic rooms for staff |

**Occupants:** the Ilmyra family (5); the Seat household staff (12).

> Vessa + near family (5) + 12 household staff (incl. a pool-keeper whose whole post is the moon-court's filling and draining).

### The Upper Terraces

#### IL-U01 · Moonrise Villa — Sael
*senior scholar's villa* — **r 368 m, a° 190**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

The villa of the House's Tide-Lunist, whose sightline is surveyed not to the Mirror in general but to the exact point on the far rim where the largest moon clears the wall at midsummer. He argues the three moons and the Song's tide are one motion seen two ways, and that the lock-cycle is a liturgy nobody has noticed is a liturgy.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lunar Study | 10×8×5 | the moonrise sightline; a floor inlaid with the three moons' braided path |
| Family rooms | 13×6×4 | the Lunist, a companion, two children, one student |

**Occupants:** Tide-Lunist Orrin Sael.

> Tide-Lunist Orrin Sael + household. A theory-thread toward the Academy's Song-work, as the Serenthil horologist is.

#### IL-U02 · The Lock-Warden's Villa
*senior officer's villa* — **r 366 m, a° 180**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

Home of the Lock-Warden, the commoner-born officer who actually times the great Lock-Flight and every canal sluice in the wedge — the man whose hand is on the city's whole water economy, and who has never once been asked to dine at the Seat. He keeps a working tide-model in his front room and trusts it further than any Magister.

| Room | Size (m) | Purpose |
|---|---|---|
| The Model Room | 9×7×5 | a plumbed brass-and-glass model of the Lock-Flight he runs it by; it leaks, and he loves it |
| Family rooms (x3) | 13×6×4 | the Lock-Warden, spouse, 3 children |

**Occupants:** Lock-Warden Dov Marrenh.

> Lock-Warden Dov Marrenh + household. The Halvenor/Ostreth pattern — the commoner who really runs the House's work.

#### IL-U03 · The Pool House
*senior dwelling (eccentric)* — **r 372 m, a° 166**, footprint **15×13 m**, h 8 m, 2 storeys, base y 34. Residents: **5**.

A villa given over almost entirely to a private tidal pool that its owner, a wealthy retired barge-mistress, fills from the canal-race so she can watch her own small tide turn each night. The upper terrace considers it vulgar to spend a sightline villa on water rather than a view; she considers the upper terrace to have never once looked at water properly.

| Room | Size (m) | Purpose |
|---|---|---|
| The Private Pool | 10×9×6 | a roofed tidal pool, dark and still, that rises and falls on a bled-off share of the canal-race |
| Living rooms | 12×5×4 | the barge-mistress + a companion + two boarders + a servant |

**Occupants:** Retired barge-mistress Halvenna Oon.

> Retired barge-mistress Halvenna Oon + 4. New money from the barge trade, holding a sightline villa and using it wrong on purpose.

### The Middle Terraces

#### IL-L01 · The Lockwrights' Hall
*guild-hall + workshop* — **r 318 m, a° 186**, footprint **22×16 m**, h 10 m, 2 storeys, base y 23. Residents: **15**.

Wet, heavy, and essential: the guild that builds and maintains every lock-gate, sluice, valve and paddle in Starfall's water — hinges the size of a man, timber that must be kept swelled, seals of tallow and star-reed. A lock-gate that fails does not simply stop; it empties a terrace into the one below, so the Lockwrights are trusted with the city's actual weight of water and paid, grudgingly, accordingly.

| Room | Size (m) | Purpose |
|---|---|---|
| The Gate Floor | 16×10×7 | great gates laid flat for fitting; a wet-pit for testing seals under head of water |
| The Paddle Shop | 8×6×5 | sluice-paddles and their gearing, cut to the Lock-Warden's tables |
| Master's dwelling | 14×6×4 | the master lockwright's family above the works |
| Journeymen's loft | 12×5×3 | boarded gate-wrights |

**Occupants:** Master lockwright Bruska Fenn + household (15).

> Master lockwright Bruska Fenn + family + 9 journeymen. Works hand-in-glove with the under-city Lock-Gangs (IL-X03); half the Hall is up top, half its labour is down below.

#### IL-L02 · The Gaugers' House (Tide-Tables)
*computation hall + press* — **r 312 m, a° 178**, footprint **20×13 m**, h 9 m, 3 storeys, base y 23. Residents: **10**.

Where the moons' braided cycle is turned into numbers a barge-master can use: the tide-tables and lock-timings for the season ahead, computed by hand and printed on the House's own press. Every barge that ever climbed to Starfall did it by a page bought here. Quiet, inky, and quietly powerful — to mis-set a table is to strand a season's cargo.

| Room | Size (m) | Purpose |
|---|---|---|
| The Reckoning Floor | 14×8×5 | ranked desks of gaugers reducing the tideglass readings into tables |
| The Press Room | 8×6×4 | the House press; tide-tables, almanacs, lock-schedules struck in silver ink |
| Gaugers' dormitory | 14×5×3 | boarded gaugers |

**Occupants:** Chief gauger Present Ollav-Ree + house (10).

> Chief gauger Present Ollav-Ree + 9. The mathematical twin of Serenthil's clock-work: one House counts the hour, this one counts the water.

#### IL-L03 · Lesser Watermen's Row
*terrace of 6 dwellings* — **r 300 m, a° 170**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **24**.

Six joined houses of the wedge's lesser watermen — the sluice-tenders, gaugers' clerks, paddle-boys and canal-sweeps who keep the water moving without ever setting a table or holding a warrant. Respectable, damp, and paid in the House's steady lock-toll coin.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: work-room + 2 chambers | 6×7×4 | 6 households of watermen |

**Occupants:** Lesser Watermen's Row (24) — sluice-tender Merrow.

> 6 households, ~24 souls. Named: the sluice-tender Merrow, who can tell the tide's height by the sound the paddles make.

### The Canal Quarter

#### IL-K01 · The Drowned Moon
*inn (Strain-relief haven)* — **r 268 m, a° 192**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **5**.

The wedge's inn, right on the barge-basin, low enough that at the top of a spring tide the canal comes in over the sill and the regulars simply lift their feet onto the bench-rails and drink on. Bargefolk, lock-gangs off shift, and the occasional stranded traveller from the world below all wash up here. This wedge's Strain-relief haven, and the softest, wettest room in Starfall.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, long tables with foot-rails against the flood; a tide-mark ladder painted up the doorframe and a drowned moon (a lantern) hung under glass |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above, above the flood-line |
| Cellar (wet) | 8×6×3 | half-flooded by design; the beer floats in cages, and a hatch opens onto the lock-flight below |

**Occupants:** Innkeeper Coll Marsh + house (5).

> Innkeeper Coll Marsh + 2 family + 2 staff. The wet cellar hatch is Ilmyra's over/under seam (to IL-X01). Sister-haven to the Sounding-Glass (VS-K01) and the Ninth Bell (SR-K01).

#### IL-K02 · The Barge-Basin & Chandlery
*turning basin + market (ship's-chandlers)* — **r 255 m, a° 184**, footprint **34×26 m**, h 7 m, 2 storeys, base y 12. Residents: **33**.

The head of navigation: a broad turning-basin where the barges that climb the Lock-Flight tie up, unload, and turn, ringed by a quay of ship's-chandlers — rope, pitch, star-reed caulk, victuals, timber, and the tide-tables from the Gaugers' House. The one place in the visible city where the world-below arrives in the open, on the water, in daylight; and the House takes a toll on every keel.

| Room | Size (m) | Purpose |
|---|---|---|
| The Basin & Quays | 24×18×0 | open star-water basin, mooring-rings, the toll-house with its warded strongbox |
| Chandlers' row | 30×6×4 | twelve chandler shops and stores, most with a family living above |

**Occupants:** The Barge-Basin & Chandlery (33) — dealer Pesh, toll-clerk Ammary.

> 12 chandler households + toll-clerks, ~33 souls. Named: the caulk-and-reed dealer Pesh, and the toll-clerk Ammary who has memorised every barge-master's face.

#### IL-K03 · The Shrine of the Three Moons
*shrine (Umbrion / lunar rite)* — **r 250 m, a° 176**, footprint **12×12 m**, h 9 m, 1 storeys, base y 12. Residents: **2**.

A shrine to Umbrion under his lunar aspect — three silver bowls of star-water set to catch the three moons, tended so their levels track the sky. Bargefolk pour a thimble of water in before a climb and take one out after a safe descent, so the bowls are a running ledger of the wedge's fear and gratitude. Devotions are timed to moonrise, not to the bell, which quietly annoys House Serenthil.

| Room | Size (m) | Purpose |
|---|---|---|
| The Moon-Bowls | 8×8×7 | three tiered silver basins open to the sky; the water is never allowed to still completely |
| Keeper's cell | 4×4×3 | the shrine-keeper's room |

**Occupants:** Moon-keeper Senna + apprentice.

> Moon-keeper Senna + a mute apprentice. A watery counterpart to Vael'Suran's Deepening (VS-K03) — the same god, tended through water and moon instead of pure dark.

#### IL-K04 · Canal Dwellings — Basinside
*tenement block, 9 dwellings* — **r 245 m, a° 168**, footprint **26×14 m**, h 11 m, 3 storeys, base y 12. Residents: **50**.

The wedge's densest housing, stacked three storeys over the basin: bargefolk families who work the water above the flood-line and the boatwrights, netmakers, and lightermen who serve the traffic. The ground floor is given to boats in winter and to children in summer, and the whole block reads the day by the height of the water at its door.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 9 dwellings, families of 3-6 |

**Occupants:** Basinside dwellings (50) — boatwright Oram, pilot-widow Cael.

> ~50 souls. Named: the boatwright Oram, and the pilot-widow Cael, who guides new barge-masters up the flight for a coin and a story.

#### IL-K05 · The Tide-Hall
*ceremonial moon-pool (NOVEL landmark)* — **r 262 m, a° 180**, footprint **28×24 m**, h 12 m, 1 storeys, base y 12. Residents: **6**.

The visible heart of the wedge and its 'novel and unique' landmark: a great colonnaded hall built around a circular pool of star-water that VISIBLY rises and falls — a full slow breath, floor to knee-height and back — over the Song's long tide-cycle, driven from the same deep water and lock-race that runs the whole city. Citizens come to sit at its rim and watch the water go out and come in, which is the nearest thing the Noctari have to prayer. At the flood it mirrors the whole hall; at the ebb it shows a mosaic floor of the three moons, dry, that no one sees but twice a month.

| Room | Size (m) | Purpose |
|---|---|---|
| The Breathing Pool | 20×20×12 | the circular tidal pool and its ring of black basalt steps; a graduated pillar at the centre marks the reach of each tide |
| The Colonnade | 26×4×12 | a sheltered walk around the pool where the House holds the moon-festivals and the barge-blessings |
| The Sluice-Chapel | 6×5×6 | where the keeper controls the fill and drain; the machinery is treated as holy and kept behind a screen |

**Occupants:** Tide-Hall keeper Haldis + attendants (6).

> Tide-Hall keeper Haldis + 5 (attendants who live in the colonnade cells). The BEAUTIFUL, ceremonial upper face of the water — its laboring lower face is the Lock-Flight (IL-X01) directly below. Same water, two faces: the Ilmyra doubling, mirroring Serenthil's festival-bell / shift-bell split.

### The Shore & Processionals

#### IL-S01 · The Water-Gate & Back Landing
*civic threshold (barge customs)* — **r 228 m, a° 180**, footprint **16×10 m**, h 6 m, 1 storeys, base y 0. Residents: **0**.

The city's back door, where the lesser rear-processional meets the shore and the canal meets the star-lake through a warded water-gate. This is the customs post for everything that arrives by barge rather than by the front stair — the working threshold to Vael'Suran's ceremonial one across the caldera. What comes up the Lock-Flight is weighed and tallied here before the water is allowed to carry it into the city.

| Room | Size (m) | Purpose |
|---|---|---|
| The Water-Gate Hall | 11×7×5 | the gate machinery, the weighing-quay, a tally-desk and warded strongroom |
| Officers' room | 5×4×4 | the water-customs officer and two clerks |

**Occupants:** Water-customs officer Trennt + 2 clerks.

> Water-customs officer Trennt + 2 clerks (day post; counted at their canal homes). The back-door twin of the Vael'Suran/Serenthil front gates — but this door faces the WATER, and the water comes from below.

### The Under-Terraces

#### IL-X01 · The Lock-Flight
*barge lock-staircase (major service works)* — **r 248 m, a° 180**, footprint **82×14 m**, h 16 m, base y -20. Residents: **0**.

The laboring lower face of all this beautiful water: a staircase of six great chamber-locks that lifts loaded barges from the cloud-world far below the caldera, chamber by chamber, up into the city's canals. Every stone, sack, cask and lamp that the terraces above consume climbs this flight in the dark, walked up by gangs on the paddle-capstans. The Plate draws the Tide-Hall's breathing pool and stops; it does not draw the six locks and the gangs directly beneath it that make the pretty water move at all.

| Room | Size (m) | Purpose |
|---|---|---|
| The Six Chambers | 12×66×14 | the stepped lock-basins and their counter-weighted gates; a barge takes half a shift to climb the flight |
| The Capstan Galleries | 6×60×4 | side galleries where the lock-gangs walk the paddle-capstans that fill and empty each chamber |
| The Tally-Cut | 4×4×3 | the under-clerk's niche at the head of the flight, where the true cargo-count is kept in charcoal |

**Occupants:** The Lock-Flight under-clerk & signal-crew (worked by IL-X03).

> Worked, not lived-in (its gangs bunk in IL-X03). The under-clerk keeps the Other Map's tally here. Directly beneath the Tide-Hall (IL-K05): same water, two faces — glory above, labour below.

#### IL-X02 · The Conduit-and-Sluice Gallery
*conduit + sluice-control gallery* — **r 260 m, a° 186**, footprint **66×5 m**, h 4 m, base y -10. Residents: **6**.

The wedge's Song-conduits that feed its star-lamps, run in the same gallery as the sluice-controls that time the Lock-Flight and the Tide-Hall's breathing. When a lamp burns on the terraces or the great pool draws its slow breath, the cause is a crew kneeling in this tunnel setting paddles and truing crystal in the dark.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 5×66×4 | conduit and sluice-rods side by side; access ladders to each terrace and to the lock-chambers |
| Sluice-house | 4×4×3 | the master sluice that sets the Tide-Hall's rise and fall — treated by the crew as the thing that must never be got wrong |

**Occupants:** The Conduit-and-Sluice Crew (6).

> Conduit-and-sluice crew (6, mixed Terran & human). They, not the moon, decide when the Tide-Hall breathes — a fact the worshippers above would rather not hold in mind.

#### IL-X03 · The Lock-Gangs' Hall
*bunk-hall (Terran gate-wrights + haulers)* — **r 250 m, a° 174**, footprint **30×20 m**, h 6 m, base y -18. Residents: **52**.

Home of the gangs who work the Lock-Flight: Terran gate-wrights who keep the great gates swelled and true, alongside the human and orc haulers who walk the capstans that lift the barges. Damp, warm with glow-stone, and loud with running water through the wall. The proudest boast here is a flight climbed with no cargo lost, and the oldest hands can name every barge-master who ever thanked them and every one who never did.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | a communal hall; a long table, a Petrocore shrine, and a wall-carving of the flight kept by the gate-wrights |
| Sleeping galleries | 24×6×3 | bunk-niches for ~52 gate-wrights and haulers |
| The Wet-Room | 6×5×3 | where soaked gear is dried and the drowned are laid out — the flight takes someone most seasons |

**Occupants:** The Gate-Wrights (24) — old gate-wright Dross; The Lock-Haulers (28).

> ~24 Terran gate-wrights + ~28 human/orc haulers. Works hand-in-glove with the up-top Lockwrights' Hall (IL-L01). Part of the unnamed 778.

#### IL-X04 · The Bargefolk Undershelter
*transient dwelling (bargefolk of the world below)* — **r 242 m, a° 170**, footprint **32×18 m**, h 5 m, base y -16. Residents: **64**.

The liminal, half-counted population of the wedge: bargefolk from the cloud-world below who bring cargo up the flight and shelter here between climbs — people who are not quite of Starfall and never will be, who keep their own tongue, their own gods, and their families aboard. The city needs everything they carry and grants them nothing but this vaulted room and a moon-tinted view of the water they arrived on. The most foreign faces in Starfall, living directly under its most beautiful pool.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Shelter | 24×8×5 | a vaulted dormitory of bunks and hammocks; families curtain off corners; a shrine to gods the terraces have never heard named |
| The Undermoorings | 10×8×5 | a covered basin where empty barges wait their turn down the flight |

**Occupants:** The Bargefolk of the flight (~64).

> ~64 transient bargefolk (fluctuates with the season). A distinct outsider population — neither the elite above nor the settled under-city labour, but the road-people of the water. Rich quest and worldbuilding ground; part of the uncounted the whole game is about.

#### IL-X05 · The Slackwater Canteen
*canteen / commons* — **r 248 m, a° 182**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The warm room where the under-city of the water eats: lock-gangs, sluice-crews, and bargefolk share one long trestle over fish from the lake-shore nets and bread come up the flight. Named for the slack of the tide, the still hour between rise and fall when the locks rest and everyone comes up to be fed. The keeper reads the tide by the draught under the door and rings no bell — she just knows when slackwater comes.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, a wall of chalked names and a second wall of names in a script the terraces can't read |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Canteen-keeper Mother Ilse + 3.

> Canteen-keeper Mother Ilse + 3 helpers. Sister-room to the Underspill (VS-X05) and the Undertoll (SR-X05); the three under-canteens' keepers are the real government of the dark.

#### IL-X06 · The Lockmaster's Post
*overseer post* — **r 242 m, a° 188**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office of Ilmyra's under-city, at the foot of the stair up to the Water-Gate, where the flight's cargo-count and the drowned-count are reconciled and sent up to the House. The Lockmaster is the one person who both sets foot in the Tide-Hall's colonnade and knows the name of the last hauler the flight killed.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a soaked shift-book, a working model of the flight in a glass tank |
| Bunk | 3×3×3 | the Lockmaster sleeps at the seam, listening to the water |

**Occupants:** Lockmaster Vel.

> Lockmaster Vel — the seam of the water-wedge; keeps the honest count in charcoal and the House's in ink. Twin to Foreman Adric (VS-X06) and Foreman Quill (SR-X06).

### Who lives here — roster (24 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magistra Vessa Ilmyra | Noctari | Head of House Ilmyra; Keeper of the Tides of the Song | The Ilmyra Seat | The Tideglass Tower |
| First Gauger Pallun Ree | Noctari | senior observer of the tideglass and the moons | The Tideglass Tower | The Tideglass Tower |
| the junior gaugers (4) (×4) | Noctari | live-in gauging clerks | The Tideglass Tower | The Tideglass Tower |
| the Ilmyra family (5) (×5) | Noctari | House family | The Ilmyra Seat | — |
| the Seat household staff (12) (×12) | Noctari & 2 human | cook, pool-keeper, porters, maids | The Ilmyra Seat | The Ilmyra Seat |
| Tide-Lunist Orrin Sael (×6) | Noctari | moon-and-tide theorist; argues the moons and the Song's tide are one motion | Moonrise Villa — Sael | Moonrise Villa — Sael |
| Lock-Warden Dov Marrenh (×6) | Noctari | commoner-born officer who times the Lock-Flight and every canal sluice | The Lock-Warden's Villa | The Lock-Flight |
| Retired barge-mistress Halvenna Oon (×5) | Noctari | wealthy new-money tenant of a sightline villa given over to a private tidal pool | The Pool House | — |
| Master lockwright Bruska Fenn + household (15) (×15) | Noctari | runs the Lockwrights' Hall; builds and maintains every lock-gate in the city | The Lockwrights' Hall | The Lockwrights' Hall |
| Chief gauger Present Ollav-Ree + house (10) (×10) | Noctari | computes the tide-tables and lock-timings; runs the House press | The Gaugers' House (Tide-Tables) | The Gaugers' House (Tide-Tables) |
| Lesser Watermen's Row (24) — sluice-tender Merrow (×24) | Noctari, 1 human household | sluice-tenders, gaugers' clerks, paddle-boys, canal-sweeps | Lesser Watermen's Row | — |
| Innkeeper Coll Marsh + house (5) (×5) | Noctari | keeps The Drowned Moon | The Drowned Moon | The Drowned Moon |
| The Barge-Basin & Chandlery (33) — dealer Pesh, toll-clerk Ammary (×33) | Noctari, 3 human, 1 Terran | ship's-chandlers, victuallers, toll-clerks | The Barge-Basin & Chandlery | The Barge-Basin & Chandlery |
| Moon-keeper Senna + apprentice (×2) | Noctari | keeps the Shrine of the Three Moons | The Shrine of the Three Moons | The Shrine of the Three Moons |
| Basinside dwellings (50) — boatwright Oram, pilot-widow Cael (×50) | Noctari, some human | bargefolk families, boatwrights, netmakers, lightermen | Canal Dwellings — Basinside | — |
| Tide-Hall keeper Haldis + attendants (6) (×6) | Noctari | keeps the Tide-Hall; controls the breathing pool's fill and drain | The Tide-Hall | The Tide-Hall |
| Water-customs officer Trennt + 2 clerks (×3) | Noctari | weighs and tallies everything that comes up the flight by water | Canal Dwellings — Basinside | The Water-Gate & Back Landing |
| The Lock-Flight under-clerk & signal-crew (worked by IL-X03) | Terran & human | keep the true cargo-count and signal the chambers; bunk in the Lock-Gangs' Hall | The Lock-Gangs' Hall | The Lock-Flight |
| The Conduit-and-Sluice Crew (6) (×6) | Terran & human | keep the Song-conduits and set the sluices that time the Tide-Hall and the flight | The Lock-Gangs' Hall | The Conduit-and-Sluice Gallery |
| The Gate-Wrights (24) — old gate-wright Dross (×24) | Terran | keep the Lock-Flight's great gates swelled, sealed and true | The Lock-Gangs' Hall | — |
| The Lock-Haulers (28) (×28) | human & orc | walk the paddle-capstans that lift the barges chamber by chamber | The Lock-Gangs' Hall | — |
| The Bargefolk of the flight (~64) (×64) | human, orc, and cloud-world folk | road-people of the water; bring cargo up the flight and shelter between climbs | The Bargefolk Undershelter | — |
| Canteen-keeper Mother Ilse + 3 (×4) | Orc | keeps the Slackwater Canteen | The Slackwater Canteen | The Slackwater Canteen |
| Lockmaster Vel | Human | the seam of Ilmyra's under-city; reconciles the flight's cargo-count and drowned-count | The Lockmaster's Post | The Lockmaster's Post |

| Band | Souls |
|---|---|
| Rim / House seat | 24 |
| Upper terraces | 17 |
| Middle terraces | 49 |
| Canal quarter | 96 |
| Shore | 0 |
| Under-Terraces | 127 |
| **Total** | **313** |

> ≈ 313 souls here; **127 of them in the Under-Terraces**, on no official map.

## House Corvane — *Scholars of the Deep Field*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### CV-T01 · The Tower of the Empty Ring
*observatory tower (House seat, upper)* — **r 422 m, a° 220**, footprint **⌀22 m**, h 54 m, 6 storeys, base y 45. Residents: **6**.

Alone among the nine, this tower measures nothing. Its great instrument is trained on the deep field — the black gaps where no light is — and its records are ledgers of absence, columns of nothing observed, growing more precise each year. The other Houses light finials to be seen; Corvane's dome is the dimmest on the rim, on purpose, because you cannot read the dark by lamplight.

| Room | Size (m) | Purpose |
|---|---|---|
| The Hall of the Empty Ring | 20×20×8 | ground instrument hall; a great ring-armature that frames a chosen patch of void and holds it steady for a lifetime of watching |
| The Ledger of Absence | 10×8×4 | a vault of black-bound books recording what was not there; the House's true wealth and its unease |
| Head's cell | 8×7×4 | Magister Vaelith's study — one chair, one shuttered slit, no lamp |
| The Counting Dark | 12×8×4 | where junior scholars reduce the night's non-observations; they work by touch and memory more than sight |
| The Aperture Chamber | 12×12×12 | top floor; the roof opens onto a single fixed patch of deep field; the reading is a long, cold act of not-looking-away |
| Servants' stair & the unlit lamp | 4×4×28 | the spiral stair; a finial that is kept, and cleaned, and never lit |

**Occupants:** Magister Vaelith Corvane; First Watcher Oel-Vane; the void-computers (5).

> Head works here, sleeps at the Seat. Senior observer + 5 live-in computers. The tower's dark dome is one of the nine on the greybox rim — the one visitors always mistake, at first, for the dead House.

#### CV-M01 · The Corvane Seat
*great house (manor)* — **r 438 m, a° 227**, footprint **32×22 m**, h 13 m, 3 storeys, base y 45. Residents: **16**.

An austere seat with fewer windows than any House on the rim — Corvane does not decorate itself with the view, it studies what the view leaves out. The halls are kept deliberately underlit; guests learn to move by the sound of their own feet. It is a proud, hushed, faintly dreaded house, and the other Houses accept its invitations rarely and leave early.

| Room | Size (m) | Purpose |
|---|---|---|
| The Unlit Hall | 13×10×6 | reception in near-dark; the walls hung with framed patches of empty sky, each labelled with a date and a nothing |
| Vaelith's chambers | 9×8×4 | the head's rooms; a window bricked up by a former head and never reopened |
| Family wing | 15×7×4 | three chambers for the near family, who are few — the House does not breed freely |
| The Listening Court | 12×12×12 | an open court roofed only by the deep field; the House sits here in silence at new-moon, together, saying nothing |
| Kitchen, stores, staff | 12×8×4 | the household below and in the attics |

**Occupants:** Magister Vaelith Corvane; the Corvane near family (3); the Seat household staff (12).

> Magister Vaelith + near family (3) + 12 staff. The staff are paid above the rim's rate — Corvane servants are hard to keep.

### The Upper Terraces

#### CV-U01 · Villa of the Long Look
*senior scholar's villa* — **r 370 m, a° 206**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **5**.

Home of the scholar who has watched a single hand's-breadth of empty sky for two hundred and forty years, waiting for it to change. It has not. Her sightline is protected not toward the Mirror, like her neighbours', but past it and up, at nothing — a legal oddity the House court fought for decades to defend.

| Room | Size (m) | Purpose |
|---|---|---|
| The Watching Room | 10×8×5 | a chair bolted to the floor at the one correct angle; a chart of a patch of dark, unchanged, re-inked yearly for the discipline of it |
| Living rooms | 13×6×4 | the scholar, a companion, two grown students |

**Occupants:** Magistra Ysoreth of the Long Look; Ysoreth's household (4).

> Magistra Ysoreth of the Long Look + household of 4. A study in devotion to the unrewarding — the House's whole ethos in one villa.

#### CV-U02 · The Warded Study
*senior scholar's villa (restricted)* — **r 366 m, a° 214**, footprint **13×11 m**, h 9 m, 2 storeys, base y 34. Residents: **4**.

The villa where the House keeps the theory it does not copy into the public halls — the dangerous mathematics of drawing the void toward you rather than merely watching it. Its door carries a real ward, and the Academy's own void-scholars visit it by night and sign no register. What is worked out here is a generation ahead of anything the Conclave has approved, and a generation is exactly long enough to be too late.

| Room | Size (m) | Purpose |
|---|---|---|
| The Sealed Room | 8×7×5 | warded; the restricted theory in black ledgers chained to the shelf |
| Warden's rooms | 12×6×4 | the keeper of the study and a single trusted student |

**Occupants:** Magister Oren Corvane.

> Magister Oren Corvane, keeper of the restricted theory, + household of 3. This is, quietly, where the intellectual seed of the Nullstone lives — the room the Academy borrows from without admitting it.

#### CV-U03 · The Vacant Villa
*senior villa (kept empty)* — **r 372 m, a° 234**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **1**.

The villa of a scholar who, thirty years ago, walked out to his watching-chair one clear night and was simply not there in the morning — no body, no note, the chart still weighted open. The House pays a caretaker to keep it exactly as he left it, and pays her not to speak of why.

| Room | Size (m) | Purpose |
|---|---|---|
| The Room As Left | 9×7×4 | dusted daily, the chair still angled at the dark, the chart still open to the same page |
| Caretaker's room | 5×4×4 | the one warm corner of a cold house |

**Occupants:** Caretaker Nel.

> Caretaker Nel, alone. A quiet horror the wedge does not discuss; a strong side-quest seed (what the chart was open to).

### The Middle Terraces

#### CV-L01 · The Hall of Negative Results
*guild-hall + lodging* — **r 314 m, a° 209**, footprint **22×14 m**, h 11 m, 3 storeys, base y 23. Residents: **15**.

Where the House's ledgers of absence are fair-copied, cross-checked and bound, and where its scribes lodge. To copy a Corvane ledger is to transcribe nothing, exactly, for a lifetime — a discipline that produces a particular kind of scribe: patient, unsmiling, and very hard to lie to. The most reliable hands in the city are trained here, and the strangest.

| Room | Size (m) | Purpose |
|---|---|---|
| The Copying Dark | 20×10×5 | sloped desks under hooded lamps that light only the page, never the room |
| The Cross-Check Room | 10×8×4 | where two scribes read absence against absence to catch the single night someone saw something |
| Scribes' dormitory | 18×6×4 | 14 cots; the quietest sleepers in Starfall |

**Occupants:** Master-scribe Corriden; the ledger-scribes (14).

> Master-scribe Corriden + 14 scribes and lodgers. Twin in function to Vael'Suran's Scribes' Hall, opposite in temperament.

#### CV-L02 · The Black-Mirror Workshop
*workshop + dwelling* — **r 320 m, a° 221**, footprint **18×15 m**, h 8 m, 2 storeys, base y 23. Residents: **10**.

Makers of the instruments that drink light instead of gathering it — black speculum mirrors, void-glass, the hooded lamps and light-baffles the whole wedge runs on. A wet, patient, slightly feared trade; the family that keeps it has learned to grind a mirror so dark it shows you the room behind your own head.

| Room | Size (m) | Purpose |
|---|---|---|
| The Figuring Shed | 12×8×5 | pitch laps and the black-glass melt; a speculum is polished for months to hold a perfect nothing |
| The Proving Dark | 6×5×4 | a lightless room where a finished mirror is proved against the absence of any star |
| Family dwelling | 14×6×4 | the Vess family above the shed |

**Occupants:** Master mirror-wright Dela Vess + household (10).

> Master mirror-wright Dela Vess + household + journeymen (10). The black-glass melt vents to an Under-Terrace flue.

#### CV-L03 · Lesser Scholars' Row
*terrace of 6 small dwellings* — **r 300 m, a° 231**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **20**.

Six joined houses of the wedge's lesser scholars — the reducers and copyists who serve the ledgers of absence without a watching-chair of their own. Sightless, sunless, and paid in the House's steady, cold coin. They keep, between them, a shared candle they light only for births and deaths.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: work-room + 2 chambers | 6×7×4 | 6 households |

**Occupants:** Lesser Scholars' Row (20) — the copyist Wren.

> 6 households, ~20 souls. Named: the copyist Wren, who has begun, against every rule, to hope the dark she records will one day answer.

### The Canal Quarter

#### CV-K01 · The Last Lamp
*inn (Strain-relief haven)* — **r 268 m, a° 207**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **6**.

The wedge's inn, named for the single lamp the keeper swears he will never let go out — the joke and the comfort of a quarter that spends its days staring into the dark. Dimmer and quieter than any other inn in the city, but warmer for it; the place Corvane scholars come to be, for one evening, in a lit room full of noise.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, low tables, the one lamp kept burning above the bar like a small defiance |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above |
| Cellar | 8×6×3 | canal-cooled store; a hatch to the Under-Terraces the keeper pretends not to know about |

**Occupants:** Halb Oren + house (6).

> Innkeeper Halb Oren + 3 family + 2 staff. The cellar hatch is Corvane's over/under seam (to CV-X05).

#### CV-K02 · The Mourning Market
*market row (dark instruments & mourning goods)* — **r 258 m, a° 216**, footprint **30×10 m**, h 6 m, 2 storeys, base y 12. Residents: **28**.

The wedge's market leans, by long habit, into the House's temperament: sellers of black-glass and hooded lamps, of mourning-silks and grave-silver, of the still, dark things the rest of the city buys only when someone has died and then comes here to buy. Quietly, it is the richest market in Starfall — grief keeps steadier hours than fashion.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + workshop + room above | 3×8×4 | 10 units, most with a family living above |

**Occupants:** The Mourning Market (28).

> 10 shops, ~28 souls. Named: the silversmith Made, who casts grave-tokens, and the lamp-hooder Sulen.

#### CV-K03 · The Deep Shrine of Umbrion
*shrine (Umbrion — the great shrine)* — **r 250 m, a° 225**, footprint **14×14 m**, h 11 m, 1 storeys, base y 12. Residents: **3**.

Not a small shrine like the Vael'Suran Deepening but THE shrine — the great dark heart of Umbrion-worship in Starfall, tended by the House that understands the god best. You descend a black stair into a cold sphere and are asked to sit until the difference between your eyes open and closed stops mattering. The devout come out changed; a few do not come out at all until they are ready, and the shrine feeds them and waits.

| Room | Size (m) | Purpose |
|---|---|---|
| The Descent | 4×8×6 | a black stair down; the last light is left at the top |
| The Sphere | 10×10×9 | a round dark cell where the void is offered as presence; a bowl of still star-water at the centre, found by memory |
| Keepers' cells | 5×4×3 | the shrine-keeper and two acolytes |

**Occupants:** Keeper Onn + two acolytes.

> Keeper Onn and two acolytes. The theological centre of the wedge's whole disposition — and of Elorin Voidweaver's own faith, though she is not from here.

#### CV-K04 · Canal Dwellings — Nightside
*tenement block, 9 dwellings* — **r 245 m, a° 233**, footprint **26×14 m**, h 11 m, 3 storeys, base y 12. Residents: **44**.

The wedge's densest housing, on the shaded canal-bank that never takes the reflected lake-light — the artisans, lamp-hooders, mirror-wrights' families and canal-hands who keep the dark quarter running. A close, quiet, watchful block; neighbours here know each other's silences.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 9 dwellings, families of 3-6 |

**Occupants:** Nightside dwellings (44) — the widow Oll; Customs officer Sael + clerk.

> ~44 souls, including the customs officer's household (counted here, works at the shore post CV-S01). Named: the widow Oll, who reads the ledger of absence for pleasure.

#### CV-K05 · The Watcher's House
*small dwelling (private observatory)* — **r 262 m, a° 238**, footprint **8×8 m**, h 6 m, 2 storeys, base y 12. Residents: **4**.

A narrow canal-side house belonging to an amateur — a retired lamp-hooder who taught himself the House's discipline and now keeps, from his own roof, a private ledger of a patch of dark no scholar bothers with. The House tolerates him; one or two of its magisters quietly check his numbers.

| Room | Size (m) | Purpose |
|---|---|---|
| Ground room | 6×6×3 | the family's living space |
| The roof-watch | 6×6×3 | a home-made ring-armature and a stool; his life's second work |

**Occupants:** Old Pell + household (4).

> Old Pell + household of 4. Proof the House's obsession is contagious; a warm side-character.

#### CV-C01 · The Corvane Canal & its bridge
*waterway* — **r 255 m, a° 220**, footprint **58×6 m**, h 0 m, base y 12. Residents: **0**.

Star-water — black, still, and here so untroubled by lamplight that the Corvane canal is the one stretch where you can lean over the parapet and see the deep field doubled in the water at your feet. One plain stone bridge crosses it. People come from other wedges to look, and leave quickly.

> The canal drains to the Nightbarge Lock below (CV-X01). Its unnatural stillness is a small local legend.

### The Shore & Processionals

#### CV-S01 · The Still Shore & Customs Post
*civic threshold* — **r 228 m, a° 204**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **0**.

The Corvane stretch of the black basalt strand is the quietest shore in Starfall, and the one people come to when they need to look a long time into the Mirror without being spoken to. The House keeps a customs post here for the goods that come up from below — and, unofficially, a bench, because someone should be near when a person stands too long at the water's edge.

| Room | Size (m) | Purpose |
|---|---|---|
| The Weighing Hall | 10×7×4 | scales, tally-desks, a wardsealed strongroom |
| Officers' room | 5×4×4 | the customs officer and a clerk; a lantern kept for the shore, not the desk |

**Occupants:** Customs officer Sael + clerk.

> Day post; the officer's household is counted at CV-K04. The unofficial watch over the water's edge is a quiet, humane note in a grim wedge.

### The Under-Terraces

#### CV-X01 · The Nightbarge Lock
*barge lock (service)* — **r 240 m, a° 220**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

The chamber-lock that lifts cargo barges from the world below into the Corvane canal. The wedge's stone, black-glass sand, ledger-paper and grave-silver all rise through here on chain-gangs. The lock-crews say the water in this lock is stiller than any other — that it does not want to be disturbed — and they work it fast and speak little.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the flooding basin and the counter-weighted gates |
| The Capstan Floor | 12×8×4 | where the lift-gangs walk the capstans |
| Tally hole | 4×4×3 | the under-clerk's niche; the real ledger, in charcoal |

**Occupants:** Lock-master Grael.

> Worked, not lived-in. Lock-master Grael keeps the honest tally the Plate does not.

#### CV-X02 · The Conduit Gallery
*Song-conduit service tunnel* — **r 260 m, a° 213**, footprint **68×5 m**, h 4 m, base y -10. Residents: **0**.

The tuned crystal conduits that carry the Song up to the wedge's few, dim star-lamps run through here, tended in the dark by crews who barely need lamps of their own. In the Corvane gallery the conduit-wrights report a thing they will not put in writing: that here, nearer the House's watching, the Song runs a shade fainter, as if something a long way off were beginning, very slightly, to listen the other way.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 4×68×4 | the conduit run; access ladders to each terrace's lamp-stems |
| Tuning niches (x4) | 3×3×3 | where conduit-wrights kneel to true the crystal |

**Occupants:** Conduit-wrights (crew of 6).

> Worked by conduit-wrights (home at the Warren). The faint-Song detail is quiet foreshadowing of the Silence — a thing measured and not believed.

#### CV-X03 · The Deep-Wrights' Warren
*Terran bunk-hall & enclave* — **r 250 m, a° 226**, footprint **28×18 m**, h 6 m, base y -16. Residents: **50**.

Home and hall of the Terran stone-wrights who cut and hold up the Corvane under-terraces — and who like this posting least of all the wedges, because the deep folk feel the House's dark in the rock and say the stone here 'keeps its own counsel.' They cut fast, shore hard, and keep their glow-stone burning a little brighter than they need to.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | a communal hall, warm with glow-stone; the deep folk crowd the light here more than in other wedges |
| Sleeping galleries | 24×6×3 | bunk-niches for the wrights and the conduit crews |
| The Shrine of Petrocore | 6×6×5 | a Stone-Voice shrine; here, unusually, it is never left unlit |

**Occupants:** Warren-elder Bruk; The Deep-Wrights (43); Conduit-wrights (crew of 6).

> Warren-elder Bruk + ~43 deep-wrights + a 6-strong conduit crew. The one place in the wedge that insists on light.

#### CV-X04 · The Silent Bunks
*labour bunk-hall* — **r 236 m, a° 232**, footprint **22×14 m**, h 4 m, base y -18. Residents: **46**.

The bunk-hall of the orc and human lift-gangs who walk the Nightbarge capstans. It is called the Silent Bunks because sound carries strangely this deep under the Corvane watching, and the crews have simply given up on noise; they sign to each other, and sleep hard, and count the days to a transfer that rarely comes.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk rows | 18×10×4 | riveted double-bunks; no window, and here no one jokes about wanting one |
| The Collar-room | 6×4×3 | where shift-tallies are logged — the same bureaucratic horror as every wedge, quieter |

**Occupants:** The Silent Bunks (46) — the elder Vosk.

> ~46 orc and human labourers. Named: the elder Vosk, who has taught the whole hall a hand-language. Part of the unnamed 778.

#### CV-X05 · The Underhush Canteen
*canteen / commons* — **r 248 m, a° 218**, footprint **16×12 m**, h 4 m, base y -12. Residents: **6**.

The warm room of the Corvane under-city, and the loudest place in the whole dark wedge on purpose — the canteen-keeper bangs her pots, keeps three lamps, and will not have silence at her tables, because she has watched what the quiet does to people down here and decided to fight it with soup and noise.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, three lamps kept deliberately bright, a wall of chalked names |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Mama Dren + 5.

> Canteen-keeper Mama Dren + 5 helpers. Knows the other wedges' canteen-keepers by their runners; the Last Lamp's cellar hatch surfaces near here.

#### CV-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 210**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office of the Corvane under-city, where the shift-count is reconciled and sent up to the House. The foreman here is the only one of the wedge's overseers who has ever sat a night in the Void Chamber, and the crews trust him more for it and fear him a little.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a lamp, a locked shift-book |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Ist.

> Foreman Ist — keeps the honest count in charcoal and the House's in ink. Twin to the foremen of every wedge.

#### CV-X07 · The Void Chamber
*anechoic dark hall (NOVEL landmark)* — **r 244 m, a° 222**, footprint **22×22 m**, h 18 m, base y -30. Residents: **12**.

The House's greatest and least-spoken-of work: a perfect hollow sphere cut deep under the tower's own sightline, lined so that no light and almost no sound survive it. Initiates sit inside, one at a time, for as long as they can bear — hours, days — until, the House says, they stop needing light to think, and begin to hear the shape of the dark the way the tower above only measures it. It is where Corvane theory stops being mathematics and becomes something closer to prayer, or preparation.

| Room | Size (m) | Purpose |
|---|---|---|
| The Antechamber | 8×6×4 | where the last lamp is surrendered and the initiate waits to be led in by touch |
| The Sphere | 16×16×16 | the anechoic void itself; no light, no echo, no floor you can feel the edge of; a single seat at the centre |
| Attendants' cells | 6×5×3 | the keeper and initiates who live at the chamber's mouth, tending those inside |

**Occupants:** The Void Chamber initiates & keeper (12).

> The wedge's novel landmark and a future hero set-piece. This is the room that taught the student Elorin Voidweaver to look into the dark without flinching — she sat the Sphere young, and it made her, and it is a straight line from this seat to the Nullstone. The under-city here is unusually quiet, as if the Sphere's silence leaks into the surrounding rock.

#### CV-X08 · The Barge-Hands' Bunks
*labour bunk-hall* — **r 258 m, a° 214**, footprint **22×14 m**, h 4 m, base y -20. Residents: **42**.

A second labour hall for the barge-hands and haulers who move cargo along the under-gallery from the lock to the terrace hoists — mostly human and orc, worked in long shifts, housed deep. They are the muscle that turns the pretty stillness of the Corvane canal into food on rim tables, and no one on the rim could name a single one of them.

| Room | Size (m) | Purpose |
|---|---|---|
| Bunk rows | 18×10×4 | riveted bunks for the haul-gangs |
| The Gear-store | 6×4×3 | harness, hooks, hand-carts; a shift-board by the door |

**Occupants:** The Barge-Hands (42) — the hauler Renk.

> ~42 human and orc haulers. Part of the unnamed 778. Named: the hauler Renk, who is teaching himself the deep-wrights' letters.

### Who lives here — roster (28 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Vaelith Corvane | Noctari | Head of House Corvane; Keeper of the Ledger of Absence | The Corvane Seat | The Tower of the Empty Ring |
| First Watcher Oel-Vane | Noctari | senior observer of the deep field, the Aperture Chamber | The Tower of the Empty Ring | The Tower of the Empty Ring |
| the void-computers (5) (×5) | Noctari | live-in clerks who record the night's absences | The Tower of the Empty Ring | The Tower of the Empty Ring |
| the Corvane near family (3) (×3) | Noctari | House family | The Corvane Seat | — |
| the Seat household staff (12) (×12) | Noctari & 2 human | cook, porters, lamp-tender, maids | The Corvane Seat | The Corvane Seat |
| Magistra Ysoreth of the Long Look | Noctari | scholar of a single unchanging patch of deep field | Villa of the Long Look | Villa of the Long Look |
| Ysoreth's household (4) (×4) | Noctari | companion and two grown students | Villa of the Long Look | — |
| Magister Oren Corvane (×4) | Noctari | keeper of the Warded Study; guardian of the restricted void-theory | The Warded Study | The Warded Study |
| Caretaker Nel | Noctari | keeps the Vacant Villa exactly as its vanished scholar left it | The Vacant Villa | The Vacant Villa |
| Master-scribe Corriden | Noctari | warden of the Hall of Negative Results | The Hall of Negative Results | The Hall of Negative Results |
| the ledger-scribes (14) (×14) | Noctari | copy and cross-check the ledgers of absence; lodge in the hall | The Hall of Negative Results | The Hall of Negative Results |
| Master mirror-wright Dela Vess + household (10) (×10) | Noctari | grinds black speculum mirrors and void-glass | The Black-Mirror Workshop | The Black-Mirror Workshop |
| Lesser Scholars' Row (20) — the copyist Wren (×20) | Noctari & 1 human household | reducers and copyists; sightless service class | Lesser Scholars' Row | — |
| Halb Oren + house (6) (×6) | Noctari | innkeeper of the Last Lamp | The Last Lamp | The Last Lamp |
| The Mourning Market (28) (×28) | Noctari, 2 human, 1 Terran | sellers of black-glass, hooded lamps, mourning-silk, grave-silver | The Mourning Market | The Mourning Market |
| Keeper Onn + two acolytes (×3) | Noctari | keeper of the Deep Shrine of Umbrion | The Deep Shrine of Umbrion | The Deep Shrine of Umbrion |
| Nightside dwellings (44) — the widow Oll (×44) | Noctari, some human | artisans, lamp-hooders, mirror-wrights' families, canal-hands | Canal Dwellings — Nightside | — |
| Old Pell + household (4) (×4) | Noctari | retired lamp-hooder; self-taught amateur watcher of the deep field | The Watcher's House | The Watcher's House |
| Customs officer Sael + clerk | Noctari | weighs the goods that come up from below; keeps an unofficial watch over the water's edge | Canal Dwellings — Nightside | The Still Shore & Customs Post |
| Lock-master Grael | Terran | runs the Nightbarge Lock | The Deep-Wrights' Warren | The Nightbarge Lock |
| Conduit-wrights (crew of 6) (×6) | Terran & human | keep the Song singing up to the wedge's dim star-lamps | The Deep-Wrights' Warren | The Conduit Gallery |
| Warren-elder Bruk | Terran | elder of the Deep-Wrights' Warren | The Deep-Wrights' Warren | The Deep-Wrights' Warren |
| The Deep-Wrights (43) (×43) | Terran | cut and hold up the Corvane under-terraces | The Deep-Wrights' Warren | — |
| The Silent Bunks (46) — the elder Vosk (×46) | Orc & human | walk the Nightbarge capstans; carry what the barges bring | The Silent Bunks | — |
| Mama Dren + 5 (×6) | Orc | canteen-keeper of the Underhush | The Underhush Canteen | The Underhush Canteen |
| Foreman Ist | Human | the seam of Corvane's under-city; reconciles the shift-count to the House | The Foreman's Post | The Foreman's Post |
| The Void Chamber initiates & keeper (12) (×12) | Noctari, 1 human | sit the Sphere and tend those inside it | The Void Chamber | The Void Chamber |
| The Barge-Hands (42) — the hauler Renk (×42) | Human & orc | move cargo along the under-gallery from lock to hoist | The Barge-Hands' Bunks | — |

| Band | Souls |
|---|---|
| Rim / House seat | 22 |
| Upper terraces | 10 |
| Middle terraces | 45 |
| Canal quarter | 85 |
| Shore | 0 |
| Under-Terraces | 157 |
| **Total** | **319** |

> ≈ 319 souls here; **157 of them in the Under-Terraces**, on no official map.

## House ———— — *the Dead House*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### DH-T01 · The Struck Tower
*sealed dead observatory (the erased House)* — **r 422 m, a° 260**, footprint **⌀22 m**, h 54 m, 6 storeys, base y 45. Residents: **0**.

The unlit tower, its dome struck through with a single black shard, its sigil scraped down to bare stone by a hand that never explained itself. The great door is sealed — not by the city, but from the inside, which no one likes to mention. Eight domes go on burning around the gap it leaves and no one has ever proposed relighting the ninth. Some absences are load-bearing.

| Room | Size (m) | Purpose |
|---|---|---|
| The sealed door | 3×1×4 | barred from within; the bar has never been found from without, and no one has tried hard |
| The scraped ring | 2×2×1 | the stone panel where the House sigil was; you can still feel the ghost of it with a fingertip |
| The dark drum | 18×18×40 | unknown; the interior is unseen in living memory. Children dare each other to knock and run |

> The mystery anchor of the wedge. WHY the House died is unresolved — sealed from inside, scraped, unnamed. Do not answer it. Its extinguished finial is the greybox's one dead rim dome.

#### DH-M01 · The Hollow Seat
*abandoned manor, now a squatted commons* — **r 438 m, a° 266**, footprint **30×20 m**, h 13 m, 3 storeys, base y 45. Residents: **28**.

The dead House's great seat, left open when the House ended and never reclaimed — so the wedge took it. Where a magister once received sightline-suits, the community now holds its loose, argued, unofficial council under the same cold coffered ceiling, and anyone may speak. It is the nearest thing the wedge has to a government, and it governs by not quite deciding.

| Room | Size (m) | Purpose |
|---|---|---|
| The Open Hall | 14×10×7 | the old reception; now a commons with a hearth built crookedly into a fireplace meant only for show |
| The Reeve's corner | 8×6×4 | where the Unwarden keeps her ledger of favours owed both ways; the only tally in the wedge kept in the open |
| Squatters' chambers | 18×8×4 | the family wing, partitioned with hung cloth into a dozen homes |
| The cold-court | 12×12×12 | the roofless observing court; someone has planted vegetables in it, which no true House would ever have allowed |

**Occupants:** Anneth Correa, the Unwarden; the Hollow Seat commons (27).

> Head of the wedge is an INFORMAL elder, not a magister. The over-city grandeur repurposed for the under-city's people — the wedge's whole thesis in one building.

### The Upper Terraces

#### DH-U01 · The Roofless Row
*under-tended villas (part-ruined, part-squatted)* — **r 360 m, a° 250**, footprint **40×10 m**, h 8 m, 2 storeys, base y 34. Residents: **14**.

Sightline villas that no one maintains, because a protected sightline is worth nothing when there is no House court to enforce it. Two have lost their roofs and stand open to the sky, which the squatters below them have decided to call a skylight. Rank once measured in windows; here the windows are free, and so is the rank.

| Room | Size (m) | Purpose |
|---|---|---|
| Per villa: what's left | 8×8×4 | 5 shells; the two roofless ones tarped over in the rains, prized in the dry season for the view |

**Occupants:** the Roofless Row squatters (14).

> The upper terrace inverted: the elite band become the cheapest rooms in the city, and the sightline — the whole point of the district — is worthless the moment no one is keeping the ledger.

#### DH-U02 · The Last Villa
*occupied villa (a holdout)* — **r 372 m, a° 270**, footprint **14×12 m**, h 9 m, 2 storeys, base y 34. Residents: **3**.

The one villa still kept as it was — swept, shuttered, its sightline clear — by the last servant of the dead House, who stayed when everyone else was told to go and was never told why. He is very old even for a Noctari, and he remembers the House's name, and he has kept the single promise he ever kept in his life, which was to never say it.

| Room | Size (m) | Purpose |
|---|---|---|
| The Kept Study | 9×7×4 | dusted daily; the sightline clear to the Mirror, aimed at nothing anyone can name |
| The Sealed Cabinet | 3×2×2 | the House papers, he says; he has not opened it in three hundred years and will not |
| Rooms | 10×6×4 | the old servant and two who look after him now that he cannot |

**Occupants:** Sennox the Last.

> The mystery's living keeper. Drops the atmosphere of a secret without the secret. He knows and will not say; the wedge lets him be.

#### DH-U03 · The Cloth Terrace
*squatted villa cluster* — **r 350 m, a° 256**, footprint **30×14 m**, h 9 m, 2 storeys, base y 34. Residents: **16**.

Three grand villas long since subdivided with hung cloth and salvaged board into perhaps twenty small homes, their old sightlines shared out room by room like slices of a great pale cake. Washing crosses between the columns. It is, quietly, one of the pleasanter places to live in Starfall, which is precisely the kind of thing that does not get onto a Plate.

| Room | Size (m) | Purpose |
|---|---|---|
| Per home: a partition & a window-share | 5×5×4 | ~20 small homes; sightlines held in common, unmeasured and unenforced |

**Occupants:** the Cloth Terrace (16) — the weaver Illa Mott.

> Freedom rendered as architecture: the sightline, once a possession, becomes a commons.

### The Middle Terraces

#### DH-L01 · The Menders' Yard
*improvised guild (fixers & scavengers)* — **r 320 m, a° 248**, footprint **20×16 m**, h 7 m, 2 storeys, base y 23. Residents: **16**.

There is no chartered guild in a wedge with no House to charter one, so the fixers chartered themselves. Anything broken in the whole city that isn't worth a real guild's price comes here — cracked lenses re-ground rough, dead clocks made to lie convincingly, salvage from the other eight wedges given a second life. Skilled, unlicensed, and cheaper than anyone admits to using.

| Room | Size (m) | Purpose |
|---|---|---|
| The Yard | 10×8×0 | open working court; a mountain of other people's discards, sorted with obsessive care |
| The Fixing Sheds | 12×6×4 | benches for glass, metal, clockwork, cloth — one mender to a trade, all self-taught |
| Menders' dwelling | 12×5×4 | the yard's families above and behind the sheds |

**Occupants:** Cord Vellamy, the Head Mender + yard (16).

> The wedge's real economy — the city depends on it and does not name it. The other Houses send work here through intermediaries who pretend they didn't.

#### DH-L02 · The Free School
*improvised school (novel)* — **r 312 m, a° 264**, footprint **16×12 m**, h 6 m, 2 storeys, base y 23. Residents: **10**.

A school with no charter, no fee, and no god — where anyone who knows a thing teaches it to anyone who wants it, an hour at a time, letters and numbers and the reading of stars to people the Academy would never enrol. It is the most subversive building in Starfall and looks like a draughty room with a slate wall, because that is what it is.

| Room | Size (m) | Purpose |
|---|---|---|
| The Slate Room | 10×8×4 | one wall painted black and written on daily; benches salvaged from the Menders' Yard |
| Teacher's rooms | 6×5×4 | the teacher and a few boarded pupils with nowhere else |

**Occupants:** Teacher Meret + pupils (10).

> The humane heart of the wedge. Teaches literacy to the unlicensed and the under-city — the exact thing the beautiful city is built on NOT doing. A natural early-Elorin beat (she 'first sees' what the institution refuses to see).

#### DH-L03 · The Unnumbered Row
*row of common dwellings* — **r 300 m, a° 272**, footprint **44×8 m**, h 7 m, 2 storeys, base y 23. Residents: **32**.

A long terrace of small houses that appear on no rent-roll, because the roll died with the House and no one ever wrote another. The people here are the fled, the discreetly poor, the between-things — those who came to the dead House's wedge precisely because it is the one place in the city where you are not counted, taxed, tallied, or watched.

| Room | Size (m) | Purpose |
|---|---|---|
| Per house: 2-3 rooms | 6×7×4 | ~9 households; nobody asks the next door's name unless offered |

**Occupants:** the Unnumbered Row (32).

> The district of the un-measured. To live here is to be off the Plate on purpose.

### The Canal Quarter

#### DH-K01 · The Blind Lamp
*taphouse (Strain-relief haven, rough)* — **r 268 m, a° 252**, footprint **16×12 m**, h 7 m, 2 storeys, base y 12. Residents: **5**.

The wedge's taphouse, named for the dead star-lamp over its door that has never once been lit in living memory — the Song does not come cleanly to a wedge whose House stopped paying to route it. So the Blind Lamp burns cheap tallow instead, which is illegal, which is the point. Rougher than the Sounding-Glass or the Ninth Bell, and warmer than either.

| Room | Size (m) | Purpose |
|---|---|---|
| The Tallow Room | 12×8×4 | real flame, real smoke, real shadows; the one room in Starfall lit like the world below |
| Kitchen & cellar | 6×5×4 | the cellar stair goes straight down to the Open Stair — here there is no grille, no seam, no pretending |
| Letting rooms (x4) | 12×5×3 | four rooms above, let by the night to whoever, no name asked |

**Occupants:** Bram Nolt + house (5).

> This wedge's Strain-relief haven. The unlit lamp is a quiet, precise symbol: the light the rest of the city takes for granted was never free — it was a service the dead House stopped buying.

#### DH-K02 · The Unmarket
*unlicensed market* — **r 256 m, a° 260**, footprint **30×12 m**, h 5 m, 1 storeys, base y 12. Residents: **30**.

A market that keeps no hours because there is no bell to keep them by and no House to charge a stall-fee. It runs on barter as much as coin, sells the salvage of the Menders' Yard and the produce of the cold-courts, and asks no questions about the provenance of anything. Serenthil sells time to the death; the Unmarket gives it away.

| Room | Size (m) | Purpose |
|---|---|---|
| The Sprawl | 26×8×4 | barrows, cloth-shaded pitches, a barter-post where debts are chalked and rubbed out by trust |

**Occupants:** the Unmarket traders (30) — the barter-clerk Sable-of-no-House.

> The economic mirror of the Hour-Market across the city: no hours, no fees, no measure. The un-timed market of the un-timed House.

#### DH-K03 · The Empty Niche
*shrine (to the unnamed)* — **r 250 m, a° 244**, footprint **10×10 m**, h 8 m, 1 storeys, base y 12. Residents: **2**.

A shrine built around an absence: a stone niche with no idol in it, no name over it, and one worn place on the floor where people kneel anyway. Some come for the dead House. Some come for their own erased and unspoken things. The keeper does not ask which, because the keeper's own name was struck from a ledger long ago too, and never restored.

| Room | Size (m) | Purpose |
|---|---|---|
| The Niche | 6×6×6 | an empty carved recess; offerings left are small, wordless, and never idols |
| Keeper's cell | 3×3×3 | the nameless keeper's room |

**Occupants:** the Nameless Keeper + a companion.

> Novel: a shrine TO erasure itself, in a city of gods of light and shadow. The theological answer to the whole wedge — you can worship an absence, and people do.

#### DH-K04 · Canal Dwellings — the Mingle
*dense mixed-race tenements* — **r 244 m, a° 268**, footprint **26×15 m**, h 12 m, 4 storeys, base y 12. Residents: **52**.

The densest housing in the wedge, and the only place above ground in all Starfall where Noctari, human, Terran and orc keep house side by side as a matter of course rather than a scandal — because the House that would have forbidden it is dead, and no one has troubled to invent the rule again. The over-city calls it the Mingle, and does not visit.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-4 rooms | 6×6×3 | ~12 dwellings stacked four deep, families of every race and several of no single one |

**Occupants:** the Mingle (52).

> The wedge's central humane fact: the segregation the rest of the city enforces simply lapsed here. The Under-Terraces' mixed halls, but above ground and by choice.

#### DH-K05 · The Common Wash
*wash-house & commons* — **r 262 m, a° 276**, footprint **14×10 m**, h 5 m, 1 storeys, base y 12. Residents: **8**.

A wash-house on the canal, steam-warm, where the wedge does its laundry and, incidentally, most of its living — births are announced here, disputes settled, the sick minded. It was a House bath-house once. The community keeps the boiler going by collective agreement and no small effort, and treats it as the nearest thing they have to a temple that works.

| Room | Size (m) | Purpose |
|---|---|---|
| The Steam Hall | 10×7×4 | stone tubs, a scavenged boiler, benches worn smooth by gossip |
| The Minding Room | 5×4×3 | a warm back room where the sick and the newborn are kept; the wash-women take turns |

**Occupants:** the wash-women of the Common Wash (8) — Gerta Voss.

> Humane detail: the mutual-aid of a place with no institutions doing the institutions' job, warmer than any of them.

### The Shore & Processionals

#### DH-S01 · The Untended Gate
*derelict customs post (self-manned)* — **r 228 m, a° 262**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **2**.

Where the dead House's processional foot meets the shore stands a customs post with no customs officer — the House that appointed one is gone, and the Conclave never bothered to replace the post over a wedge worth nothing to tax. So the community keeps a volunteer at the door, not to weigh goods but to warn the wedge who is coming down the stair. The one gate in Starfall that watches the over-city, and not the under.

| Room | Size (m) | Purpose |
|---|---|---|
| The Empty Weighing Hall | 10×7×4 | scales long since sold; the strongroom stands open and is used to store the wash-house coal |
| The Watcher's stool | 4×3×4 | one chair by the door, kept warm in shifts by whoever the wedge can spare |

**Occupants:** the Gate-Watchers (2) — old Pell.

> The customs post inverted: it exists to watch the rich descend, not to tax the poor ascending. Structurally twins Vael'Suran's and Serenthil's official gates, and refutes them.

### The Under-Terraces

#### DH-X01 · The Open Stair
*over/under connection (novel inversion)* — **r 250 m, a° 262**, footprint **6×18 m**, h 20 m, base y -10. Residents: **0**.

Everywhere else in Starfall the two cities meet at a locked seam — a grille, a customs door, a foreman's post. Here the stair between the terraces and the under-terraces simply stands open, and always has, because the House that kept the door shut is dead and no one rehung it. People go up and down it carrying laundry and gossip and bread. It is the single most quietly radical object in the city: a door that isn't there.

| Room | Size (m) | Purpose |
|---|---|---|
| The Stair | 4×18×20 | broad worn steps, no gate, lit at the turns by tallow because the conduits here are failing |

> The wedge's thesis made into architecture: the two-map divide physically broken. The 'Other Map' and the Plate share a staircase here, and neither minds.

#### DH-X02 · The Slack Lock
*barge lock (under-used)* — **r 240 m, a° 256**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

The wedge's barge lock still works, because the city below still needs a way up whether the House above it lives or dies — but it runs slack and half-idle, worked by volunteers off the Mingle when a barge comes, not by a chained gang on a bell. It lifts less than any lock in the city and is, by every account of the people who work it, the only pleasant one to crew.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the basin and gates; worked when needed, quiet when not |
| The Capstan Floor | 12×6×4 | no chain-gang; the capstans walked by whoever the wedge sends, for a share of the cargo |

**Occupants:** the Undercroft dwellers (40) — the lock-caller Mudge.

> Worked, not lived-in; crewed from the Undercroft Bunks (DH-X04). The labour that is compulsion elsewhere is cooperative here.

#### DH-X03 · The Failing Gallery
*conduit gallery (decaying)* — **r 260 m, a° 268**, footprint **60×5 m**, h 4 m, base y -10. Residents: **6**.

The Song-conduits that should light the wedge's star-lamps, kept barely alive by a crew too small for the work since the House stopped funding it. The crystal goes untuned, the light fails terrace by terrace, and that is exactly why the wedge burns tallow above — the failing gallery is the reason the Blind Lamp is blind. They keep the last few conduits singing out of stubbornness and to sell a little light to the Menders.

| Room | Size (m) | Purpose |
|---|---|---|
| The Dimming Run | 5×60×4 | conduits going dark one by one; the crew tunes what they can reach and mourns the rest |
| Crew niche | 4×4×3 | where the conduit-crew sleep beside their failing charge |

**Occupants:** the Failing-Gallery crew (6) — the tuner Orin Deep.

> Concrete cause of the wedge's darkness: light in Starfall was always a service that had to be paid for, and this House stopped paying. Decay you can see the reason for.

#### DH-X04 · The Undercroft Bunks
*under-dwelling (chosen, not segregated)* — **r 250 m, a° 250**, footprint **28×18 m**, h 6 m, base y -16. Residents: **40**.

A bunk-hall like the other wedges' — except that here no one is confined to it. With the Open Stair unbarred and the Mingle open above, the under-dwellers who work the lock and the gallery live below by choice, habit, or the plain warmth of glow-stone, and go up whenever they please. It is the same architecture of segregation as the other wedges, emptied of its cruelty and left standing as merely a home.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 16×8×6 | a communal hall; the same long table as every under-hall, but the door out is never locked |
| Sleeping galleries | 24×6×3 | bunk-niches, many of them empty now that people may live above if they like |

**Occupants:** the Undercroft dwellers (40) — the lock-caller Mudge.

> The same structure the other wedges use to keep labour out of sight — here rendered harmless by the simple fact that the door is open. Houses the lock and gallery crews.

#### DH-X05 · The Open Table
*canteen / commons* — **r 248 m, a° 260**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The under-canteen of the wedge, set where the Open Stair lands — so that, uniquely in Starfall, the people from above and the people from below eat at one table without a wall or a rule between them. The same grey good stew as every under-canteen; the difference is who is allowed to sit.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles under the stairhead; a wall of chalked names shared between over and under, which no other wedge's wall is |
| Kitchen | 5×4×3 | run by the keeper on donated stores |

**Occupants:** the Open Table keeper Bess + 3.

> Sister-room to the Underspill (VS-X05) and the Undertoll (SR-X05) — but here the over-city sits down too. The one integrated table in the city.

#### DH-X06 · The Empty Post
*abandoned overseer post (novel inversion)* — **r 242 m, a° 266**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

Every other wedge has a foreman at the seam, keeping one honest ledger and one dishonest one and knowing they differ. This wedge's post stands empty — the House that would appoint the overseer is dead — and the astonishing, quietly damning fact the over-city cannot afford to notice is that the work still gets done. One volunteer keeps a single open tally on the desk that no one above demands and no one below resents.

| Room | Size (m) | Purpose |
|---|---|---|
| The Ledger Desk | 5×4×3 | one book, kept in the open, in one hand, honest because no one is made to lie to it |

**Occupants:** the volunteer tally-keeper, young Wrenn.

> The wedge's sharpest political point: remove the overseer and the labour organizes itself and works anyway. Twins the Foreman's Posts (VS-X06, SR-X06) and refutes their necessity.

#### DH-X07 · The Drowned Terrace
*flooded under-level (novel)* — **r 246 m, a° 272**, footprint **34×24 m**, h 8 m, base y -20. Residents: **8**.

A service terrace that drowned when the dead House's pumps fell silent and no one paid to restart them — a still black flood standing waist-deep among the pillars, roofed by the living wedge above. The community did not drain it. They learned to use it: they fish the star-water for the pale blind things that breed in it, the children swim in the warm dark, and the flood doubles the tallow-light into a low uncanny second city that is not on even the Other Map.

| Room | Size (m) | Purpose |
|---|---|---|
| The Flood | 30×20×4 | waist-deep still water among pillars; punted, fished, swum; the drowned doorways lead nowhere anyone returns from |
| The Fishers' ledge | 8×5×3 | a dry shelf where the fisher-folk of the flood keep their nets and their homes |

**Occupants:** the fisher-folk of the Drowned Terrace (8) — the punt-woman Calla.

> Novel & eerie & tied to the House's death (the pumps stopped when the House did). A place beneath the 'Other Map' itself — a third city no map contains. Strong future set-piece; leaves an unanswered edge (the drowned doorways).

### Who lives here — roster (19 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Anneth Correa, the Unwarden | Noctari | informal elder of the dead House's wedge; keeps the one open ledger of favours | The Hollow Seat | The Hollow Seat |
| the Hollow Seat commons (27) (×27) | Noctari, human, Terran, orc | squatter-families housed in the abandoned manor; the wedge's loose council | The Hollow Seat | — |
| the Roofless Row squatters (14) (×14) | Noctari & human | occupants of the ruined sightline villas | The Roofless Row | — |
| Sennox the Last | Noctari | the dead House's final servant; keeper of its name and its silence | The Last Villa | The Last Villa |
| the Cloth Terrace (16) — the weaver Illa Mott (×16) | Noctari, human | families in the subdivided villas; sightlines held in common | The Cloth Terrace | — |
| Cord Vellamy, the Head Mender + yard (16) (×16) | Terran | self-appointed head of the Menders' Yard; fixes what the guilds won't | The Menders' Yard | The Menders' Yard |
| Teacher Meret + pupils (10) (×10) | Human | runs the Free School; teaches letters, numbers and the stars to anyone | The Free School | The Free School |
| the Unnumbered Row (32) (×32) | Noctari, human, Terran, orc | the fled, the discreetly poor, the between-things; on no rent-roll | The Unnumbered Row | — |
| Bram Nolt + house (5) (×5) | Human | keeps the Blind Lamp taphouse | The Blind Lamp | The Blind Lamp |
| the Unmarket traders (30) — the barter-clerk Sable-of-no-House (×30) | Noctari, human, Terran, orc | barrow-traders and barterers; keep no hours and pay no stall-fee | The Unmarket | The Unmarket |
| the Nameless Keeper + a companion (×2) | Noctari | tends the Empty Niche; a shrine to the unnamed and the erased | The Empty Niche | The Empty Niche |
| the Mingle (52) (×52) | Noctari, human, Terran, orc, and several of no single race | the mixed-race warren of the canal quarter | Canal Dwellings — the Mingle | — |
| the wash-women of the Common Wash (8) — Gerta Voss (×8) | mixed (Noctari, human, orc) | keep the wash-house and, incidentally, mind the wedge's sick and newborn | The Common Wash | The Common Wash |
| the Gate-Watchers (2) — old Pell (×2) | Noctari & human | volunteer watch at the untended customs post | The Untended Gate | The Untended Gate |
| the Failing-Gallery crew (6) — the tuner Orin Deep (×6) | Terran & human | keep the last few Song-conduits singing as the rest go dark | The Failing Gallery | The Failing Gallery |
| the Undercroft dwellers (40) — the lock-caller Mudge (×40) | Terran, human, orc | crew the Slack Lock and live below by choice, not confinement | The Undercroft Bunks | The Slack Lock |
| the Open Table keeper Bess + 3 (×4) | Orc | keeps the under-canteen at the foot of the Open Stair | The Open Table | The Open Table |
| the volunteer tally-keeper, young Wrenn | Human | keeps the one open ledger at the abandoned foreman's post, unpaid and undemanded | The Empty Post | The Empty Post |
| the fisher-folk of the Drowned Terrace (8) — the punt-woman Calla (×8) | Terran & human | fish and live on the flooded under-level the pumps stopped draining | The Drowned Terrace | — |

| Band | Souls |
|---|---|
| Rim / House seat | 28 |
| Upper terraces | 33 |
| Middle terraces | 58 |
| Canal quarter | 97 |
| Shore | 2 |
| Under-Terraces | 59 |
| **Total** | **277** |

> ≈ 277 souls here; **59 of them in the Under-Terraces**, on no official map.

## House Duskmere — *Watchers of the Horizon*
*structure by structure*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Rim & the Nine Towers

#### DK-T01 · The Horizon Tower
*observatory tower (House seat, upper)* — **r 422 m, a° 300**, footprint **⌀22 m**, h 57 m, 6 storeys, base y 45. Residents: **7**.

Alone among the nine, this tower half-turns its back on the Mirror to watch the rim of the world instead — every rising and every setting, the exact degree at which a star first clears the cloud-sea and the exact degree at which it drowns. Its lamp is not only a finial but a beacon, the highest light in Starfall and the first thing a traveller climbing the outer stair sees for two days.

| Room | Size (m) | Purpose |
|---|---|---|
| The Rising Hall | 20×20×8 | ground instrument floor; a low horizon-quadrant ringed to the walls, aimed outward not down |
| The Ephemeris of Departures | 10×8×4 | the register of first-and-last lights; travellers pay to have an auspicious hour named for setting out |
| Head's Study | 8×7×4 | Magister Corvenn's study; the only one in the House that faces outward, over the stair |
| The Beacon Room | 10×8×4 | where the great landward lamp is trimmed and shuttered; a code of shutterings tells the stair-foot what weather waits above |
| The Setting Chamber | 12×12×10 | top floor; the outward aperture; the reading of last-light is taken standing in the wind off the cloud-sea |
| Watch-stair & lamp-loft | 4×4×30 | the spiral stair; the beacon is tended in shifts through the night |

**Occupants:** First Watcher Ysolt Vane; the watchers & beacon-keepers (6).

> First Watcher + 6 live-in watchers/beacon-keepers. The beacon doubles as the greybox rim finial; it also faces outward, the one lamp that looks away from the city.

#### DK-M01 · The Duskmere Seat
*great house (manor)* — **r 438 m, a° 294**, footprint **32×22 m**, h 14 m, 3 storeys, base y 45. Residents: **16**.

The only House seat arranged around a view of the way out rather than the Mirror — a house built for leaving, hung with the maps of roads no other House keeps and the trophies of journeys down. Half its rooms are always shut, their people away; the family measures its status not in windows but in how far its members have gone and come back.

| Room | Size (m) | Purpose |
|---|---|---|
| The Hall of Roads | 14×10×7 | reception; a floor inlaid with the outer roads, worn palest where the family walks its own routes in thought |
| Corvenn's chambers | 10×8×4 | the head's rooms, facing the beacon and the stair-head |
| The Shut Wing | 16×8×4 | chambers of the family who are travelling; kept aired and ready, sometimes for decades |
| The Returns Court | 12×10×6 | a court with a single lit lamp burning for whoever is on the road — put out only when all are home, which is almost never |
| Kitchen & stores | 10×7×4 | below the hall; provisioned for departures as much as meals |
| Staff quarters | 12×6×4 | attic rooms for the household |

**Occupants:** Magister Corvenn Duskmere; the resident Duskmere family (5); the Seat household staff (10).

> Corvenn + resident family (5) + 10 staff. The Returns lamp is the House's soul: a light kept for the absent.

#### DK-G01 · The Stair-Head Gatehouse
*great gatehouse (novel landmark)* — **r 446 m, a° 309**, footprint **26×18 m**, h 18 m, 3 storeys, base y 45. Residents: **12**.

The one land gate of Starfall: a fortified house straddling the top of the long outer switchback stair, the only walked road down to the world far below the cloud-sea. Everything and everyone that does not come up a barge-lock comes through here — counted, tolled, and named in the gate-book. Its double portcullis is warded shut at the ninth bell, and after that the city is, quite literally, unreachable by foot.

| Room | Size (m) | Purpose |
|---|---|---|
| The Passage | 6×18×8 | the warded gate-tunnel; two portcullises with a killing-dark between, a relic of a fear no living Noctari remembers the cause of |
| The Gate-Book Hall | 12×8×5 | where every arrival is named and every departure marked; the most complete list of who is in the city that exists — and it lists no one from below |
| The Toll Room | 8×6×4 | gate-customs on foot-traffic and pack-loads; the strongroom under it |
| Guard barracks | 14×8×4 | the resident gate-guard company; the only standing armed body in a city that pretends it needs none |
| The Beacon-mirror loft | 6×5×5 | answers the Horizon Tower's shutter-code down the stair to the way-stations |

**Occupants:** Gate-serjeant Ollun-Rekk + guard company (12).

> Gate-serjeant Ollun-Rekk + a resident guard company of 11. The gate-book is a quiet theme-piece: the city's official census of souls, which by design cannot see the Under-Terraces or the world below.

### The Upper Terraces

#### DK-U01 · Sightline Villa — the Warden's House
*senior officer's villa* — **r 368 m, a° 288**, footprint **14×12 m**, h 10 m, 2 storeys, base y 34. Residents: **6**.

Home of the Warden of the Stair, the commoner-born officer who actually holds the gate and the descent — a heavier authority than any House head, because the Warden decides who comes into the city at all. Keeps a sightline to the Mirror out of rank and never once looks at it; the window that matters faces the stair.

| Room | Size (m) | Purpose |
|---|---|---|
| The Duty Study | 9×7×4 | the gate-rosters, the toll-ledgers, a spyglass trained down the switchbacks |
| Family rooms | 13×6×4 | the Warden, a spouse, two children, a ward taken off the stair years ago |

**Occupants:** Warden Hesk Ollun + household (6).

> Warden Hesk Ollun + household of 5. Real power in the wedge; the House defers to the Warden and resents it.

#### DK-U02 · Sightline Villa — the Caravan-Master's House
*senior dwelling (bought-in)* — **r 372 m, a° 297**, footprint **13×11 m**, h 9 m, 2 storeys, base y 34. Residents: **5**.

A rim villa bought — scandalously, with trade money — by a retired human caravan-master who spent sixty years hauling up the stair and now owns a view the old blood thinks he has no right to. He keeps the door open and the wine good, and the House cannot afford to snub him, because he still owns half the mule-lines.

| Room | Size (m) | Purpose |
|---|---|---|
| The Map Room | 9×7×4 | walls of trade-roads; the sightline used, unusually, to actually look at the lake |
| Living rooms | 12×6×4 | Tovek, his wife, a grandchild, a manservant |

**Occupants:** Caravan-master Tovek Sarn + household (5).

> Caravan-master Tovek Sarn (human) + household. New money on the rim — an affront and a fact. Side-quest seed: buying respectability.

#### DK-U03 · Sightline Villa — the Empty House
*senior dwelling (mostly absent)* — **r 364 m, a° 312**, footprint **13×11 m**, h 8 m, 2 storeys, base y 34. Residents: **4**.

A Duskmere villa whose whole family is a decade into a survey of the drowned coasts and is not expected back this generation. A caretaker keeps the lamp, dusts the instruments, and answers the door to no one — the most enviable sightline in the wedge, held by an empty house and a woman who is not allowed to sit at its window.

| Room | Size (m) | Purpose |
|---|---|---|
| The Shrouded Study | 9×7×4 | instruments under cloth; the sightline unused for eleven years |
| Caretaker's rooms | 10×6×4 | the caretaker and her three lodgers, who are not supposed to be there |

**Occupants:** Caretaker Nell + lodgers (4).

> Caretaker Nell + 3 quiet lodgers she takes rent from and does not report. A wedge of departures leaves houses like this everywhere.

### The Middle Terraces

#### DK-L01 · The Wayfarers' Hall
*guild-hall + lodging* — **r 315 m, a° 292**, footprint **22×14 m**, h 11 m, 3 storeys, base y 23. Residents: **13**.

The guild of guides, road-cartographers and stair-pilots — the people who know the switchbacks in fog, the safe camps, the season the lower road floods. They draw the maps no Plate would deign to include (the outward roads, the world below) and lodge the guild's own in the floors above. The one hall in Starfall where the city is treated as a place you leave.

| Room | Size (m) | Purpose |
|---|---|---|
| The Road-Room | 20×8×5 | long tables of outward maps; a relief-model of the whole switchback stair in carved slate |
| The Pilots' Register | 8×6×4 | who is licensed to guide the descent; a stair-pilot's word is worth a House seal down below |
| Guild dormitory | 18×6×4 | lodging for pilots between runs; cots that smell of the outside |

**Occupants:** Guild-warden Ilsa Wend + pilots (13).

> Guild-warden Ilsa Wend + 12 lodged pilots/cartographers. The Road-Room's outward maps are the over-city cousin of the Under-Terraces' 'Other Map' — knowledge the Plate refuses.

#### DK-L02 · The Gatewrights' Court
*workshop + dwelling* — **r 322 m, a° 303**, footprint **18×16 m**, h 8 m, 2 storeys, base y 23. Residents: **9**.

Where the gate-mechanisms, the portcullis counterweights, the mule-harness and the stair's iron are made and mended — the heavy, greasy trade that keeps the one door working. A family firm that has held the gate-contract for four generations and guards its winch-designs like a House guards a sightline.

| Room | Size (m) | Purpose |
|---|---|---|
| The Iron Shed | 12×8×5 | forge, winch-benches, the great counterweight-jigs |
| The Harness Room | 8×6×4 | mule-tack and stair-litters for the loads too heavy to carry |
| Family dwelling | 14×6×4 | the Rekk family above the forge |
| The Court | 8×8×0 | open assembly yard for gate-iron |

**Occupants:** Master gatewright Dorn Rekk + household (9).

> Master gatewright Dorn Rekk + household + journeymen. Kin to the gate-serjeant; the Rekks are the gate, above and below.

#### DK-L03 · Doorkeepers' Row
*terrace of 6 small dwellings* — **r 300 m, a° 311**, footprint **42×8 m**, h 7 m, 2 storeys, base y 23. Residents: **22**.

Six joined houses of the wedge's doorkeepers — gate-clerks, toll-tallymen, stair-lamplighters and the runners who carry the gate-book's news up to the House. Respectable, sightless service to the threshold; they know everyone's comings and goings and are paid to forget them.

| Room | Size (m) | Purpose |
|---|---|---|
| Per-house: work-room + 2 chambers | 6×7×4 | 6 households |

**Occupants:** Doorkeepers' Row (22) — tallyman Vess.

> 6 households, ~22 souls. Named: toll-tallyman Vess, who has memorised every face that came up the stair in forty years and never once written a name he was paid to lose.

### The Canal Quarter

#### DK-K01 · The Last Lamp
*inn (Strain-relief haven)* — **r 270 m, a° 296**, footprint **16×12 m**, h 8 m, 2 storeys, base y 12. Residents: **5**.

The wedge's inn, and by old custom the last warm light a traveller passes going down and the first coming up — its sign a lamp that is never let go out. Half its trade is farewells and half is homecomings, and the innkeeper has learned to tell, from the door, which a stranger needs. This quarter's Strain-relief haven.

| Room | Size (m) | Purpose |
|---|---|---|
| The Common Room | 12×8×4 | hearth, long tables, the never-dark lamp over the door; a wall of tokens left by travellers who meant to come back |
| Kitchen | 6×5×4 |  |
| Letting rooms (x5) | 14×5×3 | five rooms above, more often taken for one hard-slept night than a stay |
| Cellar | 8×6×3 | a stair-cool store; a low door that lets onto the Undergate, which the innkeeper swears is bricked up |

**Occupants:** Innkeeper Wenna Sarr + house (5).

> Innkeeper Wenna Sarr + 2 family + 2 staff. The cellar door is this wedge's over/under seam — to the Undergate (DK-X07).

#### DK-K02 · The Caravanserai of the First Night
*way-inn / caravanserai (novel landmark)* — **r 262 m, a° 305**, footprint **40×34 m**, h 11 m, 3 storeys, base y 12. Residents: **44**.

A vast galleried courtyard where the outside world sleeps its first night in Starfall: muleteers, pilgrims, traders, envoys, and the merely lost, stacked in tiers of let-rooms around a central yard loud with beasts and languages. The most cosmopolitan single building in a city that prides itself on knowing exactly who everyone is — and the one place that, for a night, does not. A churning, half-transient population no census ever fixes.

| Room | Size (m) | Purpose |
|---|---|---|
| The Great Court | 24×24×0 | open yard; a well, a fire-pit, mule-lines, and every dusk a different crowd |
| The Tier Galleries | 36×5×3 | three storeys of let-rooms opening onto the court; the cheapest are highest and coldest |
| The Long Stable | 20×6×4 | beasts of the road; the smell of the outside, which the rim finds unspeakable |
| The Keeper's House | 10×6×4 | Old Mireth and her people, who never sleep the same night twice |

**Occupants:** Caravanserai-keeper Old Mireth + house (44).

> Caravanserai-keeper Old Mireth + ~14 permanent staff + ~30 long-stay transients counted this season (the number is never the same twice). The city's true melting-pot; a natural quest and information hub.

#### DK-K03 · The Arrival Market
*market row (outfitters & changers)* — **r 256 m, a° 314**, footprint **28×10 m**, h 6 m, 2 storeys, base y 12. Residents: **24**.

The market of the freshly-arrived and the about-to-leave: money-changers who take any coin, outfitters, a letter-writer for those who cannot, a physician for stair-broken legs, a dealer in second-hand everything left behind by people who did not make it back for it. Prices tuned to exactly what a tired stranger will pay.

| Room | Size (m) | Purpose |
|---|---|---|
| Per unit: shopfront + room above | 3×8×4 | 9 units, most with a family above |

**Occupants:** The Arrival Market (24) — the changer Oshka, the letter-writer Pell.

> 9 shops, ~24 souls. Named: the changer Oshka (who fences what the Undergate brings up) and the letter-writer old Pell (who knows every secret in the wedge and sells none).

#### DK-K04 · Canal Dwellings — Gateside
*tenement block, 8 dwellings* — **r 244 m, a° 289**, footprint **24×14 m**, h 11 m, 3 storeys, base y 12. Residents: **40**.

Dense canalside housing for the wedge's settled working folk — the porters, gate-clerks, stable-hands, changers' families and off-shift customs-men who work the threshold and, unlike the trade that passes through, actually stay. The block that anchors a wedge otherwise made of people leaving.

| Room | Size (m) | Purpose |
|---|---|---|
| Per dwelling: 2-3 rooms | 6×6×3 | 8 dwellings, families of 3-6 |

**Occupants:** Gateside dwellings (37) — portress Grella; Customs officer Brae + 2 clerks.

> ~40 souls incl. the customs officer's household (counted here, day-posted to the gate-foot). Named: portress Grella, who has carried loads up the stair since she was nine and will not speak of what she has seen come down it.

#### DK-K05 · The Threshold Shrine
*shrine (Umbrion, of the between)* — **r 250 m, a° 300**, footprint **10×10 m**, h 8 m, 1 storeys, base y 12. Residents: **1**.

A shrine to Umbrion in his aspect of the threshold — the god of dusk being the god of the moment between, of doorways, of the step you have half-taken. Travellers touch its cold sill going down and coming up; the keeper marks a tally-stone for every soul who prays to leave and does not return, and the wall of them is long.

| Room | Size (m) | Purpose |
|---|---|---|
| The Between-Cell | 6×6×6 | a doorless doorway of black stone; you pray standing in it, neither in nor out |
| Keeper's cell | 4×4×3 | the shrine-keeper's room, walled in tally-stones of the un-returned |

**Occupants:** Keeper Onwe.

> Keeper Onwe, who came up the stair once, meaning to go back, and never has. A quiet counterpart to House Vael'Suran's Deepening.

### The Shore & Processionals

#### DK-S01 · The Gate-Foot Customs & Processional Foot
*civic threshold* — **r 228 m, a° 303**, footprint **14×10 m**, h 6 m, 1 storeys, base y 0. Residents: **0**.

Where this wedge's processional meets the shore: the second customs post of Duskmere, twinned with the gatehouse far above — the gatehouse tolls what comes overland from the world, this post tolls what the barge-lock lifts from directly below. Between the two, in theory, nothing enters Starfall uncounted. In practice, there is the Undergate.

| Room | Size (m) | Purpose |
|---|---|---|
| The Weighing Hall | 10×7×4 | scales, tally-desks, a warded strongroom |
| Officers' room | 5×4×4 | the customs officer and clerks |

**Occupants:** Customs officer Brae + 2 clerks.

> Customs officer Brae + 2 clerks (day post; housed at DK-K04). 'In theory nothing enters uncounted' is the wedge's central irony.

### The Under-Terraces

#### DK-X01 · The Duskmere Lock
*barge lock (service)* — **r 240 m, a° 300**, footprint **24×12 m**, h 14 m, base y -14. Residents: **0**.

The chamber-lock that raises cargo barges from the world directly below the caldera up into the wedge's canal — the fast route, for goods too heavy or too discreet for the long stair. The gate above counts mules; the lock below lifts the tonnage; and the difference between what each records is where a great deal of the wedge's real wealth lives.

| Room | Size (m) | Purpose |
|---|---|---|
| The Lock Chamber | 20×8×14 | the flooding basin and counter-weighted gates |
| The Capstan Floor | 12×8×4 | walked by the lift-gangs |
| Tally hole | 4×4×3 | the under-clerk's niche and his charcoal ledger |

**Occupants:** Lock-master Braff.

> Worked, not lived-in. Lock-master Braff. The gap between the gate-book above and the lock-tally below is the wedge's open secret.

#### DK-X02 · The Conduit Gallery
*Song-conduit service tunnel* — **r 260 m, a° 296**, footprint **68×5 m**, h 4 m, base y -10. Residents: **0**.

The tuned crystal conduits that carry the Song up to this wedge's star-lamps — including the great landward beacon, which drinks more Song than any lamp in the city and so keeps a whole crew climbing in the dark to feed a light that faces away from them. When the beacon burns for a traveller, it burns on their backs.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Gallery | 4×68×4 | the conduit run; a heavy branch climbs to the beacon-stem |
| Tuning niches (x4) | 3×3×3 | where conduit-wrights true the crystal |

**Occupants:** Conduit crew (6).

> Worked by a conduit crew of 6 (housed at DK-X04). The beacon's hunger is a small cruelty the wedge does not think about.

#### DK-X03 · The Stair-Gangs' Hall
*mixed bunk-hall (porters & lift-gangs)* — **r 250 m, a° 308**, footprint **30×20 m**, h 5 m, base y -18. Residents: **50**.

The bunk-hall of the muscle of the threshold: the stair-porters who carry loads no mule can up the switchbacks, and the barge lift-gangs who walk the lock capstans. Human and orc, road-hard and lock-hard, they are the two halves of how weight gets into Starfall — and neither half is on the gate-book, because the gate-book counts arrivals, and they never leave.

| Room | Size (m) | Purpose |
|---|---|---|
| The Porters' Gallery | 20×8×4 | bunks for the stair-gangs; a rack of carry-frames worn to the shape of specific backs |
| The Lift-Gang Gallery | 18×6×4 | bunks for the capstan-walkers; a wall of notches, one per season survived |
| The Wash | 8×5×3 | the one place the road-dust and the lock-damp come off |

**Occupants:** The Stair-Gangs (50) — stair-elder Karsk.

> ~28 human/orc stair-porters + ~22 lift-gang. Named: the stair-elder Karsk, who has climbed the equivalent of off the world and back many times over. Part of the unnamed 778.

#### DK-X04 · The Stairwrights' Hall
*Terran bunk-hall & enclave* — **r 248 m, a° 293**, footprint **28×18 m**, h 6 m, base y -20. Residents: **49**.

Home and hall of the Terran stairwrights — the deep-folk who cut, shore and endlessly repair the outer switchback stair and the gate's roots, the most dangerous stone-work in Starfall because it hangs over the cloud-sea on the outside of the world. Carved, glow-warm, and grimly proud: every course of the stair a traveller trusts was set by a hand in this hall, and lost fingers are counted here as a kind of rank.

| Room | Size (m) | Purpose |
|---|---|---|
| The Carved Hall | 18×10×6 | communal hall; a long stone table and the roll of the stair-dead, cut into the wall |
| Sleeping galleries | 22×6×3 | bunk-niches for the wrights, the lock-master and the conduit crew who bunk with them |
| The Shrine of Petrocore | 6×6×5 | a Stone-Voice shrine facing outward, toward the exposed cut — the wrong god, the right prayer |

**Occupants:** The Stairwrights (42) — under-mother Tesk; Lock-master Braff; Conduit crew (6).

> ~42 Terran stairwrights + lock-master Braff + the 6-strong conduit crew who bunk here. Kin-connected to House Vael'Suran's deep-wrights; the two Terran halls trade apprentices and grief.

#### DK-X05 · The Waygate Canteen
*canteen / commons* — **r 252 m, a° 301**, footprint **16×12 m**, h 4 m, base y -12. Residents: **4**.

The under-city's warm room for the wedge, and the strangest table in Starfall: stair-porters, lift-gangs, stairwrights, conduit-crews and, now and then, an outsider come up the Undergate who has nowhere else to be, all eating the same grey good stew. The canteen-keeper feeds anyone who comes down the right passage and asks no gate-book question at all.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Room | 12×8×4 | trestles, a great range, a wall chalked with the dead of the stair and the lock |
| Kitchen & store | 6×5×3 | run by the keeper |

**Occupants:** Canteen-keeper Bem + 3.

> Canteen-keeper Bem + 3 helpers. Sister-room to the Underspill and the Undertoll; the three under-canteens run a quiet grapevine the length of the city.

#### DK-X06 · The Foreman's Post
*overseer post* — **r 242 m, a° 305**, footprint **8×6 m**, h 3 m, base y -12. Residents: **1**.

The seam-office where the under-city of the threshold answers to the over-city — where the lock-tally, the porter-shifts and the awkward matter of the Undergate are all reconciled into whatever number the House is willing to hear. The foreman keeps three ledgers: one for the House, one that is true, and one he burns.

| Room | Size (m) | Purpose |
|---|---|---|
| The Office | 5×4×3 | a ledger-desk, a lamp, a strongbox with a false bottom |
| Bunk | 3×3×3 | the foreman sleeps at the seam |

**Occupants:** Foreman Idris.

> Foreman Idris — the one who decides what the Undergate is allowed to be. Trusted by neither map; feared by both. Prime quest-broker.

#### DK-X07 · The Undergate
*unofficial lower gate (novel landmark)* — **r 238 m, a° 312**, footprint **14×12 m**, h 5 m, base y -22. Residents: **8**.

The city's other door: a place low on the outer stair where a broken flight lets into the under-galleries, and those who cannot pay the gatehouse toll — or cannot afford to be written in the gate-book — come up into Starfall through the dark instead. Not a secret, exactly; a thing the foreman manages, the changers fence for, and the Plate could not draw if it tried, because officially it is a rockfall. The truest threshold in a wedge of thresholds.

| Room | Size (m) | Purpose |
|---|---|---|
| The Breach | 8×6×5 | the broken gate; a plank bridge over the drop, and a rust lamp that means 'open tonight' |
| The Waiting Dark | 8×5×4 | where the un-booked wait to be let up; some for a night, some for years; a squat-camp of the truly uncounted |

**Occupants:** Gate-shadow Kobb + squatters (8).

> Gate-shadow Kobb + ~7 long-term squatters of the Waiting Dark. The single sharpest image of the two-maps theme in the wedge: a door the city insists is a wall.

### Who lives here — roster (25 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Magister Corvenn Duskmere | Noctari | Head of House Duskmere; Warden of the Horizon | The Duskmere Seat | The Horizon Tower |
| First Watcher Ysolt Vane | Noctari | senior observer of first-and-last light | The Horizon Tower | The Horizon Tower |
| the watchers & beacon-keepers (6) (×6) | Noctari | live-in observers and beacon-tenders | The Horizon Tower | The Horizon Tower |
| the resident Duskmere family (5) (×5) | Noctari | House family currently at home | The Duskmere Seat | — |
| the Seat household staff (10) (×10) | Noctari & 2 human | cook, map-keeper, lamp-tender, porters, maids | The Duskmere Seat | The Duskmere Seat |
| Warden Hesk Ollun + household (6) (×6) | Noctari | Warden of the Stair; commoner-born officer who holds the gate and the descent | Sightline Villa — the Warden's House | The Stair-Head Gatehouse |
| Gate-serjeant Ollun-Rekk + guard company (12) (×12) | Noctari & mixed | commands the resident gate-guard; keeps the gate-book | The Stair-Head Gatehouse | The Stair-Head Gatehouse |
| Caravan-master Tovek Sarn + household (5) (×5) | Human | retired trade-master; new money on the rim | Sightline Villa — the Caravan-Master's House | — |
| Caretaker Nell + lodgers (4) (×4) | Noctari | keeps the Empty House for a family a decade away | Sightline Villa — the Empty House | — |
| Guild-warden Ilsa Wend + pilots (13) (×13) | Noctari | warden of the Wayfarers' Hall; road-cartographer | The Wayfarers' Hall | The Wayfarers' Hall |
| Master gatewright Dorn Rekk + household (9) (×9) | Noctari | holds the gate-contract; makes and mends the gate-iron | The Gatewrights' Court | The Gatewrights' Court |
| Doorkeepers' Row (22) — tallyman Vess (×22) | Noctari, 1 human household | gate-clerks, toll-tallymen, stair-lamplighters, gate-runners | Doorkeepers' Row | — |
| Innkeeper Wenna Sarr + house (5) (×5) | Noctari | keeps The Last Lamp | The Last Lamp | The Last Lamp |
| Caravanserai-keeper Old Mireth + house (44) (×44) | Human | keeps the Caravanserai of the First Night | The Caravanserai of the First Night | The Caravanserai of the First Night |
| The Arrival Market (24) — the changer Oshka, the letter-writer Pell (×24) | mixed (Noctari, human, 1 Terran) | money-changers, outfitters, a physician, a letter-writer, second-hand dealers | The Arrival Market | The Arrival Market |
| Gateside dwellings (37) — portress Grella (×37) | Noctari, some human, some orc | porters, stable-hands, gate-clerks' and changers' families | Canal Dwellings — Gateside | — |
| Keeper Onwe | Noctari | keeper of the Threshold Shrine | The Threshold Shrine | The Threshold Shrine |
| Customs officer Brae + 2 clerks (×3) | Noctari | runs the gate-foot customs; tolls what the lock lifts from below | Canal Dwellings — Gateside | The Gate-Foot Customs & Processional Foot |
| Lock-master Braff | Terran | runs the Duskmere Lock | The Stairwrights' Hall | The Duskmere Lock |
| Conduit crew (6) (×6) | Terran | keep the Song singing up to the star-lamps and the beacon | The Stairwrights' Hall | The Conduit Gallery |
| The Stair-Gangs (50) — stair-elder Karsk (×50) | human & orc | stair-porters and barge lift-gangs; the muscle of the threshold | The Stair-Gangs' Hall | — |
| The Stairwrights (42) — under-mother Tesk (×42) | Terran | cut, shore and repair the outer stair and the gate's roots | The Stairwrights' Hall | — |
| Canteen-keeper Bem + 3 (×4) | Orc | keeps the Waygate Canteen | The Waygate Canteen | The Waygate Canteen |
| Foreman Idris | Human | the seam of Duskmere's under-city; manages the Undergate | The Foreman's Post | The Foreman's Post |
| Gate-shadow Kobb + squatters (8) (×8) | Human | keeps the Undergate; lets the un-booked up into the city through the dark | The Undergate | — |

| Band | Souls |
|---|---|
| Rim / House seat | 35 |
| Upper terraces | 15 |
| Middle terraces | 44 |
| Canal quarter | 114 |
| Shore | 0 |
| Under-Terraces | 112 |
| **Total** | **320** |

> ≈ 320 souls here; **112 of them in the Under-Terraces**, on no official map.

## House Serenthil — *Keepers of the Meridian*
*structure by structure*

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

### Who lives here — roster (24 records)

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

| Band | Souls |
|---|---|
| Rim / House seat | 24 |
| Upper terraces | 16 |
| Middle terraces | 45 |
| Canal quarter | 80 |
| Shore | 0 |
| Under-Terraces | 77 |
| **Total** | **242** |

> ≈ 242 souls here; **77 of them in the Under-Terraces**, on no official map.

## The Academy of Astral Harmony (island)
*the central institution — where Elorin works and the Nullstone is designed*

Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.

### The Academy of Astral Harmony (island)

#### AC-OBS · The Great Observatory
*hero observatory (the Academy's heart)* — **r 4 m, a° 0**, footprint **⌀44 m**, h 110 m, 9 storeys, base y 2. Residents: **14**.

The single silhouette that rules the whole caldera: a verdigris-domed drum rising 110 m from the island, its lit spire visible from every terrace and every wedge. Under the dome the Academy reads a sky no single House owns — the shared instrument the nine Houses grudgingly answer to. It is the reason Starfall exists where it does, over the hole in the world that shows the stars.

| Room | Size (m) | Purpose |
|---|---|---|
| The Great Hall | 40×40×24 | the floor beneath the dome; the aperture opens the ceiling to the true sky; the balcony ring girdles the drum outside (the Cold Open balcony is one such ledge, at scale) |
| The Meridian Circle | 14×10×8 | the Academy's master transit instrument — the line the Houses' clocks and charts are all quietly corrected against |
| The Orrery Room | 16×16×10 | a great brass model of the wandering lights, kept running; Oravelle envies it |
| The Archmagister's Study | 10×8×5 | the head of the Academy's rooms, highest habitable floor, the finest sightline in Starfall |
| Observers' cells | 20×8×4 | spare rooms for the astronomers who keep the night watches |

**Occupants:** Archmagister Sennel Vaross; First Astronomer Deire + observers (12).

> Archmagister + First Astronomer + 12 live-in observers/watch-keepers. The lit apex is the greybox spire finial.

#### AC-THEORY · The Theory Wings & Moon-Bridge
*library-halls (two wings + bridge)* — **r 40 m, a° 90**, footprint **44×14 m**, h 44 m, 3 storeys, base y 2. Residents: **6**.

Two galleried library-halls of receding star-crystal stacks, joined at second-storey height by the arched moon-bridge that gives the island its silhouette. Where the Academy THINKS: lectures, glyph-boards, the reading of everything the nine Houses have ever measured. The Nullstone team first assembles here — the arguments that end in a void artifact begin as chalk on these boards.

| Room | Size (m) | Purpose |
|---|---|---|
| The West Gallery | 28×12×8 | two storeys of stacks; a mezzanine walk at 3.6 m; ~6 lecterns/glyph-boards on the floor |
| The East Gallery | 28×12×8 | the reading hall; long tables under high comb-crystal windows |
| Study alcoves (x3) | 6×6×4 | where Coil argues thresholds and Vara out-thinks the room she is not credited in |
| The Moon-Bridge | 44×6×4 | the arched span between the wing-tops; the Academy's favourite place to be seen thinking |

**Occupants:** Senior Lector Vessine; Resident theorists (5).

> Senior lector Vessine + 5 resident theorists. Coil (CH-009), Vara (CH-010), Sera (CH-008) and Durak (CH-011) WORK here daily but lodge elsewhere (city). SQ-P1-03 seed.

#### AC-CONTAIN · The Containment Halls
*arcano-industrial hall (the warded structure)* — **r 40 m, a° 180**, footprint **24×18 m**, h 16 m, 2 storeys, base y 2. Residents: **4**.

The heaviest, coldest building on the island: an industrial-arcane hall around a recessed containment rig-pit, glyph-warded floor to ceiling. THE SINGLE MOST IMPORTANT ROOM IN PART ONE is the drafting dais at its end — the SAFEGUARD DESIGN happens at that table, and the buried flaw is authored there, at this drafting table, by Elorin's own hand. What is meant here as 'containment' drifts, across the act, into 'control.'

| Room | Size (m) | Purpose |
|---|---|---|
| The Rig-Pit Hall | 20×12×9 | central containment rig-pit (8 m ⌀, recessed 1.5 m) where prototype tests run; cold arcane-blue glow |
| The Schematic Dais | 6×6×4 | raised drafting dais; the 3×1.5 m table where the safeguard — and its buried flaw — is drawn (PR-010) |
| The Ward-Store | 8×6×4 | warded materials, glyph-stock, the prototype's cradle |
| Corel's office | 6×5×4 | the exhausted archmagister's room — decency worn thin by duty |

**Occupants:** Corel.

> Corel (CH-013) keeps an office and often sleeps here (4 counted incl. 3 night-wards). Act II core; SQ-P1-06 (The Buried Flaw). The prototype (PR-001) sits above the rig-pit in Act II.

#### AC-QUARTERS · The Scholars' Residence
*resident-fellows' lodging* — **r 58 m, a° 300**, footprint **26×12 m**, h 11 m, 3 storeys, base y 2. Residents: **12**.

The quiet ring of cells and studies where the Academy's resident fellows live — including Elorin Voidweaver, through the years she builds the thing that ends the world. Her rooms are spare, Noctari-dark, over-open in the Umbraveil way (a door she will not shut), and stacked with the void-theory House Corvane first taught her. The most consequential bedroom in the history of the Song, and nobody on the island knows it yet.

| Room | Size (m) | Purpose |
|---|---|---|
| Elorin's rooms | 8×7×4 | study + cell; the void kept as 'presence, not absence'; a low window on the Mirror |
| Fellows' cells (x8) | 20×6×4 | resident theorists and senior scholars |
| The Common Study | 12×8×5 | shared fire, shared silence |

**Occupants:** Elorin Voidweaver; Resident fellows (11).

> Elorin (CH-001/002) + 11 resident fellows. Her home for the Academy years (Narrative Outline Ch2-5). Coil may lodge here too when not at the Wings.

#### AC-REFECTORY · The Refectory & Commons
*dining hall & commons* — **r 60 m, a° 40**, footprint **22×14 m**, h 8 m, 1 storeys, base y 2. Residents: **9**.

The one warm, loud room on a cold island — where archmagisters, students, and the Solari and human and Terran scholars the Houses keep at arm's length all eat at the same long tables. The Academy's small daily proof that the city's careful separations are a choice, not a law.

| Room | Size (m) | Purpose |
|---|---|---|
| The Long Hall | 18×10×6 | trestle tables, a great hearth, a board of the night's observing assignments |
| Kitchens & stores | 10×6×4 | run by the refectory staff |

**Occupants:** Refectory-master Ondle + staff (9).

> Refectory-master Ondle + 8 kitchen/commons staff (boarded).

#### AC-DORMS · The Students' Dormitory
*student housing* — **r 62 m, a° 150**, footprint **30×14 m**, h 11 m, 3 storeys, base y 2. Residents: **88**.

Where the Academy's students board — the sharpest young minds the nine Houses (and, rarely, the city below, and, once in a generation, somewhere outside it entirely) can send. Crowded, cold, ferociously competitive, and the only place a House heir and a canal-quarter prodigy share a wall. The NA-02 crowd of the exterior scenes lives here.

| Room | Size (m) | Purpose |
|---|---|---|
| Sleeping ranges (x3 floors) | 26×8×3 | shared student cells, 2-4 to a room |
| The Study Hall | 20×8×5 | a night-lit common study; the competition never sleeps |
| Proctors' rooms | 8×5×4 | the resident proctors who keep order |

**Occupants:** The students (84); Proctors (4).

> ~84 students + 4 proctors. The island's largest population; the Academy's future, most of whom will never own a sightline.

#### AC-GATE · The Gate Plaza & Fountain
*threshold plaza (causeway head)* — **r 40 m, a° 0**, footprint **20×12 m**, h 4 m, 1 storeys, base y 2. Residents: **3**.

Where the one causeway lands: a 12×12 m marble gate-plaza with the star-water Gate Fountain students trail a hand in for luck on the way to their examinations. The island's only door to the rest of the city, and — like the customs posts on the shore — it faces the water, not the dark below.

| Room | Size (m) | Purpose |
|---|---|---|
| The Gatehouse | 8×6×4 | the porter's lodge and the notice board (PR-016); the island's register of who is on it |
| The Plaza & Fountain | 12×12×0 | open marble; the Gate Fountain that gives nothing back but a doubled sky |

**Occupants:** Gate-porter Sull + night-porters (2).

> Gate-porter Sull + 2 (night-porters). The moon-bridge, notice board, fountain and students are the §10 island interactables.

#### AC-WARDS · The Warders' Post
*security post (containment guard)* — **r 52 m, a° 200**, footprint **10×8 m**, h 5 m, 1 storeys, base y 2. Residents: **6**.

A small hard post beside the Containment Halls: the ward-keepers who guard the prototype and the drafting dais, the nearest thing the scholarly island has to soldiers. In Part One they are almost bored. Three hundred years later, guarding the finished Stone in a different vault, their successors (the Void Wardens, CH-017) will not be.

| Room | Size (m) | Purpose |
|---|---|---|
| The Guard-Room | 6×5×4 | the ward-keepers' watch; a rack of ward-staves |
| Bunk | 4×4×3 | the on-island wards sleep at their post |

**Occupants:** The Ward-Keepers (6) — ward-master Gollen.

> 6 ward-keepers. A quiet foreshadow of the Void Wardens who guard the Nullstone Vault in both parts.

### Who lives here — roster (13 records)

| NPC | Race | Role | Home | Works |
|---|---|---|---|---|
| Archmagister Sennel Vaross | Noctari | head of the Academy of Astral Harmony | The Great Observatory | The Great Observatory |
| First Astronomer Deire + observers (12) (×13) | Noctari | keep the night watches under the great dome | The Great Observatory | The Great Observatory |
| Senior Lector Vessine | Noctari | runs the Theory Wings; the Academy's memory | The Theory Wings & Moon-Bridge | The Theory Wings & Moon-Bridge |
| Resident theorists (5) (×5) | Noctari & 1 human | fellows of the Wings | The Theory Wings & Moon-Bridge | The Theory Wings & Moon-Bridge |
| Corel — *CH-013, PO-011* | Noctari | containment archmagister; Elorin's exhausted superior | The Containment Halls | The Containment Halls |
| Night-wards of Containment (3) (×3) | Noctari | keep the rig-pit through the night watches | The Containment Halls | — |
| Elorin Voidweaver — *CH-001/002, PO-001* | Noctari | the Architect; resident fellow; designer of the Nullstone | The Scholars' Residence | The Containment Halls |
| Resident fellows (11) (×11) | Noctari, 2 human, 1 Solari | senior scholars boarded on the island | The Scholars' Residence | — |
| Refectory-master Ondle + staff (9) (×9) | Noctari & mixed | feeds the whole island at one set of tables | The Refectory & Commons | The Refectory & Commons |
| The students (84) (×84) | Noctari, human, Solari, 2 Terran | the Academy's students — the Houses' sharpest, a few from below and beyond | The Students' Dormitory | — |
| Proctors (4) (×4) | Noctari | keep order in the dorms | The Students' Dormitory | The Students' Dormitory |
| Gate-porter Sull + night-porters (2) (×3) | Noctari | keeps the causeway gate and the island register | The Gate Plaza & Fountain | The Gate Plaza & Fountain |
| The Ward-Keepers (6) — ward-master Gollen (×6) | Noctari & 1 orc | guard the prototype and the drafting dais | The Warders' Post | The Containment Halls |

| Band | Souls |
|---|---|
| The island | 142 |
| **Total** | **142** |

---

**City complete: 9 of 9 House wedges + the Academy island fully specified — 203 structures, 238 NPC records, ≈ 2,820 souls placed, every one with a home.** (Target 3,000.)

> **Design note.** Wedges must not read as clones. Vael'Suran = the eye, pride, protected sightlines, a closed bloodline. Serenthil = the ear, the hour, civic utility, rented rooms, a mixed under-city. Each further House should get its own social texture from its celestial domain.
