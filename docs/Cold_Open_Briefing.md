# Cold Open — playtest briefing

Read this before you play. It tells you what the scene is trying to do, so you can judge whether it
does it rather than guessing what you're looking at.

**Run it:** open `godot/` in Godot 4.7 and hit play. Title screen → **New Game**. (Continue is
greyed out until a save exists.) About 3 minutes if you touch nothing, 10–15 if you read everything
— which is the point, see *The clock* below.

---

## What you're about to play

Astra'Thalas, 2000 AO, the winter solstice — the two-thousandth Luminarae. You are **Talindir**, an
elven apprentice-scribe, now old, alone on a high balcony above the biggest festival the city has
ever thrown. You have a letter in your satchel. It is three hundred years old. It is from Elorin.
You have never opened it, and she told you that you would know the night.

You do. That's the whole scene: a man who knows, watching a city that doesn't.

Four beats, per GDD §4.1:

1. **You walk.** A control prompt fades and leaves you alone on the balcony.
2. **You look at things** — or don't. Thirteen objects, all optional.
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
on rails by design (GDD §4.1) and it is one fixed 640×360 tableau — the whole balcony is on screen
at once, and the camera is pinned so it can't drift. The Planescape-style *wander off and find your
own way* freedom belongs to **Starfall Act I** (Phase 2.6: Academy exterior, theory wings,
containment halls). That's the Mortuary. This is the slab you wake up on.

---

## The clock

The festival counts to the ninth bell, and the apex is when the Song stops.

| | |
|---|---|
| Festival-goer approaches | ~42s |
| The Silence | ~145s |
| Ambient interiority beats | ~22s, ~68s, ~108s |

**The clock only runs while you're not reading.** It pauses whenever a conversation is open, so a
slow reader is never interrupted mid-sentence and a thorough player still gets the full 10–15
minutes. Someone who ignores everything waits out ~2.5 minutes. All four numbers are consts at the
top of `godot/scenes/zones/ColdOpen.gd` — retune freely, they're guesses until you've played it.

The broadsheet on the floor tells you the apex is timed to the ninth bell, and the beats count it
down in Talindir's voice. That's deliberate: you should feel it coming without a HUD ever saying so.

---

## What I'd like you to judge

1. **Does the dread build?** You should be uneasy before the lights go, not surprised when they do.
2. **Is 145s right?** It's the number I'm least sure of. Too long and you'll fidget; too short and
   the density is wasted.
3. **Does anything read as a chore?** If any object feels like a box to tick, I've failed.
4. **The complicity question.** The scene's real moral weight isn't honest-vs-deflect — it's that
   Talindir had the letter for three hundred years and let the city dance, and sits down to *write*
   rather than help. The stair, the ledger, and the mask are where I put pressure on that. Does it
   land, or is it too quiet?

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
(balcony floor, balustrade, sun mosaic, rail carving), `EN-016` (city districts), `PR-008` (letter,
ledger, broadsheet), `PR-017` (star-lamps), `PR-021` (banner, telescope, garlands, mask, cups),
`PR-023` (stair), `VS-001` (the lights-die story panel), `UI-013` (title card).

No new Asset Bible IDs were invented — the new props all slot into existing **sets** (PR-021 is
"festival solstice decorations", PR-008 is "documents set", and so on).

---

## Things you should know I changed

- **Sprite scale.** Placeholders were being generated at 48×72; GDD §13 says **32×48**. They're now
  32×48. Everything was 1.5× oversized, which made the screen feel cramped.
- **Camera zoom.** The player's camera had `zoom = 0.4` (zoomed *out* 2.5×). On a 640×360
  nearest-neighbour game that's a non-integer downscale — it shredded the pixel art. Back to 1:1.
  I think these two together are a real part of why it felt wrong: sprites came out too big, so the
  camera got zoomed out to compensate, and the result was both cramped *and* blurry.
- **Placeholder palette.** The balcony floor was `(214,196,158)` — bright tan. It read as noon. It's
  night marble now, so the gold reads as the only light source.
- **One line of your prose.** The satchel said "Ink, nibs, the ledger — and beneath them…". I moved
  the ledger out into its own object on the balustrade (it's too good a character beat to bury in a
  list) and the satchel now says "Ink, nibs, blotting sand". Say the word and I'll put it back.

## Known gaps

- No audio. The Song stopping is the single most important sound in the game and it is currently
  silence-by-absence rather than silence-by-design.
- The festival-goer walks to you in a straight line with no pathing. Fine on an empty balcony;
  won't survive a crowd.
- No character creation yet (GDD §2.4) — New Game drops you straight into the Cold Open.
- The crowd below is six static sprites. "Nine thousand people move like one animal breathing" is
  currently doing a lot of work that the art isn't.
