# KAYOS — The HD-2D 3D Pivot Plan

> **⚑ UPDATE (2026-07-19, after Phase 4): billboards were retired in favour of true low-poly 3D
> models.** The plan below was written for HD-2D *billboards* (2D sprites facing the camera). In
> practice they fought the free-orbit + first-person camera (flat cards turning to look at you,
> quantised diagonal walk), so characters became `CharacterModel3D` and props became `PropModels3D` —
> real low-poly 3D models. Wherever this doc says "billboard" / "SpriteSheet" / "the 48×72 sheets carry
> over", read that as superseded: the character/prop pipeline is now 3D modelling. The camera, zones,
> director, and everything else stand. Phases 5–6 (docs/asset reframing) should reflect models, not sprites.

**Decision (2026-07-19):** KAYOS moves from top-down 2D to the **HD-2D isometric-3D** approach
prototyped on branch `cold-open-3d` — a real 3D world with billboard (Octopath-style) characters,
an orbiting camera, and optional first-person view. The 2D presentation is retired. This document is
the plan to make that the mainline across code, assets, docs, and tests.

Why now is the cheap moment: **almost no game content exists yet.** Only the Cold Open is built. The
whole 2D→3D cost is a presentation-layer swap plus one vertical slice re-cut — not a rewrite of the
game. Every additional zone we'd build in 2D first would multiply that cost, so pivoting before
Starfall (Phase 2.6) is the correct call.

---

## 1. What we keep vs. replace

**Keep, unchanged (presentation-agnostic core):**
- Autoloads: `GameState`, `DialogueManager`, `SceneManager`.
- All dialogue JSON in `godot/data/dialogue/`.
- `CharacterData` resources (`.tres`) and the character/portrait/dialogue data model.
- `SpriteSheet` (48×72-frame, 192×288, 4×4 walk sheets) — **billboards consume the exact same sheets**,
  so all character art carries over verbatim.
- `DialogueUI` (a CanvasLayer — renders over 3D untouched).
- The writing: every examine string, every dialogue, the beat/clock design, the Silence.

**Replace (the presentation layer):**
- `godot/scenes/zones/*.tscn` (2D `Node2D` zones) → 3D scenes built the `Balcony3D.gd` way
  (procedural primitive-mesh environments + billboard actors).
- `godot/actors/Player.tscn`+`Player.gd`, `NPC.tscn`+`NPC.gd`, `Wanderer.gd`, `Interactable.gd`,
  `RoomStair.gd` → their `threed/` twins (`Player3D`, `NPC3D`, `Wanderer3D`, `Interactable3D`,
  `RoomStair3D`), which already mirror the 2D APIs.
- `Camera2D` per-zone limits → `CameraRig3D` (orbit / free-look / first-person).
- The 2D render-target spec (960×540 native, "never zoom the camera out") — that rule was a 2D-pixel
  constraint and no longer applies. **The sprite *format* stays; the *framing* rules change.**

**Retire (archived, not deleted — see §6):** `godot/scenes/`, `godot/actors/`, the 2D `tests/` that
target them.

---

## 2. Phase 0 — unblock the feel-test  ✅ DONE (commit 0f82ad7)
- Fixed A/D inversion (`CameraRig3D.right_xz()` was screen-left).
- Fixed the examine freeze (added `DialogueUI` to `Balcony3D.tscn`).

---

## 3. Phase 1 — Camera & controls overhaul (the three asks)  ✅ DONE (commit dfefbd4)

Delivered exactly as specced below: `Mode` enum (ORBIT/FIRST_PERSON), pitch 6–85° + manual
spring-arm ray + `floor_min_y` guard, free-look via a split `move_yaw`/camera yaw (hold `Alt`),
first-person toggle (`V`) that captures the mouse, moves look-relative, and hides the player billboard.
`forward_xz()`/`right_xz()` return the movement frame (never the free-look offset). Verified headless +
rendered (low orbit with the Tower up-frame, first-person looking up to the lit apex).


The single `CameraRig3D` grows three modes plus a floor guard. Keep it one node so the player script
reads one `camera_rig` group regardless of mode.

**A. Orbit (default — the iso 3rd-person we have).** Keep. Movement stays camera-relative.

**B. Wider pitch + no floor-clip.** So you can drop the camera low and look *up* at the Tower apex:
- Extend the pitch clamp from `20–75°` to about `6–85°` (6° ≈ near-horizontal, angling up at the
  skyline; 85° ≈ near-top-down).
- Stop the camera dipping through the floor/props: give it a `SpringArm3D` (or a ray from target to
  desired position) that pulls the camera in when it would cross geometry, plus a hard `y ≥ 0.3 m`
  floor. This kills the "clipping through the floor is tacky" problem in every mode.

**C. Free-look sub-mode (3rd person).** Look around **without** changing where the character walks or
faces. Implement by splitting yaw in two: a **movement yaw** (the frame WASD is relative to) and a
**camera yaw**. Normal orbit rotates both together; free-look (hold a key, e.g. `Alt`, or a toggle)
rotates only the camera yaw, so you can survey the scene and release back to your walking frame. The
player's facing is driven by movement, so it stays put while you look.

**D. First-person toggle (Daggerfall-esque).** A key (proposed `V`) swaps between orbit and FP:
- Camera moves to the player's eye (~1.6 m), mouse does full yaw+pitch free-look, WASD moves in the
  look direction, wheel does nothing (or FOV).
- Hide the player's own billboard in FP; NPC/prop billboards still face the camera and read fine.
- Interaction uses a forward ray (look-at-and-press) in addition to the proximity scan.
- No floor-clip risk — you're inside the world.

**Proposed control scheme (document in the briefing):**
| Action | Orbit / 3rd person | First person |
|---|---|---|
| Move | WASD (camera-relative) | WASD (look-relative) |
| Look | right-drag / Q,E | mouse |
| Free-look | hold Alt (camera only) | (always free) |
| Zoom | wheel | — (FOV optional) |
| Examine | F / Space | F / Space (+ look ray) |
| Toggle view | V | V |

Deliverables: `CameraRig3D` refactor (modes as an enum + `SpringArm3D`), player script honours the
movement-yaw split and hides its billboard in FP, input map gains `free_look` (Alt) and `toggle_view`
(V). Verify by render from a low angle (Tower apex visible), and a headless check that movement yaw
stays fixed while camera yaw changes in free-look.

---

## 4. Phase 2 — finish the Cold Open vertical slice in 3D (proves the pattern)

Continue the existing A–H build order (see the `kayos-cold-open-3d-branch` memory):
- **F. Scriptorium room + stair transition.** Second room as an offset `Node3D` area (balcony y≈0,
  scriptorium y≈−40); the director repositions the player + retargets the rig on stair use. Port its
  ~14 examinables (verbatim text in `scenes/zones/AstraThalasBalcony.tscn`) as `Interactable3D`, and a
  `RoomStair3D`.
- **G. Director `ColdOpen3D.gd`** — port `scenes/zones/ColdOpen.gd`: beats at t=7/26/88/150,
  festival-goer approach at 55 s, the Silence at 190 s (crowd `freeze()`+`rush_to()` the rail,
  Talindir does **not** rush), city drain, `coldopen_silence.json`, VS-001 panel, hand-off to Starfall.
  Clock pauses during dialogue and room changes. Update the on-screen control prompt to the 3D scheme.
- **H. Wire-up** — set `run/main_scene` to the 3D Cold Open, headless smoke test, rewrite the briefing.

This is the acceptance test for the whole pivot: when the Cold Open plays end-to-end in 3D with parity
to the 2D version, the presentation layer is proven and Starfall gets built 3D-native.

---

## 5. Phase 3 — reusable 3D kit (so new zones are cheap)  ✅ DONE (2026-07-19)

Done: `threed/Zone3D.gd` base (the env toolkit `Balcony3D`/`Scriptorium3D` had duplicated — `_tex`/
`_mat`/`_box`/`ART`/`PLACE`/`drain_to_dark`), both zones reparented onto it, and `docs/Building_a_3D_Zone.md`
(conventions + building blocks + worked example + verify discipline). The `Zone3D` base rename to a
`game/` location (§6.4) is still deferred. Original scope:
- `Zone3D` base (env builder conventions: 1 unit = 1 m, +Z toward default camera, procedural
  primitive meshes + generated textures, billboard actors from `SpriteSheet`).
- `Interactable3D` / `NPC3D` / `Wanderer3D` / `RoomStair3D` / `Player3D` / `CameraRig3D` as the
  documented building blocks (they already mirror the 2D APIs).
- A short "how to build a zone" doc so Starfall/Umbraveil follow one pattern.

---

## 6. Phase 4 — make 3D the mainline, archive 2D  ✅ DONE (2026-07-19)

Done as the hard pivot: 2D tagged `v0-2d-archive`; `cold-open-3d` merged to `master` (merge 0a3fdb7);
the 2D Cold Open (`AstraThalasBalcony.tscn`, `ColdOpen.gd`, `ColdOpenTest`) removed (6962114) and
`Title` New Game repointed to `threed/ColdOpen3D.tscn`; `run/main_scene` already on the 3D scene.
**Exception to the literal §6.3:** `godot/actors/` and `scenes/zones/StarfallAcademy.tscn` were **kept**,
not removed — the 3D Cold Open still hands off to the 2D Starfall zone, which isn't ported yet and
still uses the 2D actors. They retire when Starfall goes 3D-native. `threed/` is still at `threed/`
(the §6.4 promotion to `game/` is deferred, not blocking).

Original recommended (reversible) sequence:
1. Tag the current 2D state: `git tag v0-2d-archive` on `master` (nothing is ever lost).
2. Land the Cold Open 3D slice on `cold-open-3d`; get it playing end-to-end.
3. Merge `cold-open-3d` → `master` as the new mainline; **remove** `godot/scenes/`, `godot/actors/`,
   and the 2D-only tests from mainline (they live on the tag).
4. Promote `godot/threed/` to a first-class location (e.g. `godot/game/` or keep `threed/` but rename
   conceptually to "the game"). Fix `run/main_scene`.

> **Decision to confirm:** this is the "leave the old way behind" hard pivot, made safe by the archive
> tag. If you'd rather keep the 2D scenes in-tree as living reference for a while, say so and I'll do
> the soft version instead.

---

## 7. Phase 5 — docs & specs rewrite

Docs that must change (in `docs/`):
- **`GDD.md`** — §13 (presentation/rendering), §8/§10 (interaction) rewritten for HD-2D 3D; camera &
  view modes added.
- **Render-target spec** (the `kayos-hd2d-render-target` memory + wherever §13 states 960×540) —
  replace the 2D native-res / no-zoom rules with the 3D conventions; **keep** the 48×72 / 192×288 sheet
  format (billboards use it).
- **`Cold_Open_Briefing.md`** — new controls (the §3 table), the view-toggle, the orbit.
- **`Implementation_Plan.md`** — reflect the pivot and the new zone recipe.
- **`Design_Prompt_VerticalSlice.md`**, **map prompts** (`KAYOS_Starfall_Map_Prompt.md`,
  `KAYOS_Umbraveil_Map_Prompt.md`) — reframed as 3D environment briefs (primitive-mesh layouts +
  textures) rather than 2D tilemaps.
- **`Asset_Bible.xlsx`** — note which asset classes change (see §8).
- **`KAYOS_ClaudeCode_Spec_Reconciliation.md`** — record the pivot as the new source of truth and the
  date, so future "spec vs code" drift is judged against 3D (see the doc-drift caution in memory).

---

## 8. Phase 6 — asset implications

- **Character sheets:** unchanged. 48×72 walk sheets stand up as billboards directly. All existing
  CH-*/PO-* art carries over. (The crowd still shares one silhouette until CH-027 variants land — same
  as 2D.)
- **Prop art:** the existing prop PNGs work as billboards. Some (rail, mosaic) became environment
  geometry instead — fine.
- **Environment art:** shifts from 2D backdrops (EN-006 balcony, EN-016 city) to **tiling textures for
  primitive meshes** (`tools/gen_3d_textures.py` already makes the starter set: marble, stone,
  scriptorium, city windows, star dome). Map prompts become "texture + massing" briefs.
- **New, optional:** a proper skybox, a few hero meshes later (the Tower) if we outgrow primitives.
- **Not needed:** FP hand/weapon art for this game's loop; tilemaps.

---

## 9. Testing discipline (unchanged philosophy)

- Headless logic tests for anything with math or state (movement frame, walk-row, interaction reach,
  director clock/beats). **Mutation-test them** — break the code and confirm the right test goes red.
  *(Lesson from this session: the walk-row test passed while A/D were mirrored, because movement and
  facing shared the flipped vector. Add a test that asserts world-space motion sign for a given key,
  not just self-consistency.)*
- Render checks for anything visual — they catch what code review can't (blown-out city, feet through
  floor, camera clipping).
- Keep the Cold Open parity suite: the 3D director should satisfy the same beats/flags the 2D one did.

---

## 10. Sequencing summary

| Phase | What | Gate |
|---|---|---|
| 0 ✅ | A/D + freeze fixes | playtest works |
| 1 ✅ | Camera: pitch+floor guard, free-look, first-person, controls | look up at Tower; FP toggles; free-look decouples |
| 2 ✅ | Finish Cold Open 3D (F, G, H) | plays end-to-end, parity with 2D |
| 3 ✅ | Harden the `threed/` zone kit | documented recipe (`Zone3D` + `docs/Building_a_3D_Zone.md`) |
| 4 ✅ | Tag 2D, merge to mainline, remove 2D presentation | `master` is 3D |
| 5 | Rewrite GDD/specs/briefings | docs match code |
| 6 | Asset reframing | map prompts are 3D briefs |

**Open decisions:** (a) hard vs soft retirement of the 2D scenes (§6 — default: hard, archived by
tag); (b) first-person toggle key `V` and free-look modifier `Alt` (proposed; easy to change).

Recommended next action: **Phase 1** (camera & controls) — it's the rest of the "feel" you asked to
judge, and it's independent of the room/director content.
