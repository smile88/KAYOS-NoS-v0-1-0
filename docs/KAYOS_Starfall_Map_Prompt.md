# Nano Banana 2 — Starfall City Map
### Asset: **EN-017 · "The Starfall Plate"** (add to Asset Bible, Environment, P2)
**Concept:** an in-world Noctari cartographic artifact — the city drawn as an astronomical plate, because that is how this city thinks. Doubles as production reference and as a usable in-game/UI asset.
**Deliver:** 1:1 square, high resolution. NOT pixel art (deliberate register shift, same as the story panels).

---

## THE PROMPT (copy the whole block)

A highly detailed fantasy city map rendered as an antique astronomical chart plate, viewed from directly overhead in strict orthographic top-down projection. Square 1:1 composition, circular subject centred in the frame.

**Subject:** the city of Starfall, built inside a circular volcanic caldera high above the clouds — a perfect ring of terraced stone stepping down toward a still black lake at the centre.

**Style:** the aesthetic of a 17th-century celestial atlas plate crossed with an architectural survey drawing. Precise silver-white line work on a deep indigo-black ground, as if engraved and printed in silver ink on dark blue plate. Fine hatching and stippling for elevation. Antique gold used sparingly, only for the most important marks. Elegant, cold, scholarly, obsessively precise. Crisp linework — no painterly brushwork, no soft blur, no glow effects.

**Structure, from the outside edge inward — draw all of these concentric bands:**

1. **Beyond the rim:** a band of dense soft stippling representing an endless flat sea of cloud far below the crater, with a faint horizon suggestion. The city floats above weather.
2. **The outer slopes:** contour hatching on the crater's exterior flank, with a single long switchback stair — a zigzag line — descending from the rim edge and running off the plate. Label it as a stair.
3. **The rim:** a strong circular line crowned with **nine domed observatory towers**, evenly spaced around the ring, each drawn in tiny precise architectural elevation and marked with its own small heraldic sigil in antique gold — an astronomical-catalogue style marker. **One of the nine domes is drawn in dark solid ink, struck through with a single fine line, and has no sigil** — a dead House, deliberately unmarked.
4. **The crystal combs:** a narrow ring of fine angled blade shapes in honeycomb frames just inside the rim, drawn as dense geometric hatching — like a ring of frozen grey flame.
5. **The upper terraces:** three or four concentric contour rings of stepped terraced housing, sparse, with elegant fine radial lines drawn from each dwelling toward the central lake — protected sightlines, rendered as surveyor's ray-lines.
6. **The lower terraces and canal quarter:** denser concentric rings packed with small building footprints, threaded by three curving canal channels drawn as double parallel lines running down toward the lake and back, crossed by small arched footbridges.
7. **The shore:** a black basalt strand ring.
8. **The Mirror:** the caldera lake at the exact centre, occupying roughly a third of the circle — and here the plate does something unusual: **the lake is not drawn as water. It is drawn as sky.** Its disc is filled with an accurate, dense star field with faint constellation lines, as though the map has a hole in it showing the heavens. This is the map's central conceit and its most striking feature.
9. **The Causeway:** a single narrow stone road, no railings, running straight across the star-filled lake from the shore to the island.
10. **The Academy island:** a small island at the dead centre of the star-lake, drawn in the highest detail of anything on the plate — slender towers, a great central observatory dome, a moon-bridge arc between two wings, courtyards, and one heavily marked warded structure. Ringed with a fine gold circle.

**Marginalia — fill the four corners outside the circle:**
- An ephemeris table of neat columns and numerals.
- Small geometric diagrams of sightline angles and reflection optics.
- A scale bar.
- A compass rose designed as a star-rose — pointing not to north but to fixed stars.
- Fine ornamental filigree corners in antique gold.

**Palette (strict):** deep indigo-black ground; silver-white line work; antique gold accents only on the nine sigils, the island ring, and the corner filigree. No other colours. No warm light anywhere.

**Mood:** the beautiful, chilly precision of people who measure the heavens for a living and would find a hand-drawn line embarrassing.

**Critical:** clean engraved linework, no anti-aliased glow, no lens flares, no modern typography. Any lettering should be sparse and calligraphic. Do not add a border frame beyond the corner filigree.

---

## PRACTICAL NOTES

**1. Text will come out as gibberish.** Image models cannot render readable words — the labels, the ephemeris table, and the compass will all be convincing-looking nonsense. Two options, and I recommend the second:
- Accept it as "unreadable elven script" (works surprisingly well in-fiction).
- **Generate it deliberately label-free, then set real type in Affinity's Vector studio** over the top. Add `no text, no lettering, no labels, no numerals — leave label areas blank` to the prompt, then place your own labels as vector text. This gives you a genuinely usable asset, keeps the type crisp at any size, and lets you make a localised or spoiler-free version later. This is exactly the kind of job Affinity is better at than any pixel tool.

**2. The star-lake is the shot.** If a generation gets everything else right but draws the lake as ordinary water, regenerate. That single inversion — a map with a hole in it showing the sky — is what makes this asset worth having.

**3. Ask for the rings explicitly if it drifts.** Models tend to flatten concentric structure into a generic town. If that happens, add: `strictly concentric ring city, perfect circular caldera, bullseye composition, no irregular sprawl`.

**4. Keep the winner as a style anchor** for every later KAYOS map (Astra'Thalas, the Ashpile, the world map). One plate style across the franchise = instant coherence.

---

## BONUS VARIANT — worth generating second

**"The Other Map."** The official plate above **omits the Under-Terraces entirely** — the service rings, the barge locks, the conduit galleries, the bunk-halls. Not by conspiracy. The cartographers simply did not consider them part of the city. That omission *is* the theme of Part One, sitting in plain sight on a beautiful object.

So generate a second, opposite artifact: the same city as drawn by someone who lives underneath it.

> A crude hand-drawn map on the back of a stained ration ledger page, charcoal and thumb-smudge on cheap fibrous paper. Rough concentric rings barely resembling the elegant original. The lake is a flat scribbled void — no stars, it is just a thing you skim. The observatory domes are unmarked and irrelevant. What IS drawn in obsessive, confident detail: the service tunnels, ladders, conduit runs, barge locks, bunk galleries, the canteen, the foot of the long stair, and the shortest route between them. Tally marks in one corner. Warm dim lamp light, ash-grey and rust palette, no silver, no gold. The handwriting is small, practical, and utterly certain.

Two maps of the same city, neither of which contains the other. Put them side by side in the Legacy Ledger and you don't need a single line of dialogue to explain Part One.
