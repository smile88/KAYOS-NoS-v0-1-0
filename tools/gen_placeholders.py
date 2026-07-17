#!/usr/bin/env python3
"""Generate labeled placeholder PNGs for KAYOS: The Night of Silence.

Every placeholder carries its Asset Bible ID baked into the pixels, so in the
Godot editor you always know exactly which real asset replaces it. Re-runnable:
  python3 tools/gen_placeholders.py
Output: godot/art/placeholders/  (referenced by scenes; swap by dragging the
real PNG onto the node's Texture slot, or by dropping cleaned art into
godot/art/sprites|portraits and repointing the texture).
"""
import math
import os
from PIL import Image, ImageDraw, ImageFont

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "godot", "art", "placeholders")
FONT_PATH = os.path.join(ROOT, "godot", "ui", "fonts", "FN-001.ttf")

# Faction palette (matches NPC.gd / GDD faction reads)
NOCTARI = (107, 92, 184)
SOLARI = (217, 184, 97)
ORC = (140, 92, 71)
TERRAN = (115, 128, 107)
HUMAN = (153, 140, 128)
OTHER = (128, 128, 140)
INK = (24, 22, 34)
PARCHMENT = (226, 214, 181)
GOLD = (242, 209, 107)


def font(size):
    try:
        return ImageFont.truetype(FONT_PATH, size)
    except Exception:
        return ImageFont.load_default()


def label(draw, img_w, y, text, size=9, fill=(255, 255, 255)):
    f = font(size)
    w = draw.textlength(text, font=f)
    draw.text(((img_w - w) / 2, y), text, font=f, fill=fill)


def save(img, name):
    img.save(os.path.join(OUT, name + ".png"))
    print("  " + name + ".png")


def character(name, body, robe_trim=None, aged=False):
    """48x72 standing figure — the locked frame size (docs/Affinity_Cleanup_Guide.md).
    Feet at the bottom edge, ID label on the chest."""
    im = Image.new("RGBA", (48, 72), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    dark = tuple(int(c * 0.55) for c in body)
    skin = (216, 204, 226) if not aged else (198, 192, 206)
    # robe / body
    d.polygon([(12, 26), (36, 26), (42, 70), (6, 70)], fill=body, outline=dark)
    # head
    d.ellipse([15, 4, 33, 24], fill=skin, outline=dark)
    # hair / hood hint
    d.arc([15, 4, 33, 24], 180, 360, fill=dark, width=3)
    # trim stripe
    if robe_trim:
        d.polygon([(22, 26), (26, 26), (28, 70), (20, 70)], fill=robe_trim)
    # feet shadow line
    d.line([(8, 70), (40, 70)], fill=dark, width=2)
    label(d, 48, 38, name.split("_")[0], 9, (255, 255, 255))
    save(im, name)


def portrait(name, body, display):
    """96x96 dialogue bust."""
    im = Image.new("RGBA", (96, 96), INK + (255,))
    d = ImageDraw.Draw(im)
    dark = tuple(int(c * 0.5) for c in body)
    # shoulders + head silhouette
    d.pieslice([8, 52, 88, 140], 180, 360, fill=body, outline=dark)
    d.ellipse([28, 10, 68, 56], fill=tuple(int(c * 1.25) % 256 for c in body), outline=dark)
    d.rectangle([0, 0, 95, 95], outline=GOLD)
    label(d, 96, 70, name.split("_")[0], 10, GOLD)
    label(d, 96, 82, display, 8, PARCHMENT)
    save(im, name)


def tile(name, base, accent, pattern="stone"):
    """32x32 seamless-ish floor tile."""
    im = Image.new("RGBA", (32, 32), base + (255,))
    d = ImageDraw.Draw(im)
    dark = tuple(int(c * 0.82) for c in base)
    if pattern == "stone":
        d.rectangle([0, 0, 15, 15], outline=dark)
        d.rectangle([16, 16, 31, 31], outline=dark)
        d.point([(6, 22), (24, 8), (12, 28)], fill=accent)
    elif pattern == "marble":
        d.line([(0, 8), (31, 4)], fill=accent)
        d.line([(0, 24), (31, 28)], fill=accent)
        d.rectangle([0, 0, 31, 31], outline=dark)
    return im, d, name


def prop_banner():
    im = Image.new("RGBA", (32, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.line([(4, 2), (28, 2)], fill=(90, 74, 46), width=3)  # rod
    d.polygon([(6, 4), (26, 4), (26, 48), (16, 58), (6, 48)], fill=SOLARI, outline=(150, 118, 48))
    d.ellipse([12, 14, 20, 22], outline=(255, 244, 200), width=2)  # sun sigil
    label(d, 32, 30, "PR-021", 7, INK)
    save(im, "PR-021_festival_banner")


def prop_telescope():
    im = Image.new("RGBA", (48, 48), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.line([(12, 44), (24, 26)], fill=(80, 70, 60), width=3)   # tripod legs
    d.line([(36, 44), (24, 26)], fill=(80, 70, 60), width=3)
    d.line([(24, 44), (24, 26)], fill=(60, 52, 45), width=2)
    d.line([(14, 34), (38, 10)], fill=(184, 168, 120), width=6)  # tube
    d.line([(34, 14), (40, 8)], fill=(230, 214, 160), width=4)   # eyepiece glint
    label(d, 48, 36, "PR-021", 7, PARCHMENT)
    save(im, "PR-021_telescope")


def prop_satchel_letter():
    im = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rounded_rectangle([2, 12, 30, 30], 4, fill=(112, 84, 56), outline=(70, 52, 34))  # satchel
    d.arc([6, 2, 26, 22], 180, 360, fill=(70, 52, 34), width=3)                        # strap
    d.rectangle([9, 15, 25, 26], fill=PARCHMENT, outline=(150, 130, 90))               # letter
    d.ellipse([15, 19, 19, 23], fill=(158, 46, 46))                                    # wax seal
    save(im, "PR-008_sealed_letter")


def prop_notice_board():
    im = Image.new("RGBA", (64, 56), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([2, 2, 62, 42], fill=(96, 72, 48), outline=(58, 42, 26), width=2)
    for x, y, w, h in [(7, 7, 16, 14), (27, 9, 14, 18), (45, 6, 12, 12)]:
        d.rectangle([x, y, x + w, y + h], fill=PARCHMENT, outline=(160, 140, 100))
    d.rectangle([10, 44, 16, 55], fill=(58, 42, 26))
    d.rectangle([48, 44, 54, 55], fill=(58, 42, 26))
    label(d, 64, 28, "PR-016", 8, (58, 42, 26))
    save(im, "PR-016_notice_board")


def prop_garland():
    im = Image.new("RGBA", (96, 24), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.arc([0, -10, 95, 20], 20, 160, fill=(90, 74, 46), width=2)
    for i in range(6):
        x = 8 + i * 16
        y = 10 + int(6 * abs(2.5 - i) / 2.5) * -1 + 8
        d.ellipse([x - 3, y - 3, x + 3, y + 3], fill=GOLD, outline=(255, 244, 200))
    save(im, "PR-021_light_garland")


def prop_starlamp():
    im = Image.new("RGBA", (24, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.line([(12, 62), (12, 14)], fill=(120, 124, 140), width=3)
    d.ellipse([5, 2, 19, 16], fill=(255, 240, 190), outline=GOLD, width=2)
    d.rectangle([7, 58, 17, 63], fill=(90, 94, 110))
    save(im, "PR-017_star_lamp")


def prop_sun_mask():
    """A child's festival mask, dropped. PR-021 (festival solstice decorations)."""
    im = Image.new("RGBA", (24, 24), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for i in range(9):  # the sun's nine rays
        a = i * 40
        d.line([(12, 12), (12 + int(11 * math.cos(math.radians(a))),
                           12 + int(11 * math.sin(math.radians(a))))], fill=GOLD, width=1)
    d.ellipse([4, 4, 20, 20], fill=(242, 216, 130), outline=(150, 118, 48))
    d.ellipse([8, 9, 11, 12], fill=INK)   # eye holes
    d.ellipse([13, 9, 16, 12], fill=INK)
    save(im, "PR-021_sun_mask")


def prop_wine_cups():
    """Two abandoned cups. PR-021."""
    im = Image.new("RGBA", (24, 16), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for x in (3, 13):
        d.polygon([(x, 4), (x + 8, 4), (x + 6, 14), (x + 2, 14)], fill=(176, 168, 148),
                  outline=(120, 112, 96))
        d.ellipse([x, 2, x + 8, 6], fill=(122, 40, 58), outline=(120, 112, 96))  # wine dregs
    save(im, "PR-021_wine_cups")


def prop_broadsheet():
    """The printed order of ceremony. PR-008 (documents set)."""
    im = Image.new("RGBA", (24, 24), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.polygon([(3, 2), (21, 4), (20, 22), (4, 20)], fill=PARCHMENT, outline=(158, 140, 100))
    d.ellipse([9, 5, 15, 11], outline=GOLD, width=1)      # sun sigil masthead
    for y in range(13, 20, 2):
        d.line([(6, y), (18, y)], fill=(120, 106, 78))    # type
    save(im, "PR-008_broadsheet")


def prop_ledger():
    """Talindir's chronicle, open on the balustrade. PR-008 (documents set)."""
    im = Image.new("RGBA", (32, 24), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.polygon([(1, 6), (15, 3), (15, 21), (1, 22)], fill=PARCHMENT, outline=(150, 132, 92))
    d.polygon([(17, 3), (31, 6), (31, 22), (17, 21)], fill=PARCHMENT, outline=(150, 132, 92))
    d.line([(16, 3), (16, 21)], fill=(110, 96, 66), width=1)   # spine
    for y in range(8, 19, 3):
        d.line([(3, y), (13, y)], fill=(90, 80, 60))           # his narrowing hand
        d.line([(19, y), (29, y)], fill=(90, 80, 60))
    save(im, "PR-008_ledger")


def prop_stair_down():
    """The stair into the festival. PR-023 (stairs, ladders, catwalks)."""
    im = Image.new("RGBA", (48, 40), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for i in range(5):
        y = 4 + i * 7
        shade = 150 - i * 22
        d.rectangle([4 + i * 2, y, 44 - i * 2, y + 6], fill=(shade, shade - 6, shade + 10),
                    outline=(60, 56, 78))
    label(d, 48, 30, "PR-023", 7, (240, 236, 255))
    save(im, "PR-023_stair_down")


def prop_sun_mosaic():
    """Solari sun-sigil inlaid in the balcony floor. EN-006."""
    im = Image.new("RGBA", (64, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.ellipse([16, 16, 48, 48], outline=(198, 176, 120), width=3)
    for i in range(9):
        a = math.radians(i * 40)
        d.line([(32 + int(17 * math.cos(a)), 32 + int(17 * math.sin(a))),
                (32 + int(29 * math.cos(a)), 32 + int(29 * math.sin(a)))],
               fill=(198, 176, 120), width=2)
    label(d, 64, 29, "EN-006", 7, (198, 176, 120))
    save(im, "EN-006_sun_mosaic")


def prop_rail_carving():
    """Two sets of initials cut under the rail. EN-006."""
    im = Image.new("RGBA", (16, 12), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.line([(2, 3), (2, 9)], fill=(150, 140, 114))
    d.line([(2, 3), (5, 6)], fill=(150, 140, 114))
    d.line([(8, 3), (8, 9)], fill=(150, 140, 114))
    d.line([(8, 9), (12, 9)], fill=(150, 140, 114))
    save(im, "EN-006_rail_carving")


# --- Cold Open backdrops (EN-016, "The Same Night — city backdrops") ---------------
# HD-2D: nothing sits against a bare black void. The balcony looks out over a lit skyline,
# a star field, and the Tower.

def backdrop_stars():
    im = Image.new("RGBA", (128, 128), (10, 9, 20, 255))
    d = ImageDraw.Draw(im)
    rnd = [(17, 23), (44, 9), (91, 31), (120, 12), (7, 60), (63, 74), (110, 88),
           (33, 101), (78, 119), (99, 55), (52, 41), (13, 113), (126, 66), (70, 6)]
    for i, (x, y) in enumerate(rnd):
        c = (232, 230, 255) if i % 3 else (198, 205, 255)
        d.point([(x, y)], fill=c)
        if i % 4 == 0:
            d.point([(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)], fill=(90, 92, 130))
    save(im, "EN-016_stars")


def backdrop_skyline_far():
    """Tileable far horizon — the city continues past the frame in both directions."""
    im = Image.new("RGBA", (320, 96), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for bx, bw, bh in [(0, 34, 40), (38, 22, 62), (64, 40, 30), (108, 26, 52), (138, 30, 38),
                       (172, 24, 68), (200, 36, 34), (240, 28, 56), (272, 44, 44)]:
        top = 96 - bh
        d.rectangle([bx, top, bx + bw, 95], fill=(26, 25, 40), outline=(18, 17, 28))
        for wy in range(top + 5, 92, 9):
            for wx in range(bx + 4, bx + bw - 3, 8):
                if (wx + wy) % 3:
                    d.rectangle([wx, wy, wx + 2, wy + 3], fill=(198, 166, 96))
    save(im, "EN-016_skyline_far")


def backdrop_tower():
    """The Tower of Celestial Harmony, seen far off. The ceremony happens up there."""
    im = Image.new("RGBA", (96, 288), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.polygon([(38, 8), (58, 8), (72, 287), (24, 287)], fill=(44, 42, 66), outline=(28, 26, 44))
    for y in range(24, 280, 16):                       # lit windows all the way up
        w = 2 + (y // 40)
        d.rectangle([46 - w, y, 50 + w, y + 6], fill=(255, 222, 132))
    d.polygon([(40, 8), (48, -12), (56, 8)], fill=(255, 240, 190))   # the lit apex
    d.ellipse([36, -4, 60, 20], outline=(255, 240, 190), width=1)
    label(d, 96, 150, "EN-016", 8, (150, 150, 175))
    save(im, "EN-016_tower")


# --- The scriptorium below the balcony (EN-019 — NEW, add to Asset Bible) ----------

def scriptorium_window():
    """The festival, seen from inside. Gold light on a cold room."""
    im = Image.new("RGBA", (96, 80), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([0, 0, 95, 79], fill=(58, 52, 44), outline=(38, 34, 28), width=3)
    d.rectangle([6, 6, 89, 73], fill=(28, 26, 44))
    for bx, bh in [(10, 26), (30, 40), (52, 30), (70, 44)]:
        d.rectangle([bx, 73 - bh, bx + 15, 73], fill=(38, 36, 56))
        for wy in range(73 - bh + 4, 70, 8):
            d.rectangle([bx + 3, wy, bx + 6, wy + 3], fill=(255, 214, 120))
            d.rectangle([bx + 9, wy, bx + 12, wy + 3], fill=(255, 214, 120))
    d.line([(48, 6), (48, 73)], fill=(38, 34, 28), width=3)   # mullion
    d.line([(6, 40), (89, 40)], fill=(38, 34, 28), width=3)
    save(im, "EN-019_window")


def scriptorium_desk():
    im = Image.new("RGBA", (96, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([2, 18, 93, 40], fill=(96, 70, 46), outline=(58, 42, 28), width=2)
    d.rectangle([8, 40, 18, 62], fill=(72, 52, 34))
    d.rectangle([78, 40, 88, 62], fill=(72, 52, 34))
    d.polygon([(30, 8), (66, 8), (70, 18), (26, 18)], fill=(74, 54, 36), outline=(50, 36, 24))
    d.rectangle([36, 22, 60, 36], fill=PARCHMENT, outline=(150, 132, 92))   # a page, mid-sentence
    label(d, 96, 44, "EN-019", 7, (200, 186, 150))
    save(im, "EN-019_desk")


def scriptorium_tea():
    im = Image.new("RGBA", (16, 16), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.polygon([(3, 4), (13, 4), (11, 14), (5, 14)], fill=(184, 178, 162), outline=(120, 114, 100))
    d.ellipse([3, 2, 13, 6], fill=(74, 58, 40), outline=(120, 114, 100))    # long cold
    save(im, "EN-019_tea")


def prop_scroll_rack():
    """PR-007 — bookshelf & scroll rack set. Two thousand years of records."""
    im = Image.new("RGBA", (64, 96), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([0, 0, 63, 95], fill=(72, 52, 34), outline=(44, 32, 20), width=2)
    for shelf in range(4):
        y = 6 + shelf * 23
        d.line([(2, y + 20), (61, y + 20)], fill=(44, 32, 20), width=2)
        for i in range(7):
            x = 4 + i * 8
            h = 12 + ((i * 5 + shelf * 3) % 7)
            col = [(150, 140, 108), (120, 106, 78), (168, 156, 120), (96, 86, 64)][(i + shelf) % 4]
            d.rectangle([x, y + 20 - h, x + 6, y + 19], fill=col, outline=(50, 44, 32))
    label(d, 64, 44, "PR-007", 7, PARCHMENT)
    save(im, "PR-007_scroll_rack")


def prop_chest():
    """PR-020 — doors & containers set."""
    im = Image.new("RGBA", (48, 40), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([2, 12, 45, 38], fill=(90, 66, 44), outline=(52, 38, 24), width=2)
    d.pieslice([2, 2, 45, 24], 180, 360, fill=(104, 78, 52), outline=(52, 38, 24))
    d.line([(2, 13), (45, 13)], fill=(52, 38, 24), width=2)
    d.rectangle([20, 14, 27, 24], fill=(160, 140, 92), outline=(96, 82, 52))   # hasp
    save(im, "PR-020_chest")


def prop_cabinet():
    """PR-020 — the locked cabinet. Three hundred years of not opening it."""
    im = Image.new("RGBA", (64, 96), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([0, 0, 63, 95], fill=(64, 46, 62), outline=(38, 28, 40), width=2)
    d.line([(32, 4), (32, 91)], fill=(38, 28, 40), width=2)
    for x in (16, 48):
        d.rectangle([x - 9, 12, x + 9, 44], outline=(104, 88, 128))
        d.rectangle([x - 9, 52, x + 9, 84], outline=(104, 88, 128))
    d.ellipse([28, 44, 36, 52], fill=(158, 46, 46), outline=(90, 26, 26))     # indigo-wax seal, unbroken
    label(d, 64, 62, "PR-020", 7, (170, 156, 190))
    save(im, "PR-020_cabinet")


def prop_roster():
    """PR-008 — the duty roster. Every name struck through: they all went to the festival."""
    im = Image.new("RGBA", (32, 44), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([1, 1, 30, 42], fill=PARCHMENT, outline=(150, 132, 92))
    for i in range(7):
        y = 6 + i * 5
        d.line([(4, y), (26, y)], fill=(120, 106, 78))
        if i < 6:
            d.line([(3, y), (27, y)], fill=(150, 60, 60))   # struck through
    save(im, "PR-008_roster")


def prop_volume_one():
    """PR-008 — Volume I, in a hand two thousand years dead."""
    im = Image.new("RGBA", (40, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([2, 2, 37, 29], fill=(58, 44, 70), outline=(36, 26, 44), width=2)
    d.rectangle([6, 6, 33, 25], outline=GOLD)
    d.line([(12, 12), (27, 12)], fill=GOLD)
    d.line([(12, 18), (27, 18)], fill=GOLD)
    save(im, "PR-008_volume_one")


def prop_seal_kit():
    """PR-008 — wax and a matrix. The same indigo as the letter's seal."""
    im = Image.new("RGBA", (32, 24), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([1, 12, 30, 22], fill=(88, 72, 52), outline=(56, 44, 30))
    d.rectangle([4, 14, 12, 20], fill=(74, 62, 128))     # indigo wax block
    d.line([(20, 20), (24, 6)], fill=(120, 110, 96), width=3)   # the matrix handle
    d.ellipse([20, 2, 28, 10], fill=(150, 140, 120), outline=(96, 88, 74))
    save(im, "PR-008_seal_kit")


def prop_stair_up():
    """PR-023 — back up to the balcony."""
    im = Image.new("RGBA", (64, 48), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for i in range(5):
        y = 40 - i * 8
        shade = 70 + i * 22
        d.rectangle([6 + i * 3, y, 58 - i * 3, y + 7], fill=(shade, shade - 4, shade + 12),
                    outline=(48, 44, 66))
    label(d, 64, 2, "PR-023", 7, (240, 236, 255))
    save(im, "PR-023_stair_up")


def city_district(name, lit):
    """96x64 city block seen from above/afar — windows are the light source.
    The Silence sweep darkens these via modulate; a dark variant also exists."""
    im = Image.new("RGBA", (96, 64), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    for bx, bw, bh in [(0, 30, 52), (32, 26, 60), (60, 34, 44)]:
        top = 64 - bh
        d.rectangle([bx, top, bx + bw, 63], fill=(38, 36, 52), outline=(22, 20, 32))
        for wy in range(top + 6, 60, 10):
            for wx in range(bx + 5, bx + bw - 4, 9):
                col = (255, 214, 120) if lit else (30, 30, 42)
                d.rectangle([wx, wy, wx + 4, wy + 5], fill=col)
    label(d, 96, 26, "EN-016", 8, (150, 150, 170) if not lit else GOLD)
    save(im, name)


def balustrade():
    im = Image.new("RGBA", (32, 32), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rectangle([0, 2, 31, 8], fill=(150, 142, 128), outline=(96, 90, 82))   # rail
    for x in (4, 14, 24):
        d.rectangle([x, 9, x + 4, 26], fill=(120, 114, 104), outline=(84, 80, 74))
    d.rectangle([0, 27, 31, 31], fill=(150, 142, 128), outline=(96, 90, 82))
    save(im, "EN-006_balustrade")


def story_panel():
    im = Image.new("RGBA", (640, 360), (12, 11, 20, 255))
    d = ImageDraw.Draw(im)
    # a city skyline with half the windows dark
    for i in range(14):
        x = 8 + i * 45
        h = 60 + (i * 37) % 120
        d.rectangle([x, 360 - h, x + 36, 360], fill=(30, 28, 44), outline=(20, 18, 30))
        for wy in range(360 - h + 8, 352, 14):
            for wx in range(x + 4, x + 32, 10):
                lit = (i + wy) % 3 == 0 and i > 6
                d.rectangle([wx, wy, wx + 5, wy + 7], fill=(255, 214, 120) if lit else (18, 17, 28))
    label(d, 640, 120, "VS-001 — Cold Open: the lights die", 20, PARCHMENT)
    label(d, 640, 156, "(placeholder story panel — swap with the painted 1920x1080)", 12, (140, 138, 160))
    save(im, "VS-001_lights_die")


def title_card():
    im = Image.new("RGBA", (480, 200), (0, 0, 0, 0))
    d = ImageDraw.Draw(im)
    d.rounded_rectangle([0, 0, 479, 199], 10, fill=(31, 27, 46, 235), outline=GOLD, width=2)
    d.line([(40, 30), (440, 30)], fill=GOLD)
    d.line([(40, 170), (440, 170)], fill=GOLD)
    label(d, 480, 178, "UI-013", 9, (120, 116, 150))
    save(im, "UI-013_title_card")


def main():
    os.makedirs(OUT, exist_ok=True)
    print("Writing placeholders to", OUT)
    # -- characters (48x72, per locked sprite scale) --
    character("CH-001_elorin", NOCTARI, robe_trim=(60, 50, 110))
    character("CH-007_talindir_night", (150, 146, 168), robe_trim=GOLD, aged=True)
    character("CH-013_corel", (86, 76, 140))
    character("CH-027_athalas_citizen", SOLARI, robe_trim=(255, 240, 190))
    for fname, col in [("noctari", NOCTARI), ("solari", SOLARI), ("orc", ORC),
                       ("terran", TERRAN), ("human", HUMAN), ("other", OTHER)]:
        character("NPC_generic_" + fname, col)
    # -- portraits (96x96 in-game size) --
    portrait("PO-001_elorin", NOCTARI, "Elorin")
    portrait("PO-005_talindir_chronicler", (150, 146, 168), "Talindir")
    portrait("PO-011_corel", (86, 76, 140), "Corel")
    portrait("PO-014_generic", SOLARI, "Citizen")
    # -- tiles --
    for args, name in [
        (((74, 68, 92), (104, 96, 120), "marble"), "EN-006_balcony_floor"),
        (((52, 50, 72), (74, 72, 100), "stone"), "EN-001_academy_stone"),
        (((40, 38, 58), (58, 56, 82), "stone"), "EN-001_academy_path"),
        (((58, 50, 44), (78, 68, 58), "stone"), "EN-019_scriptorium_floor"),
        (((40, 34, 32), (54, 46, 42), "stone"), "EN-019_scriptorium_wall"),
    ]:
        im, d, _ = tile(name, *args)
        save(im, name)
    balustrade()
    # -- props --
    prop_banner()
    prop_telescope()
    prop_satchel_letter()
    prop_notice_board()
    prop_garland()
    prop_starlamp()
    # -- Cold Open density set: optional detail, most of it leading nowhere (GDD pillar 4, §8.4) --
    prop_sun_mask()
    prop_wine_cups()
    prop_broadsheet()
    prop_ledger()
    prop_stair_down()
    prop_sun_mosaic()
    prop_rail_carving()
    # -- Cold Open backdrops: HD-2D means no bare black behind a scene (GDD §13) --
    backdrop_stars()
    backdrop_skyline_far()
    backdrop_tower()
    # -- the scriptorium below the balcony (EN-019 — NEW, needs an Asset Bible row) --
    scriptorium_window()
    scriptorium_desk()
    scriptorium_tea()
    prop_scroll_rack()
    prop_chest()
    prop_cabinet()
    prop_roster()
    prop_volume_one()
    prop_seal_kit()
    prop_stair_up()
    # -- backdrop / panels / ui --
    city_district("EN-016_city_district_lit", True)
    city_district("EN-016_city_district_dark", False)
    story_panel()
    title_card()
    print("Done.")


if __name__ == "__main__":
    main()
