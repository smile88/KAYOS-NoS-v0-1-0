# KAYOS: Cold Open — Nano Banana 2 Image Prompts (for Meshy Image-to-3D)

Scope: the Astra'Thalas festival balcony, the cityscape below it, and the Tower of Celestial Harmony
with Grand Archmage Sulvaine at its lit apex (the Cold Open's tower figure per canon — not Grakkar).
Grakkar is not atop the Tower because he's a different *place*, not a different *time*: this is the
same night, 2000 AO winter solstice, as his own Act III activation in the Nullstone vault beneath this
same Tower. Talindir on the balcony is watching the effect (the lights going out) of what Grakkar is
doing at that exact moment in the vault below. The vault itself is out of scope for this prompt set.
Source: `docs/GDD.md` §4.1/§4.4, `docs/Zone_Atlas.md` Z-01, `docs/3D_Asset_Bible.md` §3/§4/§5.

Every prompt below is a **single self-contained paste** — the relevant anchor is written directly
into it, not referenced separately.

## Workflow notes

- **This is a different pipeline from the Meshy Text-to-3D prompts** (`docs/KAYOS_Meshy_Prompts.md`)
  — these are Nano Banana 2 image prompts, meant to feed Meshy's **Image-to-3D**. No 800-character
  limit applies here; that limit is specific to Meshy's own text box.
- **For anything with structural detail that matters** (the balustrade, the Tower, any prop with a
  clear front/back), generate 2–3 angles of the *same* image with the same prompt and just swap the
  final camera-angle sentence (e.g. "three-quarter front view" → "three-quarter rear view" → "side
  profile view"), then feed the set into Meshy's **Multi-Image-to-3D** rather than a single image.
  This is what actually fixes the asymmetric-stair/odd-door problem you hit with the towers — not the
  prompt wording, the number of reference angles.
- Architecture prompts below use the **Environment Anchor** (atmosphere matters, matches the register
  your tower images already used successfully). Prop prompts use the **Object Anchor** (clean, evenly
  lit, plain background — better for Meshy to reconstruct small precise geometry from). Texture
  prompts use the **Texture Anchor** (flat, seamless, no perspective).

---

## ENVIRONMENT & ARCHITECTURE

**The Balcony Platform & Balustrade**
> Cinematic architectural concept render of KAYOS: The Night of Silence, a Solari sun-elf capital, Astra'Thalas, during the winter solstice Luminarae festival. White and veined marble, antique and bright gold leaf, warm ivory stone, honey-lacquer wood, sun-mosaic tesserae. Warm, high, generous golden light — the Elder Song's glow — against a deep indigo dusk sky with faint silver stars. Painterly but structurally precise, clean readable architectural forms, high detail, no text, no watermark. The high festival balcony itself: a wide white marble platform with a knee-height balustrade of turned marble balusters running along its outer edge, a carved rail-top with delicate sun-motif relief, warm festival star-lamps glowing at intervals along the rail. Three-quarter establishing view from just above the platform, looking along the rail toward the open night sky, no people in frame.

**The Sun Mosaic (balcony floor feature)**
> Cinematic architectural concept render of KAYOS: The Night of Silence, a Solari sun-elf capital, Astra'Thalas, during the winter solstice Luminarae festival. White and veined marble, antique and bright gold leaf, warm ivory stone, honey-lacquer wood, sun-mosaic tesserae. Warm, high, generous golden light — the Elder Song's glow. Painterly but structurally precise, clean readable forms, high detail, no text, no watermark. A circular sun-mosaic inlaid into the balcony's marble floor: radiating gold and warm-ivory tesserae in a stylized sun-disc pattern, gold-leaf tesserae catching festival lamp-light, set into plain surrounding white marble flooring. Top-down three-quarter view showing the full disc and the marble around it, no people in frame.

**Astra'Thalas Cityscape (the view below)**
> Cinematic architectural concept render of KAYOS: The Night of Silence, a Solari sun-elf capital, Astra'Thalas, during the winter solstice Luminarae festival. White and veined marble, antique and bright gold leaf, warm ivory stone. Warm, high, generous golden light — the Elder Song's glow — against a deep indigo dusk sky with faint silver stars. Painterly but structurally precise, high detail, no text, no watermark. A sweeping view of the city seen from a high balcony at night: tiered white-marble terraces stepping down in receding rows toward a distant plaza, warm gold festival lights and lamp-glow in windows and streets, a festival crowd suggested only as small distant motion far below. Wide establishing three-quarter aerial angle looking outward and downward from the balcony rail.

**The Tower of Celestial Harmony (full exterior)**
> Cinematic architectural concept render of KAYOS: The Night of Silence, a Solari sun-elf capital, Astra'Thalas, during the winter solstice Luminarae festival. White and veined marble, antique and bright gold leaf, warm ivory stone, honey-lacquer wood. Warm, high, generous golden light — the Elder Song's glow — against a deep indigo dusk sky with faint silver stars. Painterly but structurally precise, clean readable architectural forms, high detail, no text, no watermark. The Tower of Celestial Harmony: a tall tapered white-marble-and-gold spire rising far above the city, narrowing from a broad fluted base to a slender lit apex, tiers of gilded ceremonial galleries visible as it rises, a brilliant warm gold-white glow crowning the very top where the Celestial Invocation draws the Song up through the spire. Full-height three-quarter establishing view, no people in frame.

**The Tower Apex — Grand Archmage Sulvaine's Invocation**
> Cinematic architectural concept render of KAYOS: The Night of Silence, a Solari sun-elf capital, Astra'Thalas, during the winter solstice Luminarae festival. White and veined marble, antique and bright gold leaf, warm ivory stone. Warm, high, generous golden light — the Elder Song's glow — against a deep indigo dusk sky with faint silver stars. Painterly but structurally precise, high detail, no text, no watermark. A close detail view of the Tower of Celestial Harmony's lit summit platform at night: an aged Solari archmage in heavy gold ceremonial regalia stands at the tower's apex, arms raised skyward, drawing a warm golden glow up through the spire around him. Three-quarter view from slightly below, the figure small and distant against the vast glowing tower top.

---

## PROPS & FIXTURES

**Festival Banner**
> Product-style concept render of a single KAYOS: The Night of Silence Solari festival object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, white and warm gold and ivory palette with honey-lacquer wood and antique gold trim, clean readable silhouette, no text, no watermark, no other objects in frame. A tall Luminarae festival banner: rich ivory-and-gold fabric bearing a stitched sun-disc emblem, gold fringe trim along the bottom edge, hanging with a few soft natural folds, mounted on a slender gilded pole.

**The Telescope**
> Product-style concept render of a single KAYOS: The Night of Silence Solari festival object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, white and warm gold and ivory palette with honey-lacquer wood and antique gold trim, clean readable silhouette, no text, no watermark, no other objects in frame. An ornate Solari brass-and-gold ceremonial telescope on a slender tripod stand: polished brass tube with engraved sun-motif banding, a small eyepiece lens, honey-lacquered wood tripod legs, angled upward as if aimed at the sky.

**Talindir's Satchel**
> Product-style concept render of a single KAYOS: The Night of Silence object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, clean readable silhouette, no text, no watermark, no other objects in frame. A worn leather scribe's satchel with a long shoulder strap, a small brass buckle clasp, ink-stained edges, the flap slightly open revealing a corner of folded parchment inside — plain and practical rather than ornate, in contrast to the gold-and-marble Solari objects around it.

**The Sealed Letter**
> Product-style concept render of a single KAYOS: The Night of Silence object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered close three-quarter view, high surface detail, clean readable silhouette, no text, no watermark, no other objects in frame. A single folded parchment letter, three hundred years aged and yellowed at the edges, sealed shut with a dark indigo-black wax seal stamped with a faint void-ring sigil, tied closed with a thin worn ribbon, resting flat.

**The Ledger & Seal-Kit**
> Product-style concept render of a single KAYOS: The Night of Silence object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, clean readable silhouette, no text, no watermark, no other objects in frame. A thick leather-bound scribe's ledger, worn ivory-toned pages visible at the fore-edge, a brass clasp, resting closed, with a small wax-seal stamp and stick of sealing wax set beside it.

**The Festival Broadsheet**
> Product-style concept render of a single KAYOS: The Night of Silence object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, clean readable silhouette, no watermark, no other objects in frame. A single printed festival broadsheet: cream parchment paper with a decorative calligraphic header layout and a small gold sun-disc illustration at the top, sparse ornamental flourishes rather than legible text, slightly curled at the corners, resting flat.

**The Festival Mask**
> Product-style concept render of a single KAYOS: The Night of Silence Solari festival object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, white and warm gold and ivory palette, clean readable silhouette, no text, no watermark, no other objects in frame. An ornate Solari festival half-mask: gilded gold filigree scrollwork over a warm ivory base, a sun-ray motif radiating from the eye openings, a few small polished citrine-colored gems set into the brow, smooth polished finish.

**Festival Star-Lamp**
> Product-style concept render of a single KAYOS: The Night of Silence Solari festival object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, white and warm gold and ivory palette, clean readable silhouette, no text, no watermark, no other objects in frame. A Solari star-lamp fixture: a warm gold-and-glass orb lantern mounted on a slender gilded bracket arm, glowing softly gold from within with no visible flame, fine sun-motif metalwork caging the glass.

**Festival Wine Cup**
> Product-style concept render of a single KAYOS: The Night of Silence Solari festival object, isolated on a plain neutral light-grey background, soft even studio lighting with minimal cast shadow, centered three-quarter view, high surface detail, white and warm gold and ivory palette, clean readable silhouette, no text, no watermark, no other objects in frame. A small Solari festival drinking cup: polished warm-gold metal with a fluted sun-disc base, a faint engraved sun-ray motif around the rim, simple elegant proportions.

---

## THE SILENCE — the draining state (reference only, not new geometry)

The Cold Open's actual climax is the Night of Silence itself: the lights going out district by
district, color draining from the world. Per the Asset Bible this is **the same geometry as above**,
just drained — a shader/lighting state (`Zone3D.drain_to_dark`, already implemented), not a second
set of models. The two images below aren't meant to go through Meshy at all — they're reference art
for tuning that drain shader (target colors, how dead the gold should read, how far grey should bleed)
rather than a modeling input.

**The Balcony & City, drained**
> Cinematic concept render of KAYOS: The Night of Silence at the moment the Song is silenced. The same Astra'Thalas festival balcony and city terraces as the lit version, but every warm gold has gone dead and ashen, color bled to flat grey, the sun-mosaic and gilded trim now dull and lightless, festival star-lamps gone dark. No warm light anywhere — flat, sourceless, cold illumination only. Painterly, high detail, no text, no watermark. Same three-quarter balcony-and-city view as the lit version, but at the instant of the draining, panic beginning to show in small distant crowd motion below.

**The Tower of Celestial Harmony, drained**
> Cinematic concept render of KAYOS: The Night of Silence at the moment the Song is silenced. The same Tower of Celestial Harmony as the lit version, but its once-brilliant apex has gone dark and dead, gold surfaces drained to ash-grey, the tiered galleries unlit, only a faint cold outline visible against a sky that is losing its stars too. Painterly, high detail, no text, no watermark. Full-height three-quarter view matching the lit version's framing, the tower reading as a cold dead silhouette instead of a glowing beacon.

---

## TILEABLE TEXTURES

**Night Sky / Skybox**
> Seamless tileable equirectangular texture reference for KAYOS: The Night of Silence, flat orthographic reference with no vignette, no lens effects, no text, no watermark, full 360-degree seamless wrap, high resolution. A deep indigo-to-warm-gold solstice dusk sky gradient near the horizon, fading upward to a star-scattered deep indigo-black zenith, faint delicate silver constellation lines scattered across the upper sky, no clouds, no sun disc visible.

**White Marble City Masonry**
> Seamless tileable PBR material swatch for KAYOS: The Night of Silence, flat-lit top-down texture reference with no perspective distortion, no shadows, no vignette, no text, no watermark, high resolution, seamlessly tiling edges. Warm-toned white marble city masonry with fine natural veining, subtly weathered block edges, faint gold-leaf inlay seams running between blocks.

**Antique Gold & Honey-Lacquer Trim**
> Seamless tileable PBR material swatch for KAYOS: The Night of Silence, flat-lit top-down texture reference with no perspective distortion, no shadows, no vignette, no text, no watermark, high resolution, seamlessly tiling edges. Polished antique gold leaf trim over honey-lacquered wood: a warm reflective gold surface with fine hammered detail on one portion, transitioning to smooth amber-lacquered wood grain on the other.
