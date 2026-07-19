# Cold Open (HD-2D 3D) — playtest briefing

This is the **3D twin** of the Cold Open. Same scene, same night, same beats, same writing, same
clock, same one choice — only the *presentation* changed: the characters and props are the existing
low-poly 3D models in a real 3D world (billboards were tried then retired), and the
camera orbits freely. For everything about **what the scene is trying to do** — the four beats, why
nothing is gated, the complicity question, the clock — read `Cold_Open_Briefing.md` first; all of it
still holds. This doc only covers what's different because it's 3D.

**Run it:** open `godot/` in Godot 4.7 and hit play. `run/main_scene` now points at
`res://threed/ColdOpen3D.tscn`, so play drops you **straight onto the balcony** — no Title screen
(the 2D Title still exists at `res://scenes/Title.tscn` if you want it back; this is a prototype
entry point). ~3 minutes if you touch nothing, 10–15 if you read everything.

---

## Controls (this is the new part)

| | |
|---|---|
| **WASD** | walk (relative to the camera — "up" is always into the screen) |
| **Right-drag** | orbit the camera around Talindir, and tilt up/down |
| **Q / E** | orbit left / right from the keyboard |
| **Mouse wheel** | zoom in / out |
| **Hold Alt** | free-look — swing the camera around *without* changing where WASD walks; release and it swings back behind you |
| **V** | toggle first-person (Daggerfall-style: mouselook, your own body hides). Great for looking up the full Tower to its lit apex |
| **F** or **Space** | examine the nearest object / talk |
| **F** on the near-left stair | go down to the scriptorium (and the stair back up down there) |

The camera is the thing to judge here. It can look almost straight up (to see the Tower) and drop
near-horizontal; it pulls itself in past walls so it doesn't clip. Movement and the sprite's facing
row (down/up/left/right) stay correct at any orbit angle.

---

## What to judge (3D-specific — the reason this fork exists)

1. **Does the 3D actually feel more immersive than the 2D tableau, or just busier?** That's the whole
   question the pivot is testing. Be honest if the fixed 2D framing read better.
2. **The orbit camera.** Does swinging it around the balcony add anything, or is it fiddly? Is the
   default third-person distance/pitch right for reading the scene?
3. **First-person (V).** Does standing at the rail in first person and looking up at the Tower land?
   It's the one shot 2D could never do.
4. **The room change.** Descending to the scriptorium fades, drops you in, and re-aims the camera.
   Does it read as "a room below," or as teleporting?
5. **The Silence tableau.** The crowd freezes and rushes the rail as gold silhouettes while Talindir
   stays put on the sun-mosaic and the city drains to dark district by district. This is meant to be
   the best image in the build. Orbit around it — does it hold up from multiple angles?

---

## Known gaps specific to the 3D build

- **The world is primitive placeholder geometry** — boxes, cylinders, planes with generated textures.
  Characters (`CharacterModel3D`) and props (`PropModels3D`) are low-poly primitive placeholders.
- **Rooms have no ceiling and an open front.** Deliberate: a closed box fights a 360° orbit camera.
  So the scriptorium (an interior) currently has stars overhead. It reads fine but isn't "right."
- **Everything is low-poly placeholder 3D** — primitive models, not final art. Real modelled/rigged
  characters and props drop in over these.
- **The character model is a single hooded silhouette** in varied robe colours; real per-character
  models would give the crowd more variety.
- **Nothing has real collision** beyond the ground — you walk through desks, shelves and NPCs, same
  as the 2D build.
- **No pathing.** The festival-goer walks to you in a straight line; the crowd drifts dumbly.
- **The whole crowd shares one silhouette** (the CH-027 citizen sheet), same as 2D — real variants
  drop in later.
- **No audio.** The Song stopping is still silence-by-absence.

---

## Where the code lives

Everything 3D is under `godot/threed/`, built procedurally (no hand-placed scenes):

- `ColdOpen3D.gd` / `.tscn` — the director + the full scene. Port of `scenes/zones/ColdOpen.gd`.
- `Balcony3D.gd`, `Scriptorium3D.gd` — the two rooms, built in `_ready()`.
- `Player3D`, `NPC3D`, `Wanderer3D`, `Interactable3D`, `RoomStair3D` — the actors.
- `CharacterModel3D`, `PropModels3D` — the low-poly character and prop models.
- `CameraRig3D.gd` — the orbit / free-look / first-person camera.
- `RoomCoordinator3D.gd` — the mechanical room change the director drives.

The clock/beat/approach numbers are consts at the top of `ColdOpen3D.gd` — retune freely. Headless
proof of the whole night (nothing gated → handoff to Starfall) is `tests/ColdOpen3DTest.gd`.
