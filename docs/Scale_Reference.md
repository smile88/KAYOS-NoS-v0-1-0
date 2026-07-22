# KAYOS — Scale & Units Reference

The single source of truth for **how big things are** in the 3D game. Every zone (Cold Open, Starfall,
Umbraveil, …) is built to these numbers so a doorway in one place is the same size as a doorway in
another, and so the player's body reads consistently everywhere. When something "feels wrong-sized,"
check it against this file first.

---

## The golden rule

> **1 Godot unit = 1 metre.** Always. We never rescale the unit; if a thing feels too small we make it
> bigger *in metres*, not by fudging scale factors.

- Ground is the **XZ plane**, **Y is up**, **+Z is "front"** (the establishing camera looks out over −Z,
  or for a ring city, inward toward the centre from the +Z spawn).
- Godot's default gravity is 9.8 m/s²; our player uses a snappier **26 m/s²** so jumps feel game-y, not
  moon-like. That's a deliberate gameplay choice, not a scale change.

---

## The human yardstick (measure everything against the player)

| Thing | Size (m) | Notes |
|---|---:|---|
| **Player capsule height** | **1.4** | eye height ~1.6 m. This is THE ruler. |
| Player shoulder width | ~0.6 | capsule radius 0.3 |
| Walk speed | ~4–5 m/s | brisk walk / jog |
| Run speed (hold Shift) | ~8–9 m/s | for crossing big zones |
| Jump height | ~1.2 m | clears a low wall, not a storey |
| Comfortable doorway | **2.2 h × 1.4 w** | a person walks through without ducking |
| One storey (floor to floor) | **3.5** | window band sits ~1.0–2.5 m up each storey |
| Head-clearance corridor | 2.6 h | |

If a building is only as tall as ~2× the player it is a **shed**, not a building. A real building the
player could live in is **at least 3 storeys ≈ 10 m** tall.

---

## Buildings (greybox massing)

| Class | Footprint (m) | Height (m) | Storeys | Use |
|---|---|---:|---:|---|
| Cottage / stall | 8 × 8 | 8–10 | 2–3 | edge-of-town, market |
| **Townhouse (default)** | **12 × 10** | **12–16** | 3–4 | the standard city block unit |
| Tenement / hall | 16 × 14 | 18–24 | 5–7 | dense quarters |
| Civic / temple | 24 × 20 | 24–40 | — | landmarks within a district |
| **Grand monument** | 30 m+ | **60–120** | — | the one thing that dominates a skyline |

**Doorways are cut into every building** at 2.2 × 1.4 m so it reads as enterable (interiors are a later
pass — massing first). Window bands mark storeys every 3.5 m.

---

## Terraces, stairs & traversal

| Thing | Size (m) | Notes |
|---|---|---|
| Terrace level rise | **8–12** | a monumental retaining wall, ~2–3 storeys — you feel the descent |
| Grand stair rise per flight | = one terrace (8–12) | |
| Stair run (horizontal) | ~2× the rise | keeps the slope ~26° — climbable & grand |
| Step riser (greybox) | 0.6–0.8 | chunky monumental steps read well at distance |
| Step tread | 1.2–1.6 | |
| Grand avenue / processional width | 16–28 | a procession abreast |
| Normal street width | 6–10 | |
| Plaza | 30–60 across | |

**How stairs actually work (important):** Godot's `CharacterBody3D` does **not** auto-climb stepped
geometry. So every stair is **visible stepped boxes (no collision) sitting over a hidden smooth ramp
collider** at ~26°. The player walks the invisible ramp; their feet appear to be on the steps. Same
trick for terraces linked by grand staircases. See `Zone3D._ramp` and `StarfallCity3D._stair`.

---

## Starfall, to scale (the caldera)

A real volcanic caldera is **kilometres** across; we build a **~900 m** playable rim — a grand capital
that takes a few minutes to cross, not a plaza. From centre outward:

| Ring | Radius (m) | Top height Y (m) | What |
|---|---|---:|---|
| Academy island | 0 – 75 | +2 | the hero observatory (~110 m tall) + wings + vault |
| The Mirror (star-lake) | 75 – 210 | −1 | the void that shows sky; causeway crosses it |
| Shore | 210 – 225 | 0 | basalt strand, armillary monument plaza |
| Canal quarter (L4) | 225 – 285 | +12 | densest housing, canals |
| Terrace L3 | 285 – 340 | +23 | |
| Terrace L2 | 340 – 395 | +34 | crystal-comb ring on its lip |
| Rim walk (L1) | 395 – 450 | +45 | the Nine Towers (~60 m each), parapet, player spawn |

**Diameter ≈ 900 m. Rim-to-lake vertical drop ≈ 46 m** (four grand staircases of ~11 m each).
The central observatory apex at ~+112 m stands **~67 m above the rim** — visible from everywhere.
These numbers are mirrored exactly in `tools/gen_starfall_blueprint.py` and built by
`godot/threed/StarfallCity3D.gd`; change one, change all three.

---

## Cold Open balcony (for cross-checking)

The Astra'Thalas balcony platform is ~**18 × 11 m** and its Tower ~**30 m** tall. Starfall's central
observatory is ~110 m — i.e. the balcony scene is one modest ledge on a structure ~4× that Tower's
height. That is the gut-check the user gave: *"if the balcony were on the outside of the observatory,
it should look that large."* The observatory is built big enough for exactly that.

---

## Quick sanity checks before shipping a zone

1. Stand the player next to a building — is it **≥ 3× their height**? If not, it's a shed.
2. Is there a **2.2 m doorway**? Could a person walk in?
3. Does crossing the zone take a **believable amount of time** (not 3 seconds)?
4. Do stairs have a **hidden ramp collider** (or the player will stick)?
5. Terrace drops **≥ 8 m** so the level change reads as monumental, not a kerb.
