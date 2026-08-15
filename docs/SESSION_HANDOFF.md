# Session handoff — resume here

_Last updated: 2026-08-15. This note lives in the repo (unlike local memory, which does NOT
travel between machines) so a fresh session on another computer can pick up exactly where we left off._

## Latest session (2026-08-15) — Complete Act 1: Main Quests, 15 Side Quests, Quest Journal & NPC Population

1. **Complete Act 1 Main Quest Arc (Fully Implemented & Automated-Tested)**:
   - **MQ-01 (`mq01_corel_briefing.json`)**: Northreach debrief (778 dead, inverted planar tear), Conclave funding branch (`P1_FUNDING`: `LIE`, `TRUTH`, `HEDGE`), class checks (`harmonist`, `mender`, `voidweaver`), starting `mq01_containment_problem`.
   - **MQ-02 Assembly (4 Full Recruitment Storylines)**:
     - Vara the Human Arithmancer (`mq02_vara_recruitment.json`): Canal garret, intellectual credit dispute (`P1_VARA_CREDITED`).
     - Durak Ironthought (`mq02_durak_recruitment.json`): Under-Terraces deep geomancer, basin philosophy, emergency cutoff pact (`P1_DURAK_TRUST`).
     - Coil the Theorist (`mq02_coil_recruitment.json`): Scriptorium, negative mass calculations, dual-key constraint (`P1_COIL_LOYALTY`).
     - Sera the Solari Enchantress (`mq02_sera_recruitment.json`): Dawnspire Embassy, structural casing harmonics, court espionage test (`P1_WARD_SCHEME`).
   - **MQ-03 Prototype Test (`mq03_first_containment_test.json`)**: Live surge containment blowout, injured personnel, flaw concealment vs documentation, blame assignment report (`P1_FIRSTTEST_BLAME`).

2. **15 Fully Functioning Side Quests across All Starfall Wedges & Under-Terraces**:
   - `sq01_forged_ledger.json` (H0 Vael'Suran Scribes), `sq02_cracked_resonator.json` (H1 Serenthil), `sq03_sun_bleached_glass.json` (H2 Dawnspire), `sq04_severed_shadow.json` (H3 Gloom-Weavers), `sq05_bedrock_echoes.json` (H4 Iron-Keep), `sq06_house_divided.json` (H5 High-Arches), `sq07_silent_ward.json` (H6 Dead House), `sq08_smugglers_siphon.json` (H7 River-Gate), `sq09_seven_solstices.json` (H8 Starlight-Row), `sq10_unspoken_collar.json` (Under-Terraces), `sq11_heretics_thesis.json` (Academy Plaza), `sq12_whispering_pylon.json` (Academy Vault), `sq13_blind_diviner.json` (Sounding-Glass Inn), `sq14_golden_graft.json` (Upper Garden), `sq15_tide_of_shadows.json` (Causeway Shore).

3. **Master Quest Journal UI & Animated Notifications**:
   - `QuestLogUI.tscn` / `QuestLogUI.gd`: Two-pane twilight/gold chronicle ledger, category tabs ("All", "Main", "Side", "Completed"), stage progress checklists, rewards/legacy footprints, keyboard navigation (`J`, `Tab`, `ESC`, Arrows) and HUD toggle.
   - `QuestNotificationUI.tscn` / `QuestNotificationUI.gd`: Animated top banner for quest starts, updates, completions, and failure states with acoustic blips.

4. **3D World NPC Population & Visual Diversity**:
   - 20 interactive NPCs spawned across Starfall in `StarfallCity3D.gd` with linked CharacterData resources in `godot/data/characters/`.
   - `CharacterModel3D.gd` & `NPC3D.gd` equipped with racial presets (Noctari, Solari, Terran, Orc, Sylvari, Human) with unique robes, trims, skin tones, bodily scales, world-space floating nameplates, and amber-gold interaction prompt cues.

5. **Audio Engine, Typewriter Dialogue & Shaders**:
   - Procedural 16-bit PCM voice synthesizer with character-specific pitch blips in `AudioManager.gd`.
   - Typewriter text reveal in `DialogueUI.gd`.
   - Celestial void shader `star_lake_mirror.gdshader` and catastrophe post-process `silence_wave.gdshader`.

6. **Master Automated Test Battery (222 / 222 Passing Assertions - 100% Green)**:
   - `QuestSystemsTest.tscn` (40/40), `Act1QuestsTest.tscn` (116/116), `StarfallTest.tscn` (21/21), `ColdOpen3DTest.tscn` (23/23), `DialogueSystemsTest.tscn` (17/17), `InteractionTest.tscn` (5/5).

## City-plan system (2026-07-23) — the full Starfall design bible

New: an authoritative, generated city plan. **Single source of truth: `docs/city/starfall_city.json`**
(districts, every structure with polar coords/dims/rooms/occupants, every NPC's home; geometry LOCKED to
`StarfallCity3D.gd`). Two generators read it (change JSON → re-run → all agree):
- `tools/gen_starfall_codex.py` → **`docs/Starfall_City_Codex.md`** (human-readable book of the city).
- `tools/gen_starfall_cityplan.py` → **`art/blueprints/Starfall_CityPlan.svg`** (gridded topographical
  survey in the Plate register; 50 m grid; the exemplar wedge fully plotted; Under-Terraces = the dashed
  "Other Map").

Decisions locked with the user: **~3,000 souls**, **every structure bespoke**, **foundation + one
exemplar wedge first**. Done this pass: the schema + all 9 Houses named/stubbed + **House Vael'Suran**
(the wedge flanking the Grand Processional, containing the built Open House) fully specified — 22
structures, ~301 souls, rim→Under-Terraces. Canon NPCs placed in-wedge: Talindir (apprentice scribe),
Vara (human prodigy in a canal garret), Durak Ironthought (with the Terran deep-wrights below).
**Next: author the other eight wedges (H1–H8) + the Academy island into the same JSON**, then re-run.
Run `python tools/gen_starfall_codex.py && python tools/gen_starfall_cityplan.py` to regenerate.

## Where we are

Building **Starfall**, the first big 3D zone, as a walkable greybox on the `godot/threed/` HD-2D kit
(the Cold Open — `ColdOpen3D.tscn` → Balcony3D + Scriptorium3D — is the reference implementation).

**Done this session:**
- `godot/threed/StarfallCity3D.gd` + `.tscn` — the whole caldera exterior, walkable, **built to scale
  (~900 m rim diameter)**: concentric terraces stepping DOWN ~46 m to the central star-lake "Mirror",
  9 rim observatory towers (one the dead House), crystal-comb ring, dense multi-storey habitation,
  railless causeway, Academy island with a ~110 m hero observatory (green dome + wings + moon-bridge +
  warded vault), and the golden armillary monument.
- **`docs/Scale_Reference.md`** — the units bible. **1 Godot unit = 1 metre, locked.** Check every zone
  against it. Buildings 10–26 m, doorways 2.2 m, terrace drops ~11 m, observatory ~110 m, etc.
- **`art/blueprints/Starfall_Blueprint.svg`** (gen `tools/gen_starfall_blueprint.py`) — labelled plan,
  same geometry as the greybox. **Map, doc, and world all share one geometry — change one, change all.**
- Real, working **grand staircases**: visible stepped boxes over a hidden ramp collider (Godot's
  `CharacterBody3D` can't climb stepped geometry). Headless-verified: player descends 11 m/terrace,
  stays grounded, no fall-through.
- `Player3D` gained opt-in **`gravity_enabled`**, **jump**, and hold-Shift-to-run. Zone3D gained
  additive collision helpers (`_floor_box` / `_ramp` / `_col_cyl`). **All opt-in — the Cold Open is
  unaffected** (it defaults `gravity_enabled = false`).
- Input remap: **Space = jump** now; `interact` is **F only** (Space was removed from it).
- New temp textures (basalt, canal_water, ward_glyph, comb_crystal, dome_verdigris, terrace_stone) via
  `tools/gen_3d_textures.py` → `godot/art/3d/`.
- Hero renders in `art/greybox_renders/`.

## How to run / test it

Open `godot/threed/StarfallCity3D.tscn` in Godot **4.7** (`/Applications/Godot_4.7.app`) and press **F6**
(Run Current Scene). Controls: **WASD** move · **Shift** run · **Space** jump · right-drag orbit ·
**V** first-person · **F** examine. You spawn on the rim; walk down the Grand Processional (+Z / front).

Regenerate art/map anytime: `python3 tools/gen_3d_textures.py` and `python3 tools/gen_starfall_blueprint.py`
(re-import textures with `Godot_4.7 --headless --import --path godot` if `load()` fails on new PNGs).

## Open items / next steps (pick up here)

1. ✅ **Feel tuning** (2026-07-23) — accel/friction + coyote + jump-buffer; walk 6.5 / run ×2.0. Final
   feel judgement still wants your eyes on it in-editor.
2. ✅ **Star-lake** (2026-07-23) — now a real void with last-safe respawn; causeway is the crossing.
3. ✅ **Performance** (2026-07-23) — MultiMesh pools for non-collidable dressing; meshes 4300 → 1047.
   Could go further later (MultiMesh the ~435 building *bodies* too, decoupling their collision) if load
   still feels heavy, but it's now well within budget.
4. ✅ **Wired into `SceneManager`** (2026-07-23) — Cold Open hands off to the 3D city; Marker3D spawns.
5. **WYSIWYG-editable scene (DEFERRED by user choice).** User wants to eventually open the zone in the
   editor and click/drag objects. Plan: BAKE the procedurally-generated city into a real `.tscn` — build
   it once, set every generated node's `owner` = scene root, `PackedScene.pack(root)` + `ResourceSaver.save`.
   Then it's fully editable. Caveat to warn about: a structural re-gen overwrites hand edits.
6. Building/interior variety, canal shaping, real modelled art to replace temp textures/primitives.

## Key files

| File | What |
|---|---|
| `godot/threed/StarfallCity3D.gd` / `.tscn` | the city (procedural) + its scene |
| `godot/threed/Zone3D.gd` | base kit + collision helpers |
| `godot/threed/Player3D.gd` | gravity/jump/run (opt-in) |
| `docs/Scale_Reference.md` | **the units bible** |
| `docs/Building_a_3D_Zone.md` | how the kit works |
| `art/blueprints/Starfall_Blueprint.svg` | the plan |
| `docs/Zone_Atlas.md`, `docs/KAYOS_Starfall_Map_Prompt.md` | Starfall canon |

## Nothing is broken / uncommitted after this handoff

Everything below was committed and pushed to `origin/master` (private repo
`github.com/smile88/KAYOS-NoS-v0-1-0`). `git pull` on the laptop to resume.
