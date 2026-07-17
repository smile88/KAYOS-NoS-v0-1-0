# Affinity Cleanup Guide — hand-holding, step by step (macOS, iMac M4)

For the **unified Affinity app** ("Affinity by Canva"). This is the from-the-moment-you-open-it
walkthrough for the **first of each asset type**. Once you've done one of a type, the rest are
repeats. Companion: `Asset_Bible.xlsx` → **AFFINITY PIPELINE** sheet (your own app-specific notes).

Shortcuts are Mac (⌘ = Cmd, ⌥ = Option). **Sprite frame size is 48×72** (our locked decision).

---

## Where everything goes (naming & save locations) — READ FIRST

| Thing | Where | Name |
|---|---|---|
| The editable Affinity document (keep it!) | `art/affinity_work/` | `CH-001.afphoto` |
| The final flattened PNG (this is what ships) | `art/assets_clean/` | `CH-001.png` (just the asset ID) |
| The raw generation (already there, don't touch) | `art/assets_raw/` | `CH-001.png` |

**Golden rule:** the file in `art/assets_clean/` is named **exactly the asset ID + `.png`** (e.g.
`EN-001.png`, `UI-001.png`). When one is done, tell me "CH-001 cleaned" and I import it into Godot.

---

## 0. One-time app setup (do this once, ever)

1. **Open Affinity.** Top of the window is a **Studio/Persona selector** (Pixel / Vector / Layout).
   For sprites, tilesets, props, icons → **Pixel**. For UI panels/logos → **Vector**.
2. **Turn on Pixel View:** `⌘⌥Y`. This shows true rasterised pixels. (If art ever looks mysteriously
   soft, you've flipped back to Vector View — press it again.)
3. **Grid:** View menu → **Show Grid**, then View → **Grid & Axis Manintenance/Settings** → spacing
   **32 px**, 1 division. This is your tile grid.
4. **Snapping:** toolbar snap toggle **on**. In Vector, also enable **Force Pixel Alignment**.
5. **Build your 3 palettes once** (from your approved anchors): Swatches panel → ▤ menu → **Add
   Document Palette**, one each: **Noctari** (indigo/violet/silver), **Solari** (gold/ivory/dawn),
   **Orc** (ash/iron/rust/ember). After CH-001 is approved: Swatches → **Create Palette from
   Document**, prune to ~16–24 colours, lock it. Every later asset picks only from these.

---

## A. CHARACTER SPRITE — walkthrough for CH-001 (Elorin)  ·  target 48×72/frame

> **Never judge sprite size in Affinity at 100% zoom.** On a Retina display 100% shows one image
> pixel as one physical pixel — roughly 0.1 mm. In game the 960×540 viewport is scaled **2×** to
> 1080p (and 4× to 4K), so the sprite appears several times larger than Affinity shows it.
> **The only honest size check is running the sheet in Godot.**

Your raw sheet is **2816×1536**, 7 columns × 4 rows (rows = **down / up / left / right** — this order is locked, see GDD §13; columns
6–7 are staff/idle poses) on a **flat magenta** background. Goal: one clean **192×288** sheet =
**4 frames wide × 4 rows** at **48×72 each**.

1. **Open** `art/assets_raw/CH-001.png` (File → Open). Switch to **Pixel** studio, Pixel View on (`⌘⌥Y`).
2. **Key out the magenta.** Select menu → **Select Sampled Colour**. Click the magenta. Set
   **Tolerance low** (~10–15) so it grabs the flat pink but not her robe. Then **Delete** (⌫). If a
   thin magenta/orange *fringe* rings her, Select → **Grow/Shrink** +1px and delete again, or clean
   stray edge pixels by hand later. Now the background is transparent (checkerboard).
3. **Pick your 4 walk frames per direction.** You have 7 columns; you only need 4 clean ones for a
   walk cycle (contact-pass-contact-pass). Ignore the staff-idle extras for now. Decide which 4
   columns read best as a loop for the DOWN row; you'll mirror LEFT↔RIGHT so you really only clean
   **down, up, side**.
4. **Make the target canvas.** File → **New** → **192 × 288** px (4 frames wide × 4 rows),
   72 DPI, RGB/8, transparent.
   **Do not use the 32px grid — it is for tilesets only and has nothing to do with sprite frames.**
   Instead add guides via View → **Guides Manager**: **vertical at 48, 96, 144** and **horizontal at
   72, 144, 216**. Three lines each = a 4×4 cell grid. Position every frame by typing exact X/Y into
   the **Transform panel**, never by dragging.
5. **Resize the whole raw sheet ONCE — never frame by frame.**
   Marquee tightly around one single character — top of head to bottom of feet. Read her height **H**
   from the Transform panel. Then: **new width = (raw sheet width) × 64 ÷ H**.
   `⌘D` to deselect → Document → **Resize Document** → units **Pixels** → **chain/link icon ON** →
   type the result into **Width** only → **Resampling = Nearest Neighbour** → Resize.
   Every character scales together, in proportion, and squashing is impossible.
   *(There is no Percentage option in the unified app's units dropdown — use the pixel formula.)*
   **Why this replaced the old per-frame method:** the source cells are near-square and the target
   frames are tall, so resizing each frame to 48×72 individually squashes the character horizontally.
6. **Place frames using the Transform panel's bottom-centre anchor.**
   Click the **bottom-centre square** on the 3×3 anchor widget beside the X/Y fields. X now means the
   character's horizontal centre and Y means the ground under her feet — the panel does the centring
   for you. Click each sprite and type its pair:

   | Row | Direction | Y (feet) | X for the 4 frames |
   |---|---|---|---|
   | 1 | Down | 68 | 24 · 72 · 120 · 168 |
   | 2 | Up | 140 | 24 · 72 · 120 · 168 |
   | 3 | Left | 212 | 24 · 72 · 120 · 168 |
   | 4 | Right | 284 | 24 · 72 · 120 · 168 |

   Then **Document → Canvas Size** (*not* Resize Document) → **192 × 288**, **anchor top-left**, to
   trim the spare margin. Typed coordinates stay valid.
7. **The real work — hand-clean each 48×72 frame** (budget 20–45 min/sprite, this is normal):
   - Zoom **800–1600%**. Open a second view at 100% (Window → **New View**) so you always see it at
     game size while you work zoomed in — *if it doesn't read at 100%, it doesn't work.*
   - Tool: **Pixel Tool**, width **1px** (hard, aliased). **Fix the silhouette first** (it must read
     instantly), then flatten stray in-between colours onto palette colours (**Colour Picker** from
     your Noctari palette), then clean the outline to a single consistent 1px run.
   - **Never** use the Paint Brush (anti-aliased), or any Blur/Feather/Glow/Layer FX — all make
     in-between pixels that destroy pixel art. Shade with dithering or discrete steps.
   - Onion-skin trick: set the previous frame's layer to ~30% opacity beneath the one you're drawing;
     toggle it off before export.
8. **Mirror the side row** for the opposite direction: select the cleaned side frames, `⌘C`, paste,
   then **Flip Horizontal** (Layer → Flip Horizontal). Place in the other row.
9. **Save the working file:** File → **Save As** → `art/affinity_work/CH-001.afphoto`.
10. **Export the final:** File → **Export** → **PNG**, whole document (192×288), **don't resample /
    Nearest**, transparency on. Save to **`art/assets_clean/CH-001.png`**.
11. **Tell me "CH-001 cleaned."** I import it, slice it into a SpriteFrames (48×72), set Filter =
    Nearest, and swap it onto the player/NPC. Then in the Bible set Status → **Cleaned**.

> First one is the hard one. It also builds your palette. After Elorin, the other 6 sprites go faster
> because you'll reuse her palette and silhouette conventions.

---

## B. TILESET / ENVIRONMENT — walkthrough for EN-001 (Academy exterior)  ·  32px tiles

**Do not try to salvage the AI's grid** — image models can't hold a 32px grid. You **trace clean
tiles over the generation** using it purely as colour/mood reference.

1. New doc: **512 × 512 px** (16×16 tiles), 72 DPI, RGB/8, transparent. Pixel studio, grid **32px** on.
2. File → **Place** `art/assets_raw/EN-001.png` as a layer. Scale it to roughly fill, then drop that
   layer's **opacity to ~40%** and **lock** it. This is your reference only.
3. Add a **new layer above** it. With the **Pixel Tool** (1px) and your palette, draw the actual
   **32×32 tiles** you need — ground, path, wall, a couple of decorated variants — snapping to the
   grid. You're tracing *intent* (the look), not pixels.
4. **Seam check** (Affinity has no tiled preview): copy a finished ground tile into a **3×3 block** on
   a scratch layer and eyeball that edges meet with no visible seam. Adjust edge pixels until they
   tile cleanly.
5. Delete/hide the reference layer. **Save working:** `art/affinity_work/EN-001.afphoto`.
6. **Export PNG** (Nearest / don't resample) → **`art/assets_clean/EN-001.png`**.
7. Tell me "EN-001 cleaned." I'll import it as a **TileSet** so you can *paint* the Academy map on a
   TileMapLayer — the RPG-Maker part.

---

## C. UI 9-SLICE — walkthrough for UI-001 (dialogue box)

Your UI-001 image has the **finished frame on the left** and a labelled 9-slice guide on the right.
You only need to extract the finished frame cleanly.

1. Open `art/assets_raw/UI-001.png`. (Vector or Pixel is fine here — it's not pixel-grid art.)
2. **Crop to just the left frame:** Rectangle Marquee around the finished panel (the parchment field
   with the indigo/gold border and griffin corners), `⌘C`, `⌘⇧V` into a new document (or Document →
   **Clip Canvas** to the selection).
3. Make it a clean rectangle: trim so the border is symmetric on all four sides. Note roughly how many
   pixels in from each edge the **inner parchment** starts — that's the **9-slice margin** (e.g.
   ~48px). Jot it down; I'll enter it into Godot's NinePatchRect.
4. Keep the **center parchment** area flat/tileable so it can stretch. If the griffin corners are
   large, that's fine — 9-slice keeps corners fixed and stretches only edges/center.
5. **Save working:** `art/affinity_work/UI-001.afphoto`. **Export PNG** (transparency on) →
   **`art/assets_clean/UI-001.png`**.
6. Tell me "UI-001 cleaned + margins ~NN px." I wire it as the dialogue panel background (replacing
   the placeholder), and repeat the pattern for UI-002…006.

---

## D. PROP / OBJECT — walkthrough for a PR-### (e.g. PR-007 bookshelves)

Props are single objects on magenta, in **multiples of 32** (32×32, 64×64, 96×64…).

1. Open the raw. Pixel studio, Pixel View on.
2. **Key out magenta** (Select Sampled Colour → Delete), clean any fringe.
3. Decide each prop's tile footprint (a bookshelf might be 64×96). For each object: marquee it,
   copy to a scratch doc, **Resize Document → Nearest Neighbour** to the target size.
4. Hand-clean silhouette + palette (same as sprites, usually faster — props are static, no frames).
5. Arrange the finished props on one transparent canvas (a small "prop sheet") OR export each
   separately. Simpler to start: one prop per PNG.
6. Save working `.afphoto`; **export PNG** → `art/assets_clean/PR-007.png` (or `PR-007_shelf.png`,
   `PR-007_scrollrack.png` if you split them — tell me the names).

---

## E. ITEM ICON — walkthrough for IT-001 (document icons)  ·  exactly 32×32

1. Open raw. The generation likely shows several icons in a grid.
2. Key out magenta. For **each** icon: marquee it, copy to a new **32×32** doc, **Resize → Nearest**.
3. Clean to read at 32px (icons must be legible tiny — bold silhouette, palette colours only).
4. Export each → `art/assets_clean/IT-001_1.png … IT-001_6.png` (tell me how many).

---

## F. PORTRAITS — already done (but here's how to refine)

I already downscaled PO-001/004/005/006/007/008 to **512×512** in `art/assets_clean/`. They're
painterly (not pixel art), so nothing more is required. **If** you want to refine one (colour match,
crop, remove a stray mark): open the raw 2048² in Pixel studio, edit with normal (anti-aliased) tools
this time — portraits are *not* pixel art — then Document → **Resize → 512×512 (Bilinear/Lanczos is
fine here)** and export over `art/assets_clean/PO-001.png`.

---

## Quick reference — do / don't

| ✅ Use | ❌ Avoid (destroys pixel art) |
|---|---|
| Pixel Tool (1px, hard) | Paint Brush (anti-aliased) |
| Flood Fill with **anti-aliasing OFF** | Blur / Feather / Glow / Soft Shadow |
| Colour Picker (from your palette) | Any Layer FX / Live Filters on sprites |
| Resize with **Nearest Neighbour** | Bilinear/Bicubic/Lanczos on pixel art |
| Selection + ⌘C/⌘V to build frames | Non-integer free-transform scaling |

**Workflow per asset:** open raw → key magenta (sprites/props/icons only) → downscale Nearest →
hand-clean silhouette+palette → save `.afphoto` to `affinity_work/` → export PNG to `assets_clean/`
using the exact asset ID → tell me → I import it into Godot.
