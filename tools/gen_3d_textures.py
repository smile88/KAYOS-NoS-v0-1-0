#!/usr/bin/env python3
"""Placeholder 3D textures for the HD-2D Cold Open branch (cold-open-3d).

Environment meshes are textured with these; characters and props reuse the 2D
placeholder sprites as billboards. Basic but readable — swap with real art later.
Re-runnable:  python3 tools/gen_3d_textures.py
Output: godot/art/3d/
"""
import math
import os
import random
from PIL import Image, ImageDraw

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "godot", "art", "3d")
random.seed(7)


def save(im, name):
    im.save(os.path.join(OUT, name + ".png"))
    print("  " + name + ".png")


def _noise(im, amt):
    px = im.load()
    for y in range(im.height):
        for x in range(im.width):
            r, g, b, a = px[x, y]
            n = random.randint(-amt, amt)
            px[x, y] = (max(0, min(255, r + n)), max(0, min(255, g + n)),
                        max(0, min(255, b + n)), a)


def tile(name, base, vein, kind="marble", size=128):
    im = Image.new("RGBA", (size, size), base + (255,))
    d = ImageDraw.Draw(im)
    if kind == "marble":
        for _ in range(6):
            y = random.randint(0, size)
            pts = [(x, y + int(10 * math.sin(x / 18.0 + y))) for x in range(0, size, 4)]
            d.line(pts, fill=vein + (255,), width=1)
    elif kind == "stone":
        for gy in range(0, size, 32):
            off = 16 if (gy // 32) % 2 else 0
            for gx in range(-off, size, 32):
                d.rectangle([gx, gy, gx + 31, gy + 31], outline=vein + (255,))
    elif kind == "wood":
        for gx in range(0, size, 22):
            d.line([(gx, 0), (gx, size)], fill=vein + (255,), width=2)
            for _ in range(3):
                y = random.randint(0, size)
                d.arc([gx - 6, y - 4, gx + 6, y + 4], 0, 360, fill=vein + (255,))
    _noise(im, 8)
    save(im, name)


def city_windows():
    """A tall building face: dark stone with warm lit windows. Tiled up building box sides."""
    im = Image.new("RGBA", (128, 128), (26, 25, 40, 255))
    d = ImageDraw.Draw(im)
    for wy in range(10, 120, 20):
        for wx in range(10, 118, 22):
            lit = random.random() > 0.35
            c = (255, 214, 120, 255) if lit else (34, 32, 50, 255)
            d.rectangle([wx, wy, wx + 12, wy + 12], fill=c)
    _noise(im, 5)
    save(im, "city_windows")


def star_dome():
    """Equirectangular-ish night sky for a large inverted sphere: deep indigo + stars."""
    w, h = 512, 256
    im = Image.new("RGBA", (w, h), (0, 0, 0, 255))
    d = ImageDraw.Draw(im)
    for y in range(h):                                  # vertical gradient, darker at top
        t = y / h
        c = (int(6 + 14 * t), int(6 + 13 * t), int(16 + 26 * t))
        d.line([(0, y), (w, y)], fill=c + (255,))
    for _ in range(420):
        x, y = random.randint(0, w - 1), random.randint(0, int(h * 0.7))
        b = random.randint(120, 255)
        d.point([(x, y)], fill=(b, b, min(255, b + 20), 255))
        if random.random() > 0.9:
            d.point([(x + 1, y), (x - 1, y), (x, y + 1), (x, y - 1)], fill=(70, 72, 110, 255))
    save(im, "star_dome")


def window_glow():
    """The scriptorium window: festival gold seen through cold glass."""
    im = Image.new("RGBA", (128, 96), (20, 19, 34, 255))
    d = ImageDraw.Draw(im)
    for bx, bh in [(8, 40), (34, 66), (60, 48), (86, 70), (108, 38)]:
        d.rectangle([bx, 90 - bh, bx + 18, 90], fill=(40, 38, 60, 255))
        for wy in range(90 - bh + 5, 86, 12):
            d.rectangle([bx + 4, wy, bx + 8, wy + 5], fill=(255, 214, 120, 255))
            d.rectangle([bx + 11, wy, bx + 15, wy + 5], fill=(255, 214, 120, 255))
    d.rectangle([0, 0, 127, 95], outline=(58, 52, 44, 255), width=4)
    d.line([(64, 0), (64, 95)], fill=(58, 52, 44, 255), width=4)
    save(im, "window_glow")


def main():
    os.makedirs(OUT, exist_ok=True)
    print("Writing 3D textures to", OUT)
    tile("marble_floor", (74, 68, 92), (104, 96, 120), "marble")   # night balcony marble
    tile("stone", (58, 54, 74), (40, 37, 52), "stone")             # rail / structure
    tile("scriptorium_floor", (58, 50, 44), (44, 38, 32), "wood")
    tile("scriptorium_wall", (44, 40, 46), (32, 29, 36), "stone")
    tile("shelf_wood", (72, 52, 34), (48, 34, 22), "wood")
    city_windows()
    star_dome()
    window_glow()
    print("Done.")


if __name__ == "__main__":
    main()
