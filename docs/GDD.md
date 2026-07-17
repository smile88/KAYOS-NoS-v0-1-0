# KAYOS: THE NIGHT OF SILENCE
# Game Design Document (GDD) — v1.0

**Studio:** SC Milenwall
**Franchise:** KAYOS: Pieces of Fate
**Document status:** Build-ready master specification
**Engine target:** Godot 4.7 (GDScript) · 2D top-down · 960×540 native · 32px grid · 48×72 sprite frames · nearest-neighbour scaling (see §13 — the locked spec)
**Date:** July 2026

---

## 0. HOW TO READ THIS DOCUMENT

This GDD is written so that a developer or AI implementer can build the game start to finish
without further design decisions. Where a value is given (a stat number, a threshold, a flag
name), treat it as canonical unless a change is explicitly negotiated. Section 15 (Content
Manifest) is the master checklist; every named asset, quest, and flag elsewhere in the document
appears there.

**Cross-references** use the form (see §X.Y). **Flags** — the persistent variables that drive
consequence — are written in `MONOSPACE_CAPS` and collated in §11. **Assets** use the ID scheme
from the Asset Bible (CH-###, EN-###, etc.).

---

## 1. HIGH CONCEPT

A narrative-first, dialogue-driven 2D RPG in the tradition of *Planescape: Torment* and classic
*Fallout*. The player lives both halves of the founding catastrophe of the KAYOS universe — the
Night of Silence — across one continuous playthrough:

- **Part One:** play **Elorin Voidweaver**, the brilliant scholar who designs the Nullstone, the
  artifact that will one day suppress all magic in the world.
- **Part Two:** play **Grakkar**, the orc revolutionary who, three centuries later, activates it.

The signature mechanic — **the Legacy System** — writes every meaningful choice Elorin makes into
the world as persistent data, which Grakkar then *discovers* three hundred years later as
documents, institutions, descendants, and the very defenses he must overcome. The player sows as
the creator and reaps as the destroyer. There is no combat; all conflict resolves through
dialogue, skill checks, items, and consequence.

**Logline:** *You will build the thing that ends the world. Then you will be the one who ends it.
And you will have no one to blame.*

**Core question (per protagonist):**
- Elorin: *Can a creator be innocent of what her creation becomes?*
- Grakkar: *Does two centuries of oppression license one night of catastrophe?*

The game never answers either. It makes the player answer, and then shows them the cost.

---

## 2. DESIGN PILLARS

1. **Consequence over combat.** Every system exists to make choices matter. If a feature does not
   feed the consequence web, it is cut.
2. **Discovery over exposition.** The world's history reaches the player through exploration,
   documents, and dialogue — never through narration dumps. In Part Two specifically, the player
   discovers the results of their own Part One choices.
3. **Moral ambiguity, always.** No faction is clean. No ending is free. Every named antagonist is
   sincere. The horror is never a monster; it is a good person's reasoning followed to its end.
4. **Density over breadth.** One dense city per part beats ten shallow ones. Torment's whole world
   was a few districts. Depth is the budget.
5. **Canon fidelity.** The game is the playable form of the canonical *Night of Silence* master
   outline. It cannot contradict established KAYOS canon; it can only deepen it.

---

## 3. STRUCTURE OVERVIEW

One full playthrough = the entire novel, playable, in fixed order:

| Segment | Protagonist | Era | Length (target) | Function |
|---|---|---|---|---|
| **Cold Open — "The Same Night"** | Talindir (on rails) | 2000 AO | 10–15 min | Tutorial; the catastrophe glimpsed, not understood |
| **Part One — "The Architect"** | **Elorin** (1 of 3 classes) | ~1450–1460 AO | 4–6 hrs | The creation. The player *sows*. |
| **Interlude — "The Fading"** | Elorin → Talindir | 1460 AO | 5 min | Elorin's exile; Talindir inherits the archive |
| **Part Two — "The Unbound"** | **Grakkar** (1 of 3 classes) | 1780–2000 AO | 4–6 hrs | The activation. The player *reaps*. |
| **Coda — "The Chronicle"** | Talindir (interactive) | 2000 AO–12 AC | 15–20 min | The legacy is tallied; the ending is assembled |

**Fixed order is canonical and non-negotiable for v1.0.** Consequence flows forward only
(Part One → Part Two → Coda). A "Grakkar-first" New Game+ is a post-v1.0 stretch goal only.

**The Three Crossing Points** (canonical hinge scenes) are each experienced from both sides across
the two parts:
- **The Glance** — Elorin and a young Grakkar lock eyes for one second (Part One Act II / Part Two Act II, same event, two viewpoints).
- **The Reader** — Grakkar reads Elorin's actual surviving words (authored by the player in Part One).
- **The Same Night** — the activation itself (Cold Open teases it; Part One Act III and Part Two Act III each play their half).

---

## 4. FULL NARRATIVE

### 4.0 World primer (for the implementer)

The KAYOS world at the time of Part One is a high-magic age (the **Age of Order**). Magic
("essence") is alive, ambient, and bonded to living things through **Aether Rings** — a glowing
iris-ring present in newborn "Ring-Bearers." The dominant powers are the elven peoples: the
**Noctari** (night elves, scholars of the dark and the void, dwelling under starlit or twilight
skies) and the **Solari** (sun elves, masters of radiant high magic, rulers of the golden capital
Astra'Thalas). Beneath them, other peoples labor — humans as tolerated lessers, **Terrans**
(earth-folk, geomancers) as guarded specialists, and **orcs** as an enslaved underclass in the
mines, camps, and arcano-industrial facilities that power elven civilization.

Wild magic is becoming unstable. Catastrophic surges — the worst remembered is **Northreach's
Tear (1453 AO)** — kill indiscriminately. The elven **Conclave** commissions a research program to
contain the danger. That program produces the **Nullstone**: an artifact designed to suppress and
stabilize wild essence. It works. It works so well that, centuries later, when activated at full
power on the winter solstice of **2000 AO**, it does not merely stabilize magic — it *silences* it,
everywhere, all at once. That is the **Night of Silence**, and it begins the **Age of Chaos**
(~500 years) from which the franchise's present day (347 AR and beyond) slowly recovers.

The player builds the Nullstone in Part One and activates it in Part Two.

### 4.1 COLD OPEN — "The Same Night" (2000 AO, winter solstice)

Playable, on rails, ~10–15 min. **Protagonist: Talindir**, an elven apprentice-scribe, now aged,
on a high balcony of Astra'Thalas during the great solstice festival. Purpose: tutorial (movement,
interaction, dialogue, one choice) and tonal thesis.

Beats:
1. Movement tutorial: walk the festival balcony, gold light everywhere, celebrations below.
2. Interaction tutorial: examine three things (a festival banner, a telescope, a sealed letter in
   Talindir's own satchel — the letter is from Elorin, 300 years old; the player cannot read it
   yet, establishing the mystery).
3. Dialogue tutorial: a short exchange with a festival-goer who asks why Talindir looks afraid.
   **The one choice:** tell the truth ("Tonight something ends") or deflect ("Just old bones").
   Sets `COLDOPEN_HONEST` — a tiny flag that echoes in the Coda.
4. The event: across the city, district by district, the lights go out — not blown out, *silenced*,
   color draining from the world in an expanding ring. The festival becomes panic. Talindir does
   not run; he opens his ledger and begins to write. Hard cut to black on the title card.

The player does not understand what they just saw. That is the point. They will, twice.

### 4.2 PART ONE — "The Architect" (Elorin Voidweaver, ~1450–1460 AO)

**Setting:** the city of **Starfall** and its **Academy of Astral Harmony**; Act III relocates to
the Solari capital **Astra'Thalas** and the **Tower of Celestial Harmony**. Umbraveil (Elorin's
homeland, the valley of the two-hour sun) appears in memory scenes.

#### ACT I — "The Problem" (recruitment & assembly)

Elorin, a Noctari scholar of low birth from Umbraveil — brilliant, an outsider to the Academy's
aristocratic circles — is summoned to Starfall. Northreach's Tear is a fresh wound; the Conclave
wants containment research and it wants her specifically, because her void-essence theory (negation
of essence) is the only promising avenue.

- **Opening:** arrival at Starfall (EN-001/004), first taste of Academy politics, the outsider's
  cold welcome. Meets **Corel**, the exhausted archmagister who will be her superior; **Coil**, her
  eager former student now on the project; and briefly, in a corridor, **Sera**, the Solari
  structural enchantress seconded from Astra'Thalas.
- **The moral seed:** Elorin is shown the Northreach survivors and the political pressure. The
  Conclave makes clear that results matter more than caution. First choice with teeth: when Corel
  asks her to overstate the project's early promise to secure funding, she can lie, tell the truth,
  or find a third framing. Sets `P1_FUNDING_LIE` / `P1_FUNDING_TRUTH` / `P1_FUNDING_HEDGE`.
- **Team assembly (the core Act I quest):** Elorin recruits (or fails to recruit) her research
  team. Each is a mini-quest with a moral texture and a Legacy consequence:
  - **Vara**, a human prodigy the Academy refuses to credit — recruiting her means fighting the
    institution (`P1_VARA_RECRUITED`, and *how* she's recruited sets `P1_VARA_CREDITED`).
  - **Durak Ironthought**, a Terran geomancer who distrusts elven projects — won by honesty about
    the risks, lost by pressure (`P1_DURAK_TRUST`).
  - **Coil** is already aboard, but his loyalty deepens or sours based on how Elorin treats his
    theoretical contributions (`P1_COIL_LOYALTY`, 0–3 scale).
- **Act climax:** the team's first containment test. It half-fails; someone is hurt. Elorin must
  assign cause in her report — protect a team member, protect the truth, or protect the project.
  Sets `P1_FIRSTTEST_BLAME`.

#### ACT II — "The Work" (years of construction; time-skips between chapters)

The Nullstone takes shape across years. This is the heaviest **sowing** act — the Legacy System's
core decisions live here.

- **The bending of purpose:** the Conclave's interest visibly shifts from *containment* (stop the
  surges) to *control* (a tool that can suppress essence at will — including, by implication, in
  people). Elorin can resist, comply, or quietly sabotage this drift. This is the act's spine.
- **THE SAFEGUARD DESIGN (the single most important sequence in the game):** Elorin must design the
  Nullstone's failsafes — the systems meant to ensure it can never be activated at full,
  world-silencing power. The Conclave squeezes the budget and timeline. The player makes real,
  discrete design decisions, each of which becomes a physical obstacle Grakkar faces 300 years later
  (see §5, the Legacy System):
  - **Which of three ward-pylon schemes** is implemented (Lattice / Orbit / Seal) — `P1_WARD_SCHEME`.
  - **Whether the redundant failsafe is fully built or cut** to meet the deadline — `P1_FAILSAFE_CUT`.
  - **Where the intentional flaw is buried** — because Elorin, alone, understands that a tool this
    powerful must have a secret weakness only she knows. Does she document it, hide it, or refuse to
    build one? `P1_FLAW_DOCUMENTED` / `P1_FLAW_HIDDEN` / `P1_FLAW_NONE`.
- **THE GLANCE (Crossing Point 1):** during a facility inspection, Elorin's eyes meet those of a
  young orc laborer for one second across a crowded hall. Nothing is said. The player may examine
  the moment (a single optional interaction) — or walk past. Sets `P1_GLANCE_SEEN`. That laborer is
  the young Grakkar. In Part Two, the player will stand in his place and see Elorin.
- **The team under strain:** Vara's health or standing, Durak's growing dread, Coil's possible
  radicalization or breakdown, Sera's divided loyalty to Astra'Thalas. Each has a mid-act crisis
  quest whose resolution sets Legacy flags for descendants/institutions in Part Two.
- **Act climax:** the Nullstone prototype (PR-001) is completed and succeeds beyond hope. In the
  celebration, Elorin overhears (or is told, depending on `P1_COIL_LOYALTY`) that the Conclave
  intends to keep the Stone as a permanent instrument of rule. She now knows what she has made.

#### ACT III — "The Regrettable Necessity" (Astra'Thalas & the vault)

- **Relocation to Astra'Thalas:** the completed Nullstone (PR-002) is to be sealed in a vault
  beneath the Tower of Celestial Harmony (EN-007/008), guarded by the newly-formed **Void Wardens**
  (CH-017). Elorin oversees the sealing and the safeguards' final testimony.
- **The safeguards testimony:** before the Conclave, Elorin must formally attest that the Nullstone
  can never be activated at full power. She can attest truthfully (if the failsafes are whole), lie
  to cover the cut failsafe, or use the testimony to publicly expose the Conclave's intent — a
  desperate, costly act. Sets `P1_TESTIMONY`.
- **What she leaves behind (Elorin's final authored legacy):** Elorin's personal ending is
  canonically fixed — the Stone exists, the Conclave has won the argument, and she chooses exile,
  fading from history into Umbraveil and then beyond. But the player decides *what she leaves in the
  world*:
  - **The hidden archive:** does she compile the true, complete record of the project — its dangers,
    the buried flaw, the Conclave's intent — and hide it? Where? She entrusts it (or doesn't) to her
    apprentice **Talindir**. `P1_ARCHIVE_LEFT` and `P1_ARCHIVE_LOCATION` (Lunaris / Academy / destroyed / never made).
  - **The warning:** does she file a formal warning that will outlive her, swallow it, or encode it?
    `P1_WARNING`.
  - **The last words to Talindir:** a final dialogue determining what Talindir knows and believes,
    which shapes the entire Coda. `P1_TALINDIR_TRUTH` (0–3 scale of how much truth she trusts him with).
- **THE SAME NIGHT (Elorin's half, Crossing Point 3):** an epilogue vision — from a distant
  coastline, the aged Elorin (CH-002) feels the moment, 540 years in her future, when the thing she
  made goes silent. She does not see it. She only knows. (This is a short scripted scene; the flag
  it reads is set at the very end of Part Two, delivered as a Part One "memory" the player earns
  retroactively — engine note: this scene is authored once and its content selected by Part Two's
  outcome when the Coda plays.)

### 4.3 INTERLUDE — "The Fading" (1460 AO)

~5 min, low-interactivity. Elorin departs. **Talindir** — young, earnest (CH-006) — receives
whatever she left him (`P1_ARCHIVE_*`, `P1_TALINDIR_TRUTH`). He makes a private vow over her
records. The screen ages: dates flick forward, three centuries in a montage of the ledger's spine
gathering dust and being moved from hiding place to hiding place. This bridges the player from
creator to destroyer and physically hands the Legacy archive from Part One into the world Part Two
will excavate.

### 4.4 PART TWO — "The Unbound" (Grakkar, 1780–2000 AO)

**Setting:** the **Ashpile** (orc birth-camp, Act I); an elven **research facility and the Archives
of Astral Wisdom** (Act II); **Astra'Thalas and the Tower vault** (Act III — the same finale zone
the player secured as Elorin). Black Crag and the Last Orc Rebellion are lived as the Act I→II
break. Era-skips between acts render Grakkar's two-century patience playable.

#### ACT I — "The Ashpile / The Reader" (1780s AO)

- **Birth-camp life:** the player, young Grakkar (CH-003), lives the reality of orc slavery in a
  slag-plain labor camp (EN-010). Establish the world's cruelty not through spectacle but through
  routine — the roll-calls, the collar (IT: iron collar fragment), the small daily calculus of
  survival. Meets **Morga Steelheart** (CH-019), the camp's elder conscience, and other laborers.
- **The theft of literacy (core Act I quest):** Grakkar learns to read elven script — canonically,
  by watching his masters. This is a stealth-of-the-mind questline: gathering fragments, risking
  punishment, choosing who to trust with the dangerous secret that he can read. Sets
  `P2_LITERACY` and, critically, gates the entire Scholar-class experience later.
- **THE READER (Crossing Point 2) — first contact with the Legacy:** Grakkar finds a fragment — a
  page, a reference, a scrap — of **Elorin's actual writings** (the surviving remnant of
  `P1_ARCHIVE_*`). The literal text he reads is drawn from what the player wrote/preserved/hid as
  Elorin. If `P1_ARCHIVE_LEFT` is false, he finds only a rumor of it — a tantalizing absence that
  drives Act II. This is the hook of the whole second campaign: *there is a stone that eats magic,
  and an elf who regretted making it.*
- **The Rebellion & Black Crag (Act climax):** the Last Orc Rebellion rises. Grakkar is swept into
  it. It breaks at **Black Crag** (EN-011/VS-007) — canon: the rebellion fails. The player chooses
  Grakkar's role in the failure: front-line defiance, saving fighters at a cost, or the coldest
  choice — preserving himself and the knowledge for the long game, letting the doomed battle serve
  as his cover to escape. Sets `P2_BLACKCRAG_ROLE`. Morga survives or is lost based on player action
  (`P2_MORGA_ALIVE`), which reshapes Act II.

#### ACT II — "The Long Game" (era-skips across ~200 years)

The heart of Part Two. Grakkar (now CH-004, and eventually the elder CH-005) infiltrates the elven
**research facility and Archives of Astral Wisdom** (EN-012/013), building the network and the
knowledge that will let him reach the Nullstone.

- **The infiltration frame:** Grakkar is a laborer inside the facility with secret access to the
  Archives. The gameplay is patience: cultivating contacts, reading forbidden records, assembling
  the map to the Stone. **What he can learn is bounded by Elorin's Legacy** — the documents that
  exist for him to find are exactly those the player preserved in Part One (§5).
- **Companions & network:** **Kess** (CH-020), a young courier (recruited, and possibly lost, based
  on player care); **Morga** if she survived; sympathetic or corruptible facility staff. Each is a
  moral relationship, not a stat stick.
- **Morga's arithmetic (the act's philosophical spine):** if Morga lives, she becomes the
  revolution's conscience, arguing directly against Grakkar's hardening plan. The Nullstone will not
  free the orcs — it will silence *all* magic, collapse the entire order, and kill uncountable
  innocents alongside the guilty. Is that price payable? The player, as Grakkar, argues back — or
  concedes. A running dialogue across the act sets `P2_ARITHMETIC` (0–4), measuring how much mercy
  survives Grakkar's resolve. This directly shapes Act III and the Coda.
- **Discovering the flaw:** the master goal — find how the Nullstone can be activated at full power,
  which requires finding **Elorin's buried flaw**. If `P1_FLAW_DOCUMENTED`, the record exists to be
  found (hard, but possible). If `P1_FLAW_HIDDEN`, Grakkar must *deduce* it from fragments — a
  longer, richer investigation. If `P1_FLAW_NONE`, there is no intended flaw and Grakkar must force
  a catastrophic overload instead — a different, bloodier Act III. This is the Legacy System's
  deepest fork.
- **Act climax:** Grakkar assembles the means and the moment — the solstice of 2000 AO, when the
  Tower's wards are lowered for the festival. He knows how to reach the Stone. Vessk-equivalent
  institutional pursuit closes in (the facility's security apparatus; a specific antagonist officer,
  **Overseer Ilvane**, CH-023, hunts him). The player chooses how to handle Ilvane — the resolution
  is never clean.

#### ACT III — "The Same Night" (2000 AO, winter solstice)

- **The infiltration of the vault:** Grakkar (CH-005) enters the Tower and descends to the Nullstone
  vault (EN-008). **The vault's defenses are generated from the player's Part One choices** — the
  ward-pylon scheme (`P1_WARD_SCHEME`), whether the failsafe was built (`P1_FAILSAFE_CUT`), the
  Void Wardens' disposition. The player defeats their own past design. Every obstacle here is a
  sentence the player wrote as Elorin. (See §5.1 for the full generation table.)
- **THE SAME NIGHT (Grakkar's half, Crossing Point 3):** Grakkar reaches the Stone. If Morga
  survived and `P2_ARITHMETIC` is high, she is here for a final plea. The activation is
  **canonically fixed** — the Night happens; the player cannot un-write history. But the player
  authors *the how*:
  - **Who is warned:** does Grakkar send word that lets some innocents flee the coming silence?
    (`P2_WARNING_SENT` — reads `P2_ARITHMETIC` and the player's final choice.)
  - **Who is inside:** does he clear the Tower of the low staff — the servants, the scribes, the
    orc laborers — before he acts, at the cost of time and risk? (`P2_TOWER_CLEARED`.)
  - **What mercy survives:** the treatment of Ilvane and any final obstacle — killed, spared,
    or used. (`P2_FINAL_MERCY`.)
  - **The hand on the key:** Grakkar activates the Stone. Whether he does it in rage, in grief, in
    cold arithmetic, or with Morga's hand over his — determined by the cumulative flags — colors the
    scene but not the outcome. The lights go out, district by district (the Cold Open, now
    understood, from the inside). `P2_NIGHT_TONE`.

### 4.5 CODA — "The Chronicle" (Talindir, 2000 AO → 12 AC)

Interactive epilogue, 15–20 min. **Protagonist: Talindir** (CH-007), now ancient, in exile at
**Lunaris** (EN-014). He has spent his long life guarding Elorin's archive and chronicling the
truth. Now the Night has come, exactly as she feared, and he must decide what the record will say.

- **The assembly:** the player, as Talindir, reviews the chronicle — which is literally a tour
  through the player's own cumulative Legacy flags from both parts, presented as documents on his
  desk. Team members' fates, the descendants and institutions born of Elorin's choices, which
  safeguards held, how the Night was carried out, who was warned, who died. The 778-motif closes
  here: the unnamed made named, or not, by what the player did.
- **The final choice — the three legacy endings (§4.6).**
- **The Crossing closes:** the last beat delivers Elorin's "Same Night" vision (§4.2 Act III) with
  its content now filled by Part Two's outcome — the two protagonists, 540 years apart, sharing one
  moment across the whole game. Then Talindir seals (or does not seal) the ledger, and the title
  returns.

### 4.6 THE THREE LEGACY ENDINGS

The Night is fixed; the **meaning** is the ending. Talindir's final choice, weighted by the whole
run's flags, resolves to one of three legacy states:

| Ending | Talindir's choice | The world inherits | Canon |
|---|---|---|---|
| **The Buried Truth** | Seal the full truth in Lunaris for a future age | History loses the cause but the record survives, waiting | **★ CANONICAL.** Later-era projects canonically search Lunaris for exactly these documents. |
| **The Open Wound** | Publish everything into a world on fire | History remembers all and forgives nothing; the Age of Chaos begins in recrimination | Player-only |
| **The Kind Lie** | Write a survivable story — names protected, causes softened | The truth is lost; a gentler myth takes its place; mercy as forgery | Player-only |

The ending the player *reaches* depends on `P1_TALINDIR_TRUTH`, `P1_ARCHIVE_*`, `P2_ARITHMETIC`,
`COLDOPEN_HONEST`, and the Coda's final dialogue. The Buried Truth requires that the archive was
made and Talindir was trusted; The Kind Lie requires low truth-trust or high mercy; The Open Wound
requires the archive plus a Talindir radicalized by what he witnessed. Full resolution logic in
§9.4.

---

## 5. THE LEGACY SYSTEM (SIGNATURE MECHANIC — FULL SPEC)

The Legacy System is the game's identity. It is, technically, a set of persistent flags written in
Part One and read in Part Two and the Coda. Narratively, it is the player discovering the
consequences of their own past choices as in-world artifacts. It requires no special engine feature
beyond a persistent global flag registry (§11) that survives the Part One → Part Two transition.

### 5.1 Channel A — "The Vault You Built Is the Vault You Break"

Elorin's Act II safeguard decisions generate Grakkar's Act III vault. The vault is assembled at
Part Two Act III load time by reading these flags:

| Part One flag | Value | Part Two Act III effect |
|---|---|---|
| `P1_WARD_SCHEME` | `LATTICE` | Vault uses interlocking lattice pylons (PR-018a). Bypass = pattern/Acumen route. |
| | `ORBIT` | Rotating orbital pylons (PR-018b). Bypass = timing/Celerity route. |
| | `SEAL` | Monolithic seal pylons (PR-018c). Bypass = force/Vigor OR the flaw. |
| `P1_FAILSAFE_CUT` | `true` (cut) | A gap in the defenses Grakkar can exploit — easier infiltration, but see moral cost below. |
| | `false` (built) | Defenses whole; infiltration harder; requires the flaw or a costly alternative. |
| `P1_FLAW_DOCUMENTED` | `true` | Grakkar can *find* the flaw record in Act II → clean activation route in Act III. |
| `P1_FLAW_HIDDEN` | `true` | Grakkar must *deduce* the flaw (longer Act II investigation) → same clean route, earned harder. |
| `P1_FLAW_NONE` | `true` | No flaw exists → Act III requires a forced overload: bloodier, `P2_TOWER_CLEARED` becomes urgent, higher innocent cost. |
| `P1_TESTIMONY` | `EXPOSED` | The Void Wardens are fewer/disorganized (the Conclave's cover-up weakened them) — a Legacy kindness to future-Grakkar. |

**Design note:** the vault zone (EN-008) and its pylon assets (PR-018/019) are built ONCE and used
in both Part One (designing them) and Part Two (defeating them). Flagship reuse.

### 5.2 Channel B — "The Words You Left"

Every document Elorin authors, hides, falsifies, or burns in Part One becomes the corpus Grakkar
can discover in Part Two's Archives.

- `P1_ARCHIVE_LEFT` (bool) + `P1_ARCHIVE_LOCATION` (`LUNARIS`/`ACADEMY`/`DESTROYED`/`NEVER`):
  determines whether the full record exists for Grakkar to find, and how buried it is. Drives THE
  READER crossing point's literal content.
- `P1_WARNING` (`FILED`/`ENCODED`/`SWALLOWED`): a filed warning is discoverable evidence; an encoded
  one is a puzzle; a swallowed one leaves Grakkar working blind.
- Individual document flags (Elorin's journal PR-009, the safeguard schematic PR-010, specific
  reports) each have a `_FATE` value (`preserved`/`hidden`/`falsified`/`burned`) set by Part One
  choices and surfaced as findable (or conspicuously missing) items in Part Two.

### 5.3 Channel C — "The People You Touched"

Elorin's treatment of her team echoes 300 years forward as institutions and descendants:

| Part One relationship flag | Part Two consequence |
|---|---|
| `P1_VARA_CREDITED` true | A human scholarly lineage/school exists in Part Two; unlocks a sympathetic Archive contact and the **Vara's Heirs** side quest. |
| `P1_DURAK_TRUST` high | Durak's geomantic order endures; a Terran enclave in Part Two aids Grakkar (route through the Deep Ways / facility undercroft). |
| `P1_COIL_LOYALTY` high vs. radicalized | Coil's theoretical lineage shapes whether the facility's later research is careful (harder to exploit) or reckless (a usable weakness). |
| `P1_TALINDIR_TRUTH` | Directly seeds the Coda and the reachable endings. |
| `P1_FIRSTTEST_BLAME` (who Elorin blamed) | Determines a specific descendant NPC's disposition toward the Mandate-era institution in Part Two. |

### 5.4 Channel D — "The Safeguards' Truth"

*"The safeguards will hold"* — the novel's throughline — becomes a literal question. Which
safeguards actually engage on the Night is computed from `P1_FAILSAFE_CUT`, `P1_TESTIMONY`, and
`P1_FLAW_*`. The player spends Part Two not knowing which of their own past promises were kept,
and Act III reveals it.

### 5.5 Channel E — "What the Chronicle Can Say"

The Coda can only record what survived both parts. Every Legacy flag is tallied into Talindir's
chronicle (§4.5) and gates which of the three endings (§4.6) is reachable.

### 5.6 The Legacy Ledger (player-facing)

A dedicated UI screen (UI-010) — a chronicle interface showing, in two inks, Part One deeds
(indigo) and their Part Two echoes (rust) as they are discovered, with threads drawn between them.
In Part One it shows only the indigo column (deeds accumulating). In Part Two, rust entries appear
as the player encounters each consequence, visibly linking back. This screen is the mechanic made
legible and is the single strongest "wow" moment when a player realizes what the game has been
doing.

---

## 6. CHARACTERS

Format: **Name** — race/role · appears · asset · one-line essence · full notes.

### 6.1 Playable protagonists

**Elorin Voidweaver** — Noctari (night elf) scholar-archmage · Part One · CH-001/002, PO-001 ·
*The creator who cannot be innocent.* Low-born from Umbraveil, the valley of the two-hour sun;
brilliant, reserved, an outsider to Academy aristocracy. Her void-essence theory (power through
negation) makes her the only mind capable of the Nullstone. Defined by the gap between her
integrity and the uses others have for her genius. Voice: precise, dry, self-aware; warms only with
Talindir and, rarely, her team. Canonical fate: exile, fading from history. Three classes (§7.4).

**Grakkar (the Unbound)** — orc revolutionary · Part Two · CH-003/004/005, PO-002/003 · *The
destroyer with two centuries of reasons.* Born a slave in the Ashpile; teaches himself to read the
language of his oppressors; survives Black Crag; spends two hundred years building toward one night.
Not a brute — a strategist of terrible patience. The question the game asks through him is whether
suffering justifies catastrophe. Voice: measured, deep, deliberate; capable of tenderness he
rations like water. Canonical fate: activates the Nullstone. Three classes (§7.4).

**Talindir** — elven scribe/chronicler · Cold Open, Interlude, Coda · CH-006/007, PO-004/005 ·
*The witness who decides what history remembers.* Elorin's apprentice; inherits her archive and her
warning; lives 540 years to see her fear come true; writes the chronicle that becomes (or doesn't)
the world's memory of the Night. The player's proxy for the game's meta-question: what is the truth
worth, and to whom? Voice: gentle, careful, deepening from earnest youth to hollowed age.

### 6.2 Part One cast

**Corel** — Noctari archmagister, Elorin's superior · CH-013, PO-011 · *Decency worn thin by duty.*
Runs the containment project under Conclave pressure. Not a villain — a good administrator making
compromises he can't stop making. His arc: how much of the drift toward "control" he enables, and
whether Elorin can move him.

**Coil** — Noctari theorist, Elorin's former student · CH-009, PO-007 · *The mind that sees the
math before the cost.* Loyal, anxious, brilliant with theory and blind to consequence. Depending on
`P1_COIL_LOYALTY`, either Elorin's staunchest ally or a man who radicalizes into believing the Stone
should be used. His theoretical lineage echoes into Part Two's facility.

**Vara** — human prodigy · CH-010, PO-008 · *Twice as good, half as credited.* A human genius the
elven Academy refuses to acknowledge. Elorin's treatment of her (`P1_VARA_CREDITED`) is a moral
test and a Legacy seed — her heirs matter in Part Two.

**Durak Ironthought** — Terran geomancer · CH-011, PO-009 · *Mountain-deep caution.* Distrusts
elven grand projects on principle. Won by honesty, lost by pressure. His geomantic order can endure
three centuries to aid Grakkar.

**Sera** — Solari (sun elf) structural enchantress · CH-008, PO-006 · *The outsider's outsider.*
Seconded from Astra'Thalas; her gold palette marks her as foreign in Noctari Starfall. Divided
between her Solari loyalties and the project's truth. A possible confidante or a possible Conclave
informant, based on trust built.

**Seravin Hollow-Water** — Noctari elder, Elorin's mentor · CH-012, PO-010 · *Kindness with edges.*
Appears in memory scenes from Umbraveil. The moral compass Elorin measures herself against; her
teachings gate certain Mender-class dialogue.

**Conclave officials** — CH-014, PO-014 · the institutional antagonist, faceless by design. The
system, not a person.

### 6.3 Part Two cast

**Morga Steelheart** — orc elder, the revolution's conscience · CH-019, PO-012 · *The arithmetic
made flesh.* Argues, to Grakkar's face, that the Nullstone's price — all magic, everywhere, and
every innocent it kills — cannot be justified by any wrong, however great. The game's most important
dialogue relationship (`P2_ARITHMETIC`). Her survival past Black Crag (`P2_MORGA_ALIVE`) is a major
Act I stake.

**Kess** — young orc courier · CH-020, PO-013 · *A smile over fear.* Grakkar's Act II network agent;
a relationship of care that the player can nurture or spend. Her fate is a moral barometer.

**Overseer Ilvane** — elven facility security officer · CH-023 · *The sincere instrument.* Part
Two's pursuing antagonist. Believes utterly in the order he serves; not cruel for pleasure, which is
worse. Multiple resolution paths, none clean (`P2_FINAL_MERCY`).

**The Archivist of Astral Wisdom** — ancient elf · CH-025 · *The keeper who never asks what he
keeps.* Gatekeeper of the Archives; can be deceived, befriended, or bypassed. His records are the
Legacy corpus.

**Void Wardens** — CH-017 · the vault's constant guardians, present in BOTH parts, 300 years apart.
Their Part Two disposition is set by Elorin's `P1_TESTIMONY`.

### 6.4 Recurring / structural

**The Nullstone** — PR-001/002/003 · *not a character, but the gravity of the game.* Never speaks.
Every road bends toward it.

**The 778** — the unnamed clerks, scribes, and functionaries who make the machinery run without ever
holding a weapon. A motif, not individuals — except the handful the player meets and names through
choice. Closed out in the Coda: complicity given faces, or left faceless.

---

## 7. MECHANICS

### 7.1 Attributes (the seven — from Pieces of Fate)

Point-buy at character creation, per protagonist (Elorin and Grakkar are built separately). Range
1–10, starting pool of 30 points, base 3 in each, min 1 / max 8 at creation.

| Attribute | Governs | Elorin flavor | Grakkar flavor |
|---|---|---|---|
| **Vigor** | Force, physical resolve, endurance checks | Rare; her strength is mental | Central; labor and defiance |
| **Resilience** | Withstanding pressure, pain, interrogation, Strain resistance | Composure under Conclave | Surviving the collar |
| **Celerity** | Speed, timing, sleight, reflex checks | Quick hands in the lab | Escape and infiltration |
| **Arcana** | Essence sensitivity & manipulation | Live magic — her genius | *What was taken* — he senses magic he cannot touch |
| **Acumen** | Reason, deduction, pattern, lore, literacy checks | Her domain | Gated by `P2_LITERACY` |
| **Magnetism** | Persuasion, presence, rapport, deception | Reserved but sharp | Command earned, not given |
| **Fortune** | The wildcard — modifies uncertain checks, rare unique options | — | — |

### 7.2 Skill-check resolution (transparent, no hidden dice-hell)

A check compares **(relevant Attribute + situational modifier + Fortune wildcard)** against a
**Threshold** (DC). Thresholds: Trivial 3 / Easy 5 / Moderate 7 / Hard 9 / Extreme 11.

- **Deterministic core:** if Attribute + flat modifiers ≥ Threshold, the check passes. This makes
  builds legible — the player knows what their stats can do.
- **Fortune wildcard:** on checks flagged `uncertain`, add a Fortune roll: `rand(0, Fortune)`. This
  lets a lucky low-stat character occasionally squeak through, and adds tension without turning the
  game into a slot machine. Most social/lore checks are deterministic; a minority are `uncertain`.
- **Checks are content, not gates:** a *failed* or *unavailable* check should open a different path,
  never a dead end. Low Acumen doesn't lock the story — it changes how you get through it. This is
  the Fallout principle and it is mandatory: every critical-path check has at least one non-check
  alternative (an item, an ally, a costlier route).
- **Display:** dialogue options requiring a check show an inline tag (UI-005): `[Acumen 7]` in gold
  if passable, greyed with a small padlock if not, `[Acumen 7 · Fortune]` if uncertain.

### 7.3 Mental Strain (the resource)

A 0–100 meter (UI-006), per protagonist. Rises from: witnessing/using visions, sustained deception,
moral violation of the character's own established values, and certain Arcana/Resilience checks.
Falls from: rest, safe-haven scenes, specific companion conversations (Talindir-memory for Elorin;
Morga/Kess for Grakkar), and calming draughts (IT-011).

Strain bands and effects:
| Band | Range | Effect |
|---|---|---|
| Calm | 0–24 | No effect. |
| Frayed | 25–49 | Some warm/patient dialogue options greyed; one new "raw" option appears in tense scenes. |
| Strained | 50–74 | More options shift; unreliable narration in examine-text; minor involuntary vision chance. |
| Breaking | 75–99 | Many composed options gone; unique desperate options unlocked; involuntary visions likely — dangerous, but sometimes the only way to surface a buried truth. |
| Silence | 100 | A forced vision/breakdown scene fires; Strain resets to 60. Never a game-over — always a scene. |

**Strain is never purely punitive.** High Strain is the price of *knowing*: some truths and options
exist only at high Strain. The design tension is that the player is tempted toward it.

### 7.4 Classes (per protagonist — chosen at creation)

Classes are **philosophies of approach**, not combat kits. Each grants a starting attribute lean, a
signature ability (a repeatable non-combat verb), unique dialogue/route access, and a 2-perk track
unlocked across the campaign.

**Part One — Elorin (ways of wielding power):**

| Class | Attribute lean | Signature ability | Unique access |
|---|---|---|---|
| **Voidweaver** | Arcana / Resilience | *Unmake* — negate an essence obstacle or ward (also the deepest Nullstone design layers) | The path that "wins"; unique safeguard-design options; highest Legacy control |
| **Harmonist** | Acumen / Magnetism | *Resonate* — read the pattern of a system or institution to reveal its weak point | Conclave-politics routes; institutional persuasion closed to others |
| **Mender** | Resilience / Magnetism | *Restore* — heal harm (people, relationships, damaged records) | The conscience path; hardest checks; unique Seravin/Talindir dialogue; some doors open only to a healer |

**Part Two — Grakkar (ways of surviving power's absence):**

| Class | Attribute lean | Signature ability | Unique access |
|---|---|---|---|
| **The Scholar** | Acumen / Celerity | *Decipher* — read/exploit records and elven systems (requires & deepens `P2_LITERACY`) | Deepest Archive access; the class most transformed by Elorin's document Legacy |
| **The Chainbreaker** | Vigor / Magnetism | *Break* — force, intimidate, or rally through open defiance | Confrontation routes; rebellion-survivor trust; the Black Crag hero paths |
| **The Whisper** | Celerity / Acumen | *Vanish* — move unseen, cultivate networks, hear everything | Infiltration and favor-web routes; the class institutional enemies most fear |

**The class mirror (thematic lock):** Voidweaver↔Scholar (knowledge as power), Harmonist↔Whisper
(systems), Mender↔Chainbreaker (the body and its costs).

### 7.5 Perks

Two perks unlocked per class track across a campaign, plus **one background perk** chosen at
creation per protagonist. Each perk has an edge and a cost (Fallout-trait design).

**Elorin background perks (pick 1):** *Umbraveil-Born* (rapport with commoners/Terrans; Academy
aristocracy reads you as lesser), *Conclave-Sponsored* (institutional doors open; the team trusts
you less), *Seravin's Student* (unique Mender-adjacent dialogue anywhere; higher Strain from moral
compromise).

**Grakkar background perks (pick 1):** *Collar-Scarred* (rebellion trust, intimidation; elven NPCs
wary), *Ashpile-Sharp* (survival reads, extra examine info; slower to earn deep trust), *The Reader*
(bonus Archive/document insight from the start; a compulsion — cannot leave key records unread,
forcing knowledge that raises Strain).

### 7.6 Inventory & items

Small, meaningful inventory (no vendor-trash economy). Grid UI (UI-008), ~24 slots. Item classes:
- **Keys/documents** (IT-001/002) — progression; documents are the game's true treasure.
- **Keepsakes** (IT-003/004) — vision triggers and thematic anchors.
- **Tools** (IT-005/006/007/012) — unlock approaches (a lockcharm opens a Whisper route, etc.).
- **Trade pieces** (IT-008) — a favor economy replaces gold-centric shops; NPCs deal in debts,
  tokens, and ration chits.
- **Clothing** (IT-013/014) — social access, not armor. What you wear changes who talks to you and
  how (a Conclave formal robe opens official doors; laborer garb makes you invisible to overseers).
- **Consumables** (IT-011) — calming draughts reduce Strain.
- **Hero items** (IT-016, PR-009/010) — story-critical, non-droppable.

### 7.7 No combat (v1.0)

There is no HP, no combat encounter, no death-by-fight. The rebellion, Black Crag, Ilvane's pursuit,
and the Night itself are staged entirely through dialogue, choice, skill checks, and scene. A
"failure" is always a worse branch, never a reload screen. (Post-v1.0 stretch: an optional, simple,
tense turn-based *confrontation* system for a handful of set-pieces — explicitly out of v1.0 scope.)

---

## 8. DIALOGUE SYSTEM & SAMPLE TREES

### 8.1 System spec

Dialogue is **data-driven**: conversations are resources (JSON or Godot `.tres`), not hardcoded.
A conversation is a dictionary of **nodes**; each node has:

```
{
  "id": "node_key",
  "speaker": "elorin" | "corel" | ...,
  "portrait": "PO-011",
  "text": "The line of dialogue.",
  "set_flags": { "P1_FUNDING_LIE": true },        # optional, on entering node
  "strain": +5,                                    # optional Strain delta
  "choices": [
    {
      "text": "Player option text.",
      "check": { "attr": "Acumen", "dc": 7, "uncertain": false },   # optional
      "require_flag": { "P1_COIL_LOYALTY": ">=2" },                 # optional visibility gate
      "goto": "next_node_key",
      "goto_fail": "fail_node_key",               # if check fails
      "set_flags": { ... }                        # optional, on choosing
    }
  ]
}
```

Rules:
- A choice with an unmet `require_flag` is **hidden**. A choice with a failed `check` is **shown but
  greyed/locked** (so the player sees what a different build could do — Fallout transparency).
- `goto_fail` lets a failed check route somewhere meaningful, never a dead stop.
- Flags set here write to the global registry (§11) and persist across the Part One→Two boundary.
- Strain deltas apply immediately and re-evaluate option availability on the next node.

### 8.2 Sample tree — Part One, Act I: "The Funding Lie" (the first real moral fork)

Context: Corel needs Elorin to overstate the project's promise to the Conclave to secure funding.
Demonstrates a check, a flag set, a Strain cost, and a class-gated option.

```
[corel_ask]
COREL (PO-011): "They want a demonstration of confidence. Tell them the containment
                 method is proven. It nearly is. It will be."
  > "It isn't proven. I won't say it is."                          -> [truth]
  > "I'll tell them what they need to hear."   (set P1_FUNDING_LIE) -> [lie]  (strain +8)
  > [Acumen 7] "I can frame the uncertainty as opportunity —
     honest and fundable both."                                    -> [hedge_check]
  > [Harmonist] "The Conclave doesn't fund certainty. It funds
     leverage. Let me show you what they actually want to buy."    -> [harmonist]

[truth]  (set P1_FUNDING_TRUTH)
COREL: "Then we may lose the funding, and the surges won't wait for our honesty."
  > "Better a lost grant than a lie in the foundation."  -> [truth_end] (P1_COIL_LOYALTY +1 if witnessed)
  > "...Give me one week to make it true instead."       -> [truth_week]

[lie]
COREL: "Thank you. I know what it costs you."
  > "You don't. But it's done."  -> [lie_end]   (Sera trust -1; unlocks faster Act I, worse Act II report)

[hedge_check]  # Acumen 7 already passed to reach here
CForel: "...That might actually hold. Draft it. Both of us sign."
  (set P1_FUNDING_HEDGE) -> [hedge_end]   (best of both; requires the build)

[harmonist]  (set P1_FUNDING_HEDGE; set flag P1_HARMONIST_CorelRespect true)
COREL: "You frighten me a little, Elorin. Do it."
  -> [hedge_end]
```

Legacy reach: `P1_FUNDING_*` colors Corel's Act II malleability and appears in the Coda's chronicle
of "how the foundation was laid." A lie here is the first crack the player later watches widen.

### 8.3 Sample tree — Part Two, Act II: "Morga's Arithmetic" (the philosophical spine)

Context: recurring debate. This is one beat of several across the act; each sets `P2_ARITHMETIC`
(0–4). Demonstrates flag-gated visibility and a Legacy read from Part One.

```
[morga_arithmetic_3]  (require P2_MORGA_ALIVE)
MORGA (PO-012): "Say it works. The Stone wakes and every ward in the world goes dark.
                 The Solari fall. Good. And the child in Northreach whose heart is held
                 together by a healing-ward? She falls too. Is she your enemy, Grakkar?"
  > "No child of any people is my enemy. But I did not build the world that
     ties her life to their magic."                                  -> [morga_a] (P2_ARITHMETIC +0)
  > "One child against ten thousand years of collars. I can carry her."
     (strain +10)                                                    -> [morga_b] (P2_ARITHMETIC -1)
  > [require P1_ARCHIVE_LEFT] "The one who made the Stone left a warning.
     She feared exactly this. Maybe her fear is worth heeding."      -> [morga_legacy]
  > [Chainbreaker] "Then I will spend the years it takes to warn every
     Northreach child first. Patience is the one thing I own."       -> [morga_c] (P2_ARITHMETIC +2)

[morga_legacy]  # only if the player, as Elorin, left the archive
MORGA: "...You found her words. Then you know she paid for this knowledge too.
        Don't waste what she buried."
  (set P2_HEEDS_ELORIN true) -> [morga_a]
```

Legacy reach: `P2_ARITHMETIC` gates Act III's warning/clearing options and weights the Coda ending.
`P2_HEEDS_ELORIN` is a direct thread from the player's own Part One archive choice into Grakkar's
conscience — the Legacy System at its most pointed.

### 8.4 Dialogue authoring standards

- Every major NPC has **Strain-reactive variants** on key lines (a Breaking-band Grakkar hears Morga
  differently).
- Every critical check has a **non-check alternative** somewhere in the tree (pillar 1).
- Class-gated options are **additive flavor and route**, never the only solution.
- Examine-text (world objects) carries ~30% of the game's characterization and lore — budget it as
  first-class writing, not filler.

---

## 9. QUESTS

### 9.1 Structure

- **Main quest** per act (the spine above, §4).
- **3–5 side quests per major zone.** Every side quest must do at least one of: reveal canon,
  complicate a moral position, or plant a Consequence Web thread. No fetch-filler.
- Quests tracked in the Journal (UI-009); consequences are **not** signposted at decision time.

### 9.2 Part One side quests (selected, build-ready)

| ID | Title | Zone | Hook | Consequence (fires ≥1 act later) |
|---|---|---|---|---|
| SQ-P1-01 | **Vara's Name** | Academy | A human prodigy's work is being published under an elf's name | `P1_VARA_CREDITED`; seeds Part Two's human scholarly lineage |
| SQ-P1-02 | **The Geomancer's Terms** | Academy | Durak will join only if shown the project's true risk profile | `P1_DURAK_TRUST`; seeds Terran aid in Part Two |
| SQ-P1-03 | **What Coil Saw** | Containment | Coil has a theory that the Stone could suppress essence in *people* | `P1_COIL_LOYALTY` swing; whether the idea is buried or pursued alters Part Two facility research |
| SQ-P1-04 | **Sera's Divided House** | Starfall | Is Sera reporting to Astra'Thalas? Investigate, confront, or trust | Sets whether Sera is Act III ally or leak (`P1_SERA_LEAK`) |
| SQ-P1-05 | **The Northreach Widow** | Starfall | A survivor of the Tear begs Elorin to promise the Stone will only ever protect | A promise made here is a line in the Coda; breaking it weighs the endings |
| SQ-P1-06 | **The Buried Flaw** | Containment (Act II) | Elorin alone can build a secret weakness into the Stone — should she? | THE central Legacy fork (`P1_FLAW_*`); reshapes all of Part Two Act III |

### 9.3 Part Two side quests (selected, build-ready)

| ID | Title | Zone | Hook | Consequence |
|---|---|---|---|---|
| SQ-P2-01 | **The First Book** | Ashpile | Secure a stolen primer to learn to read | Gates `P2_LITERACY` and Scholar-class depth |
| SQ-P2-02 | **Kess's Debt** | Facility | Kess is compromised; save her, spend her, or free her | `P2_KESS_FATE`; moral barometer, Act III network strength |
| SQ-P2-03 | **Vara's Heirs** | Archives | (If `P1_VARA_CREDITED`) A human scholar-descendant can open the restricted stacks | Unlocks the cleanest Archive route — a direct Legacy payoff |
| SQ-P2-04 | **The Overseer's Doubt** | Facility | Ilvane is not certain the order is just; can that doubt be used? | Alters `P2_FINAL_MERCY` options in Act III |
| SQ-P2-05 | **What the Stone Feels Like** | Archives | Grakkar's Arcana lets him sense the Stone from afar — following it risks Strain | Reveals a fragment of Elorin's Same-Night vision early; thematic bridge |
| SQ-P2-06 | **Deducing the Flaw** | Archives (if `P1_FLAW_HIDDEN`) | Reconstruct Elorin's secret weakness from scattered records | The investigation replaces a found document with earned deduction |

### 9.4 Ending resolution logic (Coda)

Computed at Coda start from cumulative flags. Priority order (first satisfied wins):

```
IF (P1_ARCHIVE_LEFT == true) AND (P1_TALINDIR_TRUTH >= 2) AND (Talindir_final == "seal"):
    -> THE BURIED TRUTH   [★ canonical]
ELIF (P1_ARCHIVE_LEFT == true) AND (Talindir_witnessed_radicalizing) AND (Talindir_final == "publish"):
    -> THE OPEN WOUND
ELIF (P1_TALINDIR_TRUTH <= 1) OR (P2_ARITHMETIC >= 3 AND Talindir_final == "soften"):
    -> THE KIND LIE
ELSE:
    -> default to THE BURIED TRUTH if archive exists, else THE KIND LIE
```

`Talindir_final` is the Coda's closing choice; `Talindir_witnessed_radicalizing` is true if
`COLDOPEN_HONEST` and high `P2_NIGHT_TONE` severity combined. Full flag inputs in §11.

---

## 10. ENVIRONMENTS & SCENES

Each zone is a Godot scene (or scene-set). Density over breadth: small maps, high interaction
count. Every zone lists its asset IDs, key interactables, and the quests/beats it hosts.

| Zone | Asset | Part | Key interactables | Hosts |
|---|---|---|---|---|
| **Astra'Thalas balcony (festival)** | EN-006/016, PR-021 | Cold Open | banner, telescope, sealed letter, festival-goer | Tutorial; the Silence begins |
| **Starfall — Academy exterior** | EN-001, PR-015/016 | P1 | notice board, fountain, students, moon-bridge | Act I arrival; SQ-P1-01/02 hubs |
| **Academy — theory wings** | EN-002, PR-007/015 | P1 | glyph-boards, library stacks, lecterns | Team assembly; Coil/Vara scenes |
| **Academy — containment halls** | EN-003, PR-004/001 | P1 | containment rigs, the prototype, the schematic table (PR-010) | Act II core; SQ-P1-03/06; safeguard design |
| **Starfall — city streets** | EN-004, PR-016 | P1 | market, inn, canal bridges | SQ-P1-04/05; Strain-relief haven (inn) |
| **Starfall — common interiors** | EN-005 | P1 | hearths, shops, homes | Side content; the Northreach widow |
| **Umbraveil (memory)** | EN-009 | P1 | shadow-gardens, Seravin | Mender dialogue; Strain relief |
| **Astra'Thalas — capital exterior** | EN-006, PR-017/021 | P1 A3, P2 A3 | sun-braziers, gilded gates | Act III arrival (both parts) |
| **Tower of Celestial Harmony** | EN-007, PR-017 | P1 A3, P2 A3 | ceremonial doors, ward floors | Testimony (P1); infiltration (P2) |
| **The Nullstone vault** | EN-008, PR-002/018/019 | P1 A3, P2 A3 | ward pylons, the dais, the Stone | Sealing (P1); THE SAME NIGHT (P2) — vault generated from Legacy |
| **The Ashpile** | EN-010, PR-014 | P2 | roll-call post, collar station, shacks | Act I; SQ-P2-01; Morga intro |
| **Black Crag (flashback)** | EN-011, VS-007 | P2 | (largely scripted) | Act I climax; the Rebellion |
| **Research facility — labor floors** | EN-012, PR-011/012/013 | P2 | furnaces, ore lifts, machinery | Act II infiltration hub; SQ-P2-02/04 |
| **Archives of Astral Wisdom** | EN-013, PR-007/008 | P2 | scroll stacks, ward-gates, the Archivist | Act II core; the Legacy corpus; SQ-P2-03/05/06; THE READER |
| **Lunaris — Talindir's study** | EN-014, PR-008/022 | Coda | the ledger, document chests, the window | The Chronicle; the three endings |
| **Vision space** | EN-015, VS-002/003/004/005 | Both | (crossing points) | The Glance, The Reader, The Same Night |

---

## 11. FLAG REGISTRY (PERSISTENCE SPEC)

The single global registry that makes the Legacy System work. Implemented as a Godot **autoload
singleton** (`GameState`) holding a `Dictionary`, serialized to the save file. Survives the Part
One → Part Two → Coda transitions (it is never cleared mid-run). Human-readable; testable in
isolation (write in a P1 test scene, read in a P2 test scene — the Ledger checkpoint).

### 11.1 Part One flags (written in P1, read in P2/Coda)

| Flag | Type | Values | Written | Read by |
|---|---|---|---|---|
| `P1_FUNDING_LIE/TRUTH/HEDGE` | enum | one-of | Act I | Corel Act II; Coda |
| `P1_VARA_RECRUITED` | bool | — | Act I | P2 SQ-P2-03 |
| `P1_VARA_CREDITED` | bool | — | SQ-P1-01 | P2 Archives route; Coda |
| `P1_DURAK_TRUST` | int | 0–3 | SQ-P1-02 | P2 Terran aid |
| `P1_COIL_LOYALTY` | int | 0–3 | Act I–II | P2 facility research state; Coda |
| `P1_FIRSTTEST_BLAME` | enum | self/team/project | Act I climax | P2 descendant NPC; Coda |
| `P1_WARD_SCHEME` | enum | LATTICE/ORBIT/SEAL | Act II | P2 A3 vault gen |
| `P1_FAILSAFE_CUT` | bool | — | Act II | P2 A3 vault; Channel D |
| `P1_FLAW_DOCUMENTED/HIDDEN/NONE` | enum | one-of | SQ-P1-06 | P2 Act II & A3 (deepest fork) |
| `P1_GLANCE_SEEN` | bool | — | Act II (The Glance) | P2 The Glance (other side) |
| `P1_SERA_LEAK` | bool | — | SQ-P1-04 | P1 A3; Coda |
| `P1_TESTIMONY` | enum | TRUE/LIE/EXPOSED | Act III | P2 Warden disposition; Coda |
| `P1_ARCHIVE_LEFT` | bool | — | Act III | THE READER; Morga; Coda |
| `P1_ARCHIVE_LOCATION` | enum | LUNARIS/ACADEMY/DESTROYED/NEVER | Act III | P2 findability; Coda |
| `P1_WARNING` | enum | FILED/ENCODED/SWALLOWED | Act III | P2 Act II |
| `P1_TALINDIR_TRUTH` | int | 0–3 | Act III | Coda ending logic |
| `P1_NORTHREACH_PROMISE` | bool | — | SQ-P1-05 | Coda weighting |

### 11.2 Part Two flags (written in P2, read in Coda)

| Flag | Type | Values | Written | Read by |
|---|---|---|---|---|
| `P2_LITERACY` | bool | — | SQ-P2-01 | Scholar depth; Archive access |
| `P2_MORGA_ALIVE` | bool | — | Act I (Black Crag) | Act II arithmetic; Coda |
| `P2_BLACKCRAG_ROLE` | enum | defiance/rescue/preserve | Act I | Act II trust; Coda |
| `P2_ARITHMETIC` | int | 0–4 | Act II (Morga beats) | Act III options; Coda |
| `P2_HEEDS_ELORIN` | bool | — | Act II | Coda (thread from P1 archive) |
| `P2_KESS_FATE` | enum | saved/spent/freed/lost | SQ-P2-02 | Act III network; Coda |
| `P2_ILVANE_DOUBT` | bool | — | SQ-P2-04 | `P2_FINAL_MERCY` options |
| `P2_WARNING_SENT` | bool | — | Act III | Coda (innocents saved) |
| `P2_TOWER_CLEARED` | bool | — | Act III | Coda (innocents saved) |
| `P2_FINAL_MERCY` | enum | killed/spared/used | Act III | Coda tone |
| `P2_NIGHT_TONE` | enum | rage/grief/cold/shared | Act III | Elorin vision content; Coda |

### 11.3 Cross-part & meta flags

`COLDOPEN_HONEST` (bool, Cold Open) · `Talindir_final` (enum: seal/publish/soften, Coda) ·
`Talindir_witnessed_radicalizing` (derived) · plus per-class and per-perk selection flags for both
protagonists (`P1_CLASS`, `P1_PERK`, `P1_ATTR[]`, `P2_CLASS`, `P2_PERK`, `P2_ATTR[]`).

---

## 12. UI / UX

Every screen is an asset (UI-###) and a Godot scene. Aesthetic: illuminated-manuscript dark
fantasy — aged parchment, deep indigo, antique gold, arcane filigree.

| Screen / element | Asset | Function | Notes |
|---|---|---|---|
| Dialogue box (9-slice) | UI-001 | Core conversation display | Parchment field, filigree border; typewriter text reveal |
| Portrait frame | UI-002 | Speaker bust | Two variants (Elorin indigo / Grakkar iron era) |
| Choice buttons | UI-003 | Player options | States: normal/hover/pressed/locked; locked shows glyph padlock |
| Skill-check tags | UI-005 | Inline `[Attr DC]` on options | Gold=passable, grey+lock=not, +Fortune=uncertain |
| Attribute glyphs (7) | UI-004 | The seven attributes | Readable at 16px |
| Mental Strain meter | UI-006 | Strain 0–100 | Cracking-glass-vial motif; always visible in play |
| Character sheet | UI-007 | Attributes, class, perks | Illuminated-page layout; per protagonist |
| Inventory panel | UI-008 | ~24-slot grid | Item detail column; clothing = social access shown here |
| Journal / quest log | UI-009 | Active/complete quests | Two-page book; no consequence spoilers |
| **Legacy Ledger** | UI-010 | The signature screen | Indigo P1 deeds ↔ rust P2 echoes, threaded; the "wow" |
| Main menu / key art | UI-011 | Title screen | Tower at the moment the lights die |
| Title logo | UI-012 | Branding | KAYOS carved-stone serif + script subtitle |
| Act/era title cards | UI-013 | Chapter transitions | Six cards with era dates |
| Save/load cards | UI-014 | Persistence UI | Wax-seal chronicle-page styling |
| Cursor & indicators | UI-015 | talk/examine/take/exit | 16px, gold accent |
| System icons | UI-016 | Settings etc. | Consistent stroke set |
| Vision overlay | UI-017 | Crossing-point transitions | Star-void vignette + glyph drift |
| Notification chips | UI-018 | quest/item/**Legacy flag** | The "the ledger remembers" seal is its own chip |

**UX principles:** single-question-at-a-time dialogue; all consequence hidden at decision time;
examine-everything encouraged (examine cursor always available); Strain and Ledger are the only
persistent HUD elements; controller and keyboard/mouse both supported (Input Map, §7 of build).

---

## 13. TECHNICAL SPECIFICATION

> ## ⚠ THE LOCKED SPEC — single source of truth (reconciled 2026-07-17)
>
> **If any other document, comment, or asset disagrees with this table, this table wins** and the
> other thing is stale. Fix it; do not work around it, and do not "correct" code to match a doc that
> contradicts this block. This rule exists because it has already gone wrong twice in one day: the
> old sprite figure outlived its own decision here and caused an agent to shrink correct sprites, and a
> reconciliation brief then re-confirmed an already-superseded viewport from this same section.
> **Every value below is dated. If you change one, change it here first.**
>
> | Property | Value | Notes |
> |---|---|---|
> | Native viewport | **960 × 540** | decided 2026-07-17 |
> | Default window | **1920 × 1080** | exactly **2×**; 4K is exactly 4× |
> | Stretch mode / aspect / scale | **canvas_items / keep / integer** | |
> | Default texture filter | **Nearest** | |
> | Camera2D zoom | **1.0 — never lower** | see *Camera* below |
> | Tile grid | **32 × 32 px** | tilesets only — unrelated to sprite frames |
> | Character sprite frame | **48 × 72 px** | locked 2026-07-17 |
> | Character sprite sheet | **192 × 288 px** (4 cols × 4 rows) | |
> | Sheet row order | **0 = down, 1 = up, 2 = left, 3 = right** | |
> | Frame baseline | **feet on the frame's bottom edge**; headroom varies | |
> | Frame width sufficiency | **48 px confirmed sufficient** | confirmed 2026-07-17; art must respect it |
> | Portraits | 512 × 512 source → **96 × 96** in game | |
> | Item icons | **32 × 32** | |
> | Story panels | **1920 × 1080**, painterly (deliberate register shift) | not pixel art |
>
> **Why 960×540 and not 640×360 or 1280×720.** It is the only option that is *both* a real step up in
> how much world is on screen (2.25× the area of 640×360) *and* integer-clean on the target displays:
> 2× to 1080p, 4× to 4K. 1280×720 fails this — it is 1.5× to 1080p, and `scale_mode = integer`
> rounds *down*, so it renders at 1× in the middle of a black border.

- **Engine:** Godot 4.7 stable, GDScript. Renderer: Compatibility (2D, web-export-capable).
- **Aesthetic:** HD-2D pixel art with a modern twist — detailed sprites and lit, layered backdrops.
  Never a bare black void behind a scene; every zone gets a backdrop.
- **Camera:** Camera2D `zoom` stays at **1.0**. To show more of the world, raise the native
  resolution — **never zoom the camera out**. Zoom below 1.0 is a non-integer downscale and visibly
  destroys nearest-neighbour art. Zones larger than the viewport pan via Camera2D limits.
- **Sprites:** character art height varies by race within the shared 48×72 frame — see the
  **SPRITE SCALE** sheet in the Asset Bible for the height chart. `docs/Affinity_Cleanup_Guide.md`
  is the production walkthrough. Reference: **CH-001 (Elorin) is 64 px tall in a 48×72 frame**;
  every other elf/human matches her. Do not re-derive this from anything else.
- **Core singletons (autoloads):**
  - `GameState` — the flag registry (§11) + inventory + current-protagonist context. Serialized to save.
  - `DialogueManager` — loads conversation resources, walks nodes, evaluates checks/flags, emits signals to UI.
  - `SceneManager` — scene transitions, persistence of world state per zone, fade/title-card handling.
  - `AudioManager` — music/ambient buses (audio is P4/placeholder for v1.0).
- **Data formats:** dialogue as `.tres` resources or JSON (§8.1 schema); quests as resources;
  item/attribute/perk definitions as resources for data-driven tuning.
- **Save system:** single serialized `GameState` (flags + inventory + protagonist + scene + position).
  Because the Legacy System *is* the flag registry, the save file already carries everything the
  Coda needs — no separate legacy store required.
- **Scene architecture:** each zone = one scene; Player = its own scene instanced into zones;
  NPCs = a base NPC scene + per-character data resource; dialogue UI = one scene driven by
  `DialogueManager`.
- **Performance:** trivial (2D, static scenes, no combat/physics load beyond player collision).
  Target 60fps on low-end hardware; web build viable.
- **Localization-readiness:** all display text in data resources, keyed — no hardcoded strings in
  logic. (Localization itself is out of v1.0 scope but the architecture must not preclude it.)

---

## 14. SCOPE & OUT-OF-SCOPE (v1.0)

**In scope:** full two-protagonist narrative; Legacy System (all five channels); seven attributes;
Mental Strain; six classes; perks; deterministic+Fortune checks; inventory/favor economy; all zones
§10; all UI §12; three endings; save/load.

**Out of scope for v1.0 (stretch goals):** any combat/confrontation system; Grakkar-first NG+;
voice acting; full original score (placeholder audio only); localization; the shelved *KAYOS:
Undertone* project (canon-locked project #2, chronologically downstream, may inherit this game's
Legacy web in future).

---

## 15. CONTENT MANIFEST (MASTER CHECKLIST)

Every buildable element, collated. Cross-referenced to the Asset Bible IDs.

**Protagonists (3):** Elorin (CH-001/002, PO-001), Grakkar (CH-003/004/005, PO-002/003),
Talindir (CH-006/007, PO-004/005).
**Named NPCs (P1):** Corel, Coil, Vara, Durak, Sera, Seravin (+ Conclave generics).
**Named NPCs (P2):** Morga, Kess, Ilvane, the Archivist (+ Void Wardens, laborers, facility staff).
**Zones (15):** §10 table — every EN-### + prop set listed there.
**Quests:** 5 main-act spines + 12 detailed side quests (SQ-P1-01…06, SQ-P2-01…06) + additional
per-zone side content to the 3–5 target.
**Systems:** attributes ×7, classes ×6, perks (6 background + 12 class-track), Strain, checks,
inventory, favor economy, Legacy System ×5 channels, three endings.
**Dialogue:** every named NPC fully authored with Strain-reactive and flag-gated variants; §8 schema;
examine-text for all interactables (§10).
**Flags (~40):** full registry §11.
**UI (18 screens/elements):** §12 table.
**Story panels (10):** VS-001…010 (§4 crossing points & endings).
**Items:** IT-001…016 (Asset Bible), hero items PR-009/010, IT-016.
**Fonts/audio:** FN-001/002 (sourced), FN-003 (audio placeholder).

**Build order (recommended):** (1) core singletons + flag registry + Ledger test → (2) dialogue
system + one NPC → (3) character sheet + checks → (4) inventory → (5) scene management + save →
(6) **vertical slice: Cold Open + Part One Act I (Starfall)** → (7) remainder of Part One → (8) the
Part One→Two handoff + Legacy read test → (9) Part Two → (10) Coda + endings → (11) polish, visions,
audio.

---

*End of GDD v1.0. This document, the Asset Bible, and the canonical Night of Silence master outline
together constitute the complete build specification for KAYOS: The Night of Silence.*
