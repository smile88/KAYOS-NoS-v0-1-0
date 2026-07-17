# Claude Code CLI — Brief: Spec Reconciliation Pass
### KAYOS: The Night of Silence · July 2026

Paste this whole file into Claude Code CLI at the project root.

---

## CONTEXT

Sprite frame dimensions changed during art production (32×48 → 48×72) but the change was only
recorded in one document. The GDD and the Asset Bible still carry the old value. This task
propagates the correct spec everywhere and locks several values that were never written down at all.

**The viewport is NOT changing.** 640×360 is confirmed correct and stays. Do not alter it.

---

## 1. THE LOCKED SPEC (single source of truth — everything below must agree with this table)

| Property | Value | Status |
|---|---|---|
| Native viewport | **640 × 360** | unchanged — do not touch |
| Default window | **1280 × 720** | unchanged |
| Stretch mode / aspect / scale | **canvas_items / keep / integer** | unchanged |
| Default texture filter | **Nearest** | unchanged |
| Tile grid | **32 × 32 px** | unchanged |
| **Character sprite frame** | **48 × 72 px** | ⚠️ **CHANGED from 32×48** |
| **Character sprite sheet** | **192 × 288 px** (4 cols × 4 rows) | ⚠️ **NEW — was never specified** |
| **Sheet row order** | **row 0 = down, 1 = up, 2 = left, 3 = right** | ⚠️ **NEW — lock this** |
| **Frame baseline** | character's **feet sit on the bottom edge** of the frame; headroom varies | ⚠️ **NEW** |
| Portraits | 512 × 512 source → 96 × 96 in game | unchanged |
| Item icons | 32 × 32 | unchanged |
| Story panels | 1920 × 1080 (painterly, not pixel art) | unchanged |

### 1a. Character height chart (NEW — add this, it doesn't exist anywhere yet)

All characters share the 48×72 frame. They differ in how much of it they occupy. Heights are the
character's art height in pixels, feet on the baseline:

| Character group | Height in frame | Assets |
|---|---|---|
| Children | ~44 px | CH-028 |
| Terran (Durak) | ~52 px (broad) | CH-011 |
| Elves & humans | ~62–64 px | CH-001/002, CH-006–010, CH-012–018, CH-023–027 |
| Void Wardens (armoured) | ~68 px | CH-017 |
| Orcs | ~68–70 px | CH-003/004/005, CH-019–022, CH-028 (adult) |

**Reference already produced:** CH-001 (Elorin) is 64 px tall in a 48×72 frame. Every other elf/human
sprite matches her. Do not re-derive this from anything else.

---

## 2. FILES TO CHANGE

Locate these at the project root (names may vary slightly — search rather than assume):

1. `KAYOS_NoS_GDD.md`
2. `KAYOS_NoS_Asset_Bible.xlsx`
3. `Affinity_Cleanup_Guide.md`

---

### TASK A — `KAYOS_NoS_GDD.md`

**§13 Technical Specification** currently reads:

> - **Grid:** 32px tiles. Character sprites 32×48. Portraits 512×512 source → displayed ~96×96.
>   Story panels 1920×1080 (16:9, painterly — deliberate register shift for visions).

Replace the sprite clause and add the sheet/row/baseline spec. Result should read:

> - **Grid:** 32px tiles. **Character sprite frames 48×72; sheets are 192×288 (4 columns × 4 rows;
>   row order down / up / left / right; feet on the frame's bottom edge).** Character art heights vary
>   by race — see the height chart in the Asset Bible. Portraits 512×512 source → displayed ~96×96.
>   Story panels 1920×1080 (16:9, painterly — deliberate register shift for visions).

Then **grep the whole file for `32×48`, `32x48`, `128×192`, `128x192`** and fix any other hits.

---

### TASK B — `KAYOS_NoS_Asset_Bible.xlsx`

**This is a binary file — edit it with a Python script using `openpyxl`, not a text edit.**
Preserve all existing formatting, data validation, conditional formatting, formulas, and the
auto-filter. Do not regenerate the workbook from scratch. **Do not touch the Status or Date Done
columns** — the user may have started tracking.

**B1 — `ASSETS` sheet, column F ("Size / Format"), all rows where column B = `Character Sprite`:**
- Find: `32x48/frame, 4-dir sheet`
- Replace with: `48x72/frame · 192x288 sheet (4x4)`

**B2 — `ASSETS` sheet, column H (the prompt), all rows where column B = `Character Sprite`:**
- Find: `32x48 px per frame`
- Replace with: `48x72 px per frame`
- Also find: `4 frames per row, plus one idle frame per direction at row end`
- Replace with: `exactly 4 frames per row (walk cycle: contact-pass-contact-pass), 4 rows only, no extra columns`
  *(Rationale: the 7-column generations caused avoidable cleanup work. Ask for what the final sheet needs.)*

**B3 — `AFFINITY PIPELINE` sheet, the row labelled `Character sprite frame` (column B), update column C:**
- Current: `32 x 48 px · 72 DPI · RGB/8 · transparent background. Sheet = 4 columns x 4 rows -> canvas 128 x 192 px.`
- Replace with: `48 x 72 px · 72 DPI · RGB/8 · transparent. Sheet = 4 cols x 4 rows = 192 x 288 px. Feet on the frame's bottom edge. Character height varies by race (see height chart) — Elorin/elves/humans 64 px, orcs 68-70 px, Terran 52 px, children 44 px.`

**B4 — add the height chart as a new sheet** named `SPRITE SCALE`, using §1a above. Match the
existing visual style of the other sheets (header fill `2D2A4A`, white bold 10pt Arial headers,
body Arial 10pt colour `1A1A2E`, `showGridLines = False`, sensible column widths).

**B5 — grep every sheet for any remaining `32x48`, `32 x 48`, `128x192`, `128 x 192`** and fix.

---

### TASK C — `Affinity_Cleanup_Guide.md`

This file already has the correct 48×72 value, but **section A contains two instructions that are
wrong and have been superseded**. Replace them.

**C1 — In section A step 4, delete this entirely:**
> Turn the 32px grid on — note frames are 48 wide, so count 1.5 grid cells per frame; consider setting a temporary 48px guide via View → guides.

Replace with:
> **Do not use the 32px grid — it is for tilesets only and has nothing to do with sprite frames.**
> Instead, add guides via View → Guides Manager: **vertical at 48, 96, 144** and **horizontal at 72,
> 144, 216**. Three lines each = a 4×4 cell grid. Position every frame by typing exact X/Y into the
> **Transform panel** rather than by dragging.

**C2 — Replace section A steps 5–6 entirely** (the per-frame copy/paste + per-frame resize method).
The per-frame resize is actively harmful: source cells are near-square, target frames are tall, so
resizing frame-by-frame horizontally squashes the character. Replace with:

> **5. Resize the whole raw sheet ONCE (never frame by frame).**
>    Marquee tightly around one single character — top of head to bottom of feet. Read her height
>    **H** from the Transform panel. Then: **new width = (raw sheet width) × 64 ÷ H**.
>    ⌘D to deselect → Document → **Resize Document** → units **Pixels** → **chain/link icon ON** →
>    type the result in **Width** only → **Resampling = Nearest Neighbour** → Resize.
>    Every character scales together, in proportion. Squashing is impossible.
>    *(There is no Percentage option in the unified app's units dropdown — use the pixel formula.)*
>
> **6. Place frames using the Transform panel's bottom-centre anchor.**
>    Click the **bottom-centre square** on the 3×3 anchor widget beside the X/Y fields. X now means
>    the character's horizontal centre and Y means the ground under her feet — the panel does the
>    centring for you. Click each sprite and type its pair:
>
>    | Row | Direction | Y (feet) | X for the 4 frames |
>    |---|---|---|---|
>    | 1 | Down | 68 | 24 · 72 · 120 · 168 |
>    | 2 | Up | 140 | 24 · 72 · 120 · 168 |
>    | 3 | Left | 212 | 24 · 72 · 120 · 168 |
>    | 4 | Right | 284 | 24 · 72 · 120 · 168 |
>
>    Then **Document → Canvas Size** (*not* Resize Document) → **192 × 288**, **anchor top-left**, to
>    trim the spare margin. Typed coordinates stay valid.

**C3 — Add a note at the top of section A**, after the target line:

> **Never judge sprite size in Affinity at 100% zoom.** On a Retina display, 100% shows one image
> pixel as one physical pixel — roughly 0.1 mm. In game, the 640×360 viewport is scaled 3× to 1080p,
> so the sprite appears about 4× larger than Affinity shows it. **The only honest size check is
> running the sheet in Godot.**

---

## 3. WHAT NOT TO CHANGE (scope discipline — please respect this)

- **`project.godot` / Godot project settings.** 640×360 is correct. Verify only; report if wrong.
- **The 32px tile grid.** Unchanged. Sprite frames not matching tile size is normal and intended —
  characters are taller than one tile in every top-down RPG.
- **`KAYOS_Starfall_Level_Bible.md`**, the map prompts, the Claude Design prompt, the novel outline.
  None reference sprite frame size. Leave them alone.
- **Status / Date Done columns** in the Asset Bible. User-owned tracking data.
- **Any already-generated art.** No regeneration is implied by this task.
- **Portraits, icons, tiles, UI, story panels.** All their specs are unchanged.

---

## 4. VERIFICATION (run these and report results)

1. `grep -rn "32x48\|32 × 48\|32×48\|128x192\|128 × 192\|128×192" .` → **must return zero hits**
   outside of this brief file itself.
2. Open the workbook and confirm: sheet list is `READ ME`, `DASHBOARD`, `AFFINITY PIPELINE`,
   `SPRITE SCALE`, `ASSETS`; the ASSETS auto-filter still spans `A1:K130`; the Status dropdown
   validation still applies to column I; and the DASHBOARD formulas still return numbers, not errors.
   (There is a helper at `/mnt/skills/public/xlsx/scripts/recalc.py` in the authoring environment; if
   unavailable locally, just open and confirm no `#REF!`/`#VALUE!`.)
3. Confirm all 28 `Character Sprite` rows show `48x72/frame · 192x288 sheet (4x4)` in column F.
4. Confirm GDD §13 contains `48×72` and `192×288`.
5. Report anything you found that contradicts §1 but wasn't listed in §2 — there may be drift I
   haven't anticipated.

---

## 5. ONE OPEN QUESTION FOR THE USER (do not guess — ask)

The 48×72 frame is **48 px wide**. Orc sprites (CH-003/004/005, CH-019–022) are ~70 px tall and
broad-shouldered, and some poses — a spread cloak, a wide stance, a raised arm — may exceed 48 px of
horizontal art.

If any sprite's art is wider than 48 px, the frame width must increase (**64 × 72** is the natural
next step, and it keeps the 4×4 sheet at 256×288). This affects only the frame, not the viewport, not
the tile grid, and not any non-character asset.

**Ask the user to check the widest existing sprite** (the row-2 back view of Elorin with the cloak
spread is the current worst case) and confirm whether 48 px is sufficient before this spec is
considered final.
