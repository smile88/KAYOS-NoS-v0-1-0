# Cold Open — playtest briefing

Read this before you play. It tells you what the scene is trying to do, so you can judge whether it
does it rather than guessing what you're looking at.

**Run it:** open `godot/` in Godot 4.7 and hit play. Title screen → **New Game**. (Continue is
greyed out until a save exists.) About 3 minutes if you touch nothing, 10–15 if you read everything
— which is the point, see *The clock* below.

**Two rooms.** The balcony, and the scriptorium below it — take the stair at the bottom-left. Both
are dense; the scriptorium is where Talindir actually lives.

**Who you are** is now established in the first few seconds rather than left as a puzzle: Talindir,
sixty years a scribe of the Astral Archive below, who has watched sixty Luminarae from this balcony
and never once gone down to one. Mystery about the *Silence* is the design (GDD §4.1). Confusion
about your own name never was — that was a bug.

---

## What you're about to play

Astra'Thalas, 2000 AO, the winter solstice — the two-thousandth Luminarae. You are **Talindir**, an
elven apprentice-scribe, now old, alone on a high balcony above the biggest festival the city has
ever thrown. You have a letter in your satchel. It is three hundred years old. It is from Elorin.
You have never opened it, and she told you that you would know the night.

You do. That's the whole scene: a man who knows, watching a city that doesn't.

Four beats, per GDD §4.1:

1. **You walk.** A control prompt fades and leaves you alone on the balcony.
2. **You look at things, and talk to people** — or don't. Thirty-five objects across two rooms and
   eight NPCs on the balcony, all optional.
3. **The festival-goer comes to you** and asks why you look afraid. This is the one real choice:
   tell the truth, or deflect. It sets `COLDOPEN_HONEST`, which echoes all the way to the Coda.
4. **The lights go out.** District by district — not blown out, *silenced*. The Song stops. You do
   not run. You sit down among the fallen garlands and open your ledger, because observation is the
   only thing you have ever done well enough for it to constitute protection. Title card. Starfall.

You are not supposed to understand what you just saw. You'll understand it twice: once as Elorin,
once as Grakkar.

---

## What is deliberately *not* here

The previous build had a HUD line reading `examine: the banner, the telescope, your satchel (0/3)`,
and the scene would not advance until you'd ticked all three off. That's gone, and its absence is
the entire design of this pass:

- **Nothing is gated.** Not one object is required. You can reach the end having read nothing.
- **There is no counter, and no quest text.** The HUD line at the bottom is now Talindir's own
  interiority — it fades in, says something quiet, fades out. It never tells you what to do.
- **The Silence is not something you trigger.** It arrives on the festival's clock whether you
  explored or stood still. Talindir has known for three centuries and can do nothing; the scene
  would be lying if your diligence caused or delayed the catastrophe.
- **The one choice comes to you.** She walks over. She is not a marker you go and collect.
- **Most of the writing leads nowhere.** The initials cut under the rail, the two abandoned cups,
  the child's dropped mask — none of it is progress. That's GDD pillar 4 (*density over breadth*)
  and §8.4 (*examine-text carries ~30% of characterisation*). This is the Torment trick: the
  Mortuary is a small locked box, and it feels like freedom because everything in it rewards
  looking and nothing in it nags.

**On "it doesn't feel open":** it isn't, and shouldn't be. The Cold Open is a 10–15 minute prologue
on rails by design (GDD §4.1). It's now **two rooms**, each a fixed 1280×720 tableau — the whole
room is on screen at once and the camera is pinned to it, so it reads as a composed space rather
than a window sliding over a map. The Planescape-style *wander off and find your own way* freedom
belongs to **Starfall Act I** (Phase 2.6: Academy exterior, theory wings, containment halls). That's
the Mortuary. This is the slab you wake up on.

---

## The clock

The festival counts to the ninth bell, and the apex is when the Song stops.

| | |
|---|---|
| Festival-goer approaches | ~55s |
| The Silence | ~190s |
| Ambient interiority beats | ~26s, ~88s, ~150s |

**The clock only runs while you're not reading.** It pauses whenever a conversation is open or a
room change is running, so a slow reader is never interrupted mid-sentence and a thorough player
still gets the full 10–15 minutes. Someone who ignores everything waits out ~3 minutes. All the
numbers are consts at the top of `godot/scenes/zones/ColdOpen.gd` — retune freely, they're guesses
until you've played it.

**If you're downstairs when the bell rings, the bell does not wait.** The scriptorium lamps die,
and Talindir climbs. The night does not care where you were standing.

The broadsheet on the floor tells you the apex is timed to the ninth bell, and the beats count it
down in Talindir's voice. That's deliberate: you should feel it coming without a HUD ever saying so.

---

## What I'd like you to judge

1. **Does the dread build?** You should be uneasy before the lights go, not surprised when they do.
2. **Is 190s right?** It's the number I'm least sure of, and it now has to cover two rooms. Too
   long and you'll fidget; too short and the density is wasted.
3. **Does anything read as a chore?** If any object feels like a box to tick, I've failed.
4. **The complicity question.** The scene's real moral weight isn't honest-vs-deflect — it's that
   Talindir had the letter for three hundred years and let the city dance, and sits down to *write*
   rather than help. The stair, the ledger, and the mask are where I put pressure on that. Does it
   land, or is it too quiet?

---

## The crowd

The balcony has seven people on it besides you, drifting around on their own business, each with one
thing to say. None of them is a quest. They exist because it is the biggest festival in two thousand
years and a balcony with the best view of the Tower cannot contain two people.

They are also where the dramatic irony lives, so talk to them: the lamplighter who has never in his
life had anything to light and wishes tonight he did; the celebrant who tells you the Song is
eternal and offers it as comfort; the functionary repeating that archmages don't get nervous; the
woman looking for a boy in a gold mask — the mask you may already have found on the floor.

**Downstairs is deliberately empty, and that's the point.** The duty roster names everyone who should
be on watch and strikes every line through. Sorrel's note says *"back before the ninth — don't tell."*
They all went dancing. The archive is deserted because the city is celebrating, and that only lands
if the balcony above is heaving — which is why the crowd had to exist before the emptiness could mean
anything.

**When the Song stops, everyone stops.** Then they go to the rail, all of them, to look. Talindir
does not. He is the only person on that balcony still standing where he was, because he is the only
one who already knows.

---

## Placeholder art — what to swap

Every placeholder has its Asset Bible ID baked into the pixels, so the editor always shows you which
real asset replaces it. They're regenerated by `python3 tools/gen_placeholders.py`, so **don't clean
these up in Affinity** — they're scaffolding. Drop your finished art over them.

**To swap a character:** open its `.tres` in `godot/data/characters/`, drag the cleaned PNG into the
`sprite` slot. Every placed instance of that character updates at once. Same for `portrait`.
**To swap a prop:** select its node in the zone and drop the PNG on the `Body` node's Texture slot.
**Portraits** are indexed by ID — a file named `PO-005_*.png` in `godot/art/portraits/` automatically
overrides the `PO-005` placeholder. Just drop it in; no wiring.

In this scene: `CH-007` (Talindir), `CH-027` (festival-goer), `PO-005`/`PO-014` (portraits), `EN-006`
(balcony floor, balustrade, sun mosaic, rail carving), `EN-016` (city districts, **plus new**: the
star field, the far skyline, and the Tower), `PR-007` (scroll racks), `PR-008` (letter, ledger,
broadsheet, roster, Volume the First, seal kit), `PR-017` (star-lamps), `PR-020` (chest, the locked
cabinet), `PR-021` (banner, telescope, garlands, mask, cups), `PR-023` (stairs up and down),
`VS-001` (the lights-die story panel), `UI-013` (title card).

> **⚠ One new Asset Bible ID needs adding: `EN-019` — "Astra'Thalas — the scriptorium (Cold Open)".**
> The room below the stair is a new environment and there was no existing set for it (EN-006 is the
> capital *exterior*; EN-013 Archives and EN-014 Talindir's study are both other places in other
> parts). `EN-017` and `EN-018` are already spoken for by your two map-prompt docs, so this took the
> next free number. It covers the scriptorium floor, wall, window, desks and the cold cup. Everything
> else slots into existing sets and invented nothing.

---

## Things you should know I changed

- **The HD-2D pivot is implemented.** Native viewport is **960×540** (was 640×360), window
  1920×1080 — exactly 2×, and 4× to 4K, so integer scaling is clean. That's 2.25× the world area of
  the old build. The mechanism matters: raising native resolution shows more world *and* stays
  sharp, whereas zooming the camera out (`zoom = 0.4`, which a previous agent set) is a non-integer
  downscale that shreds nearest-neighbour art. Camera stays at 1.0, forever. Each Cold Open room is
  1280×720 of world, so the camera now pans a little within a room rather than showing it all at
  once.
- **Sprite scale: 48×72, restored.** I had "fixed" these down to the old smaller frame citing GDD §13 — that was my
  error. §13 was stale; your Affinity guide's 48×72 was the locked decision. GDD §13 has been
  rewritten to match reality and now says so loudly, so this can't bite again.
- **Placeholder palette.** The balcony floor was `(214,196,158)` — bright tan. It read as noon. It's
  night marble now, so the gold reads as the only light source.
- **One line of your prose.** The satchel said "Ink, nibs, the ledger — and beneath them…". I moved
  the ledger out into its own object on the balustrade (it's too good a character beat to bury in a
  list) and the satchel now says "Ink, nibs, blotting sand". Say the word and I'll put it back.

## Known gaps

- No audio. The Song stopping is the single most important sound in the game and it is currently
  silence-by-absence rather than silence-by-design.
- No pathing anywhere: the festival-goer walks to you in a straight line, and the crowd wanders
  through props and each other. Fine at this fidelity, won't survive real art.
- Everyone animates now (player and crowd) off 192×288 walk sheets, and the crowd is faction-tinted
  so they read as different people. But those bodies are procedural placeholders — robed hooded
  figures with an alternating-boot walk — not real art, and the whole crowd shares one CharacterData
  (`festivalgoer.tres`), so they're the same silhouette in different colours. Real CH-027 variants
  replace them by dropping sheets into their `.tres` files; nothing in the scene changes.
- The placeholder walk cycle is *better* than the cleaned CH-001 sheet, which is an accident: the
  generator alternates legs and Nano Banana didn't. When CH-001's legs get hand-animated, drop the
  Player's `step_bob` (it's compensation for that one sheet).
- NPC name labels are always on, which is gamey. Kept for now because you asked for orientation;
  worth revisiting once portraits and real sprites make people recognisable.
- Nothing has solid collision except the outer walls — you walk through shelves, desks and the
  telescope. Consistent with the old build, but the scriptorium's stacks make it obvious.
- The scriptorium's aisle shelves don't y-sort against the player, so you always draw in front of
  them even when you should be behind.
- No character creation yet (GDD §2.4) — New Game drops you straight into the Cold Open.
- The crowd below is six static sprites. "Nine thousand people move like one animal breathing" is
  currently doing a lot of work that the art isn't.
