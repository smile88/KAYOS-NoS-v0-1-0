# KAYOS: Starfall — Meshy Text-to-3D Prompt Library

All prompts verified under Meshy's **800-character prompt limit** (Meshy has no separate
negative-prompt field — exclusions are worded into the prompt itself where needed).
Source lore: `docs/Starfall_City_Codex.md`, `docs/3D_Asset_Bible.md`, `docs/GDD.md`.

## Workflow notes (settings outside the prompt box)

- **Pose** (characters only): T-Pose, for the auto-rig pipeline.
- **Model Type:** Standard.
- **Polygon count / topology:** set on the export panel *after* approving a preview mesh — not a generation-time field.
- **Texturing:** run Meshy's AI Texturing as a second step once geometry is approved (Preview → Refine, not one shot).
- **For architecture with structural details that matter (stairs, doors, symmetry):** prefer Meshy's **Multi-Image-to-3D** (3–4 Nano Banana 2 angle shots of the same building — front, 3/4, side, back) over single-image or text-only. Single-image/text generation hallucinates unseen geometry, which is what causes asymmetric stairs, stairs that don't reach the top floor, and odd-looking doors.

---

## BUILDINGS & ARCHITECTURE

**Style anchor** (reused verbatim in every building prompt below):
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text.

### Common Starfall buildings

**Terraced home**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Small terraced dwelling stepped into a hillside, flat roof forming the neighbor's doorstep above, one slender window-spire with a small star-crystal shard in a silvered frame, closed dark polished wood shutters, narrow silvered terrace-edge rail, a small hand-carved family sigil above the door.

**Magic emporium (star-glass curio shop)**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Narrow vertical shopfront with a tall arched leaded star-glass window in smoky multicolor panes, three small crystal-comb blades fanned above the door as a trade sign, visible interior shelves of bottled void-fragments and silvered instruments, a slim miniature spire above the shop out of scale for its size.

**Archive / library**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Low wide windowless-at-street-level basalt building, a ring of small round roof skylights each capped with a starlight-crystal lens, one grand silvered double door twice human height engraved with concentric ring motifs, no signage, deliberately unspired flat-roofed silhouette.

**Canal-tier market / trade house**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Two-storey canal-quarter shopfront, ground floor open under a colonnade of thin basalt piers, upper floor shuttered dark-wood residence windows, goods hanging under the colonnade marked by small hanging crystal chips instead of painted signs, a footbridge reaching the door.

**Tea house / public gathering hall**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Round building with a true dome echoing the rim towers at small scale, a low silvered-rail terrace ringing the base, an unglazed open sky-hole at the dome's crown, warm amber-tinted lamps along the inner wall, twin dark-wood doors carved with a simple star motif.

### The Nine Rim Towers (House seats)

**House Vael'Suran — Keepers of the Fixed Stars**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial at the dome peak. Steadiest brightest lamp light of any tower, plain symmetrical unornamented form, a narrow banner below the dome bearing a silver gnomon crossed by one star.

**House Nyx'Talar — Wardens of the Occultation**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial at the dome peak. Dimmest hooded lamp finial with a small silvered cowl, closed shuttered apertures ringing the upper drum, banner bearing a black disc crossing a silver ring.

**House Oravelle — Trackers of the Wanderers**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial at the dome peak. A ring of small circular tracking apertures studs the drum below the dome, banner bearing five linked silver circlets curving across indigo cloth.

**House Sabreth — Readers of the Long-Haired Stars**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial at the dome peak. A thin trail of gold leaf bleeds down the dome from the lit finial like a comet's tail, banner bearing a silver star trailing a gold comet-tail.

**House Ilmyra — Keepers of the Tides of the Song**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial at the dome peak. Three nested silvered rings encircle the dome, mounted proud of the surface, banner bearing three nested crescents on indigo cloth.

**House Corvane — Scholars of the Deep Field**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail. Unlit dome with no lamp glow, a single plain empty silver ring set into the stone below the dome, no banner, starkest darkest tower of the set.

**The Dead House (H6)**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, deep indigo-black stone, silver-white highlights, weathered neglected surface, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail. Dome completely dark and unlit, a single cracked black shard motif scored diagonally across the dome surface, empty bare banner pole, no sigil, no lamp finial glow.

**House Duskmere — Watchers of the Horizon**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail. A thin horizontal ring of pale light runs around the dome's base instead of a single peak point, dome sits slightly lower and broader, banner bearing a silver horizon-line under a half-sunk star.

**House Serenthil — Keepers of the Meridian**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Cylindrical basalt observatory tower, domed roof, spiral stair wrapping the shaft, silvered top-gallery rail, lit lamp-room finial. A dead-straight vertical line of silver light runs the tower's full height, a small bell-wheel visible through a high window, banner bearing a vertical silver line through one gold point.

### The Academy of Astral Harmony (island centre)

**The Great Observatory**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Colossal verdigris-domed observatory drum, far taller and grander than a rim tower, tall lit spire finial crowning the dome, wide open aperture cut into the dome's side exposing an interior instrument, silvered-rail balcony ring girdling the drum at mid-height, low colonnade of slender basalt piers at the base.

**The Theory Wings & Moon-Bridge**
> Noctari elven fantasy architecture, hard-surface stylized game asset, dark basalt walls, silvered metal fittings, faceted glowing starlight crystal accents, deep indigo-black stone, silver-white highlights, cold star-blue glow, thin antique gold accent, clean geometric forms, PBR-ready, neutral grey background, no text. Two long low symmetrical library-hall wings with tall arched comb-crystal windows glowing faint star-blue, joined at second-storey height by one graceful arched stone bridge spanning between them, dark polished wood door at each wing's near end, flatter horizontal proportions than a tower.

---

## CHARACTERS

**Character style anchor** (reused verbatim in every character prompt below):
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text.

**Culture sub-anchors** (folded into the relevant character's prompt):
- *Noctari:* pale grey-violet skin, pointed ears, slender build; indigo-black robe, silver-white embroidery, cold star-blue accents, thin antique gold trim.
- *Solari:* warm ivory skin, pointed ears, elegant build; white and warm gold robe, ivory trim, honey-toned accents.
- *Orc:* broad powerful build, ash-grey skin, tusks; iron-grey, rust, coal-black rough garb, one small ember-orange accent.
- *Terran:* short granite-broad build, stone-toned skin with mineral texture; ochre and umber vestments, dim green-gold glyph accents.
- *Human:* plain unadorned clothing in muted neutral tones, no elven finery, no gold or silver trim.

### The playable protagonists

**Elorin — prime (Part One player character)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, slender build, pointed ears, deep indigo-black robe, silver-white astronomical embroidery, cold star-blue accents, thin antique gold collar band. Female archmage in her forties, hair drawn back severely, reserved precise posture, one eye with a faint void-black iris ring, one hand posed as if holding a small dark crystal fragment.

**Elorin — exile**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, slender build, pointed ears, same face as a younger archmage version but aged decades, silver hair, stooped posture. Worn travel cloak layered over ruined indigo void-scholar robes beneath, faint void-black iris ring in one eye, thinner and more fragile silhouette.

**Grakkar — young (Part Two Act I, 1780s AO)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc: ash-grey skin, tusks, lean youthful build not yet broad, barefoot, ragged laborer clothing, plain iron collar around the neck, watchful guarded posture, same facial structure as an older prime-adult version for age-scaling reference.

**Grakkar — prime (Part Two Act II, the Long Game)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc: ash-grey skin, tusks, broad heavily-scarred powerful build, healed scar ring around the throat where a collar once sat, rough laborer garb layered over hidden discipline, no weapon, deliberate patient standing posture rather than aggressive.

**Grakkar — elder (Part Two Act III, 2000 AO)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc: grey weathered skin, tusks, massive heavy build, same throat collar-scar and face shape as the prime adult version but aged, heavier brow, stooped shoulders, one hand open and forward as if resting on a surface.

**Talindir — young (Cold Open player character)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, pointed ears, slight youthful build. Plain ink-stained scribe robes with no gold trim, a satchel slung across the body, open hopeful posture, earnest expression.

**Talindir — aged (Coda player character)**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, pointed ears, same face as a younger scribe version but ancient and hollowed. Plain grey-blue robes (not House indigo), stooped frail posture, longer thinner hair, hands folded.

### Supporting cast

**Corel**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, slender build. Middle-aged administrator-mage, layered heavy indigo robes, silver trim, a bundle of papers in one hand, tired bowed-shoulder posture.

**Coil**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, slender young build. Indigo robes a size too formal, silver trim, slightly hunched eager posture, anxious bright expression.

**Vara**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Human woman: plain unadorned clothing in muted neutral tones, no elven finery, no gold or silver trim. Proud tired posture, practical scholar's dress, holding a small object of study.

**Durak Ironthought**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Terran: short granite-broad build, stone-toned skin with visible mineral texture, ochre and umber stone-inlaid vestments, faint green-gold glyph inlay pattern, arms crossed, grounded stance.

**Sera**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Solari sun-elf: warm ivory skin, pointed ears, elegant build. White and warm gold enchantress robes, ivory trim, honey-toned accents, precise guarded posture.

**Seravin Hollow-Water**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, elderly slender build. Umbraveil-style twilight indigo-violet robes with warm amber trim (not gold), soft kind posture, hands loosely open.

**Morga Steelheart**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc: ash-grey skin, tusks, stout grey-braided female build, sturdy rounded silhouette, rough warm-toned clothing, one hand raised mid-gesture, steady confident stance.

**Kess**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc: ash-grey skin, small tusks, small quick-built youthful frame, light ragged courier clothing, a satchel across the body, alert weight-forward stance.

**Overseer Ilvane**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, slender build. Crisp formal facility uniform in indigo and silver, a ward-baton held at the side, precise symmetrical composed stance.

**The Archivist**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: pale grey-violet skin, impossibly ancient hunched build. Heavy dust-grey robes layered over indigo, long draped sleeves hiding the hands, near-motionless posture.

**Grand Archmage Sulvaine**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Solari sun-elf: warm ivory skin, elderly elegant build. Ornate heavy gold ceremonial regalia, ivory undercloth, arms raised upward in a ceremonial gesture.

**Conclave officials**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf: slender build. Identical formal hooded indigo robe, smooth featureless mask, one gold sigil centered on the chest, rigid neutral posture, designed as a repeatable crowd figure.

**Void Wardens**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf guard: dark ward-marked plate armor over indigo cloth, closed featureless helm, silvered ward-sigils etched into the armor, rigid symmetrical stance, timeless design with no era-specific ornament.

### NPC archetypes (crowd, retint in-engine)

**Hooded elf civilian**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf civilian: plain hooded robe, simple readable silhouette, no House ornamentation, neutral mid-grey cloth for easy recoloring.

**Robed scholar**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf scholar: plain academy robe, a small book held against the chest, slightly formal upright posture, neutral indigo cloth for recoloring.

**Orc laborer**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Orc laborer: ash-grey skin, tusks, sturdy build, ragged work clothing, a simple pick or hod tool in one hand, plain iron collar as a removable attachment.

**Terran folk**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Terran folk: stone-broad generic build, stone-toned skin, plain ochre geomantic-inlay clothing, simplified detailing for a background crowd figure.

**Facility overseer/guard**
> Stylized dark-fantasy game character concept, hard-surface and cloth-ready design, clean forms, PBR-ready materials, plain grey background, no text. Noctari night-elf guard: generic uniformed facility body, ward-baton at the side, plain unmarked uniform, same silhouette family as a named officer but stripped of insignia for reuse.
