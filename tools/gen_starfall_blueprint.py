#!/usr/bin/env python3
"""Starfall exterior blueprint — a labelled concentric plan of the whole city.

Rendered in the "Starfall Plate" register (silver-white linework on indigo-black,
antique-gold only for the important marks). This is BOTH a design deliverable and
the reference the 3D greybox (godot/threed/StarfallCity3D.gd) is built to: every
ring radius and terrace height printed here matches the world the greybox builds,
so the map and the walkable city agree.

Re-runnable:  python3 tools/gen_starfall_blueprint.py
Output: art/blueprints/Starfall_Blueprint.svg
"""
import math
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "art", "blueprints")

# --- palette -----------------------------------------------------------------
BG = "#0a0e20"
INK = "#0d1226"
SILVER = "#c7d3ec"
SILVER_DIM = "#6f7ba0"
GOLD = "#caa24a"
GREEN = "#5f8f7a"   # the verdigris observatory dome
DEAD = "#1a1f38"    # the dead House

# --- geometry: world metres -> screen px -------------------------------------
CX, CY = 760, 780
PXM = 1.33  # px per world-metre (screen radius = world_r * PXM)

# world radii (metres) — LOCKED to StarfallCity3D.gd & docs/Scale_Reference.md
R_ISLAND = 75.0
R_LAKE = 210.0
R_SHORE = 225.0
R_L4 = 285.0    # canal quarter (lowest terrace) outer edge, top y=+12
R_L3 = 340.0    # top y=+23
R_L2 = 395.0    # top y=+34  (+ crystal comb band on its lip)
R_L1 = 450.0    # rim walk, top y=+45
R_TOWER = 422.0

def rp(m):
    return m * PXM

def pol(r_m, ang_deg):
    a = math.radians(ang_deg - 90)  # 0deg = up (+Z front at bottom -> center up)
    return CX + rp(r_m) * math.cos(a), CY + rp(r_m) * math.sin(a)

svg = []
W = H = 1520
svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" font-family="Georgia, \'Times New Roman\', serif">')
svg.append(f'<rect width="{W}" height="{H}" fill="{BG}"/>')

# faint cloud-sea stipple beyond the rim
import random
random.seed(11)
svg.append('<g opacity="0.5">')
for _ in range(1400):
    a = random.uniform(0, 360)
    r = random.uniform(R_L1 + 6, R_L1 + 90)
    x, y = pol(r, a)
    if 0 < x < W and 0 < y < H:
        svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.4,1.6):.1f}" fill="{SILVER_DIM}"/>')
svg.append('</g>')

# helper: dashed / solid ring
def ring(r_m, stroke=SILVER, w=1.4, dash=None, op=1.0):
    d = f' stroke-dasharray="{dash}"' if dash else ''
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_m):.1f}" fill="none" stroke="{stroke}" stroke-width="{w}"{d} opacity="{op}"/>')

# --- terrace bands (fills, outer->inner so inner draws on top) ----------------
def band(r_out, r_in, fill, op):
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_out):.1f}" fill="{fill}" opacity="{op}"/>')

band(R_L1, R_L2, "#161b34", 1)
band(R_L2, R_L3, "#181d38", 1)
band(R_L3, R_L4, "#1a1f3c", 1)
band(R_L4, R_SHORE, "#12162c", 1)
band(R_SHORE, R_LAKE, "#0c1020", 1)

# --- the star-lake (a hole showing sky) --------------------------------------
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_LAKE):.1f}" fill="#05060f"/>')
random.seed(7)
svg.append('<g>')
for _ in range(900):
    a = random.uniform(0, 360)
    r = random.uniform(0, R_LAKE - 0.4)
    x, y = pol(r, a)
    b = random.randint(150, 255)
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.3,1.4):.1f}" fill="rgb({b},{b},255)" opacity="{random.uniform(0.4,1):.2f}"/>')
# faint constellation lines
for _ in range(9):
    pts = [pol(random.uniform(3, R_LAKE-3), random.uniform(0,360)) for _ in range(random.randint(2,4))]
    d = "M " + " L ".join(f"{x:.0f} {y:.0f}" for x, y in pts)
    svg.append(f'<path d="{d}" fill="none" stroke="{SILVER_DIM}" stroke-width="0.6" opacity="0.5"/>')
svg.append('</g>')

# --- ring outlines ------------------------------------------------------------
ring(R_L1, SILVER, 2.2)          # rim
ring(R_L2, SILVER, 1.4)
ring(R_L3, SILVER, 1.4)
ring(R_L4, SILVER, 1.4)
ring(R_SHORE, SILVER, 1.8)       # shore
ring(R_LAKE, GOLD, 1.2, op=0.8)  # lake edge
# crystal-comb band (angled blades just inside the rim)
comb_r = (R_L1 + R_L2) / 2
svg.append('<g opacity="0.8">')
for i in range(96):
    a = i * 360 / 96
    x1, y1 = pol(R_L2 + 0.4, a)
    x2, y2 = pol(R_L1 - 0.6, a + 2.2)
    svg.append(f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{SILVER_DIM}" stroke-width="1"/>')
svg.append('</g>')

# --- radial processional spokes + ramps (N,E,S,W) ----------------------------
for a in (0, 90, 180, 270):
    x1, y1 = pol(R_SHORE, a)
    x2, y2 = pol(R_L1, a)
    grand = (a == 180)  # bottom = +Z front = the Grand Processional aligned to the causeway
    svg.append(f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{GOLD if grand else SILVER}" stroke-width="{5 if grand else 2.4}" opacity="{0.9 if grand else 0.7}"/>')
    # ramp ticks
    for rr in (R_L2, R_L3, R_L4):
        tx, ty = pol(rr, a)
        svg.append(f'<circle cx="{tx:.1f}" cy="{ty:.1f}" r="3" fill="{GOLD if grand else SILVER}"/>')

# --- canals in the lower terraces (3 curved channels) ------------------------
svg.append('<g opacity="0.85">')
for base in (35, 155, 275):
    pts = []
    for t in range(0, 61):
        rr = R_SHORE + 1 + (R_L4 - R_SHORE - 2) * t / 60
        aa = base + 26 * math.sin(t / 60 * math.pi)
        pts.append(pol(rr, aa))
    d = "M " + " L ".join(f"{x:.1f} {y:.1f}" for x, y in pts)
    svg.append(f'<path d="{d}" fill="none" stroke="#2b3a66" stroke-width="4"/>')
    svg.append(f'<path d="{d}" fill="none" stroke="#3d5ca0" stroke-width="1.2"/>')
svg.append('</g>')

# --- the causeway (bottom, +Z) across the lake -------------------------------
cw_top = pol(R_ISLAND, 180)
cw_bot = pol(R_SHORE, 180)
svg.append(f'<line x1="{cw_top[0]:.1f}" y1="{cw_top[1]:.1f}" x2="{cw_bot[0]:.1f}" y2="{cw_bot[1]:.1f}" stroke="{SILVER}" stroke-width="7"/>')
svg.append(f'<line x1="{cw_top[0]:.1f}" y1="{cw_top[1]:.1f}" x2="{cw_bot[0]:.1f}" y2="{cw_bot[1]:.1f}" stroke="{GOLD}" stroke-width="1.5"/>')

# --- the 9 observatory towers on the rim -------------------------------------
DEAD_INDEX = 6
for i in range(9):
    a = i * 40
    x, y = pol(R_TOWER, a)
    is_dead = (i == DEAD_INDEX)
    fill = DEAD if is_dead else INK
    edge = SILVER_DIM if is_dead else SILVER
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="15" fill="{fill}" stroke="{edge}" stroke-width="1.6"/>')
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="7" fill="none" stroke="{edge}" stroke-width="1"/>')
    if is_dead:
        svg.append(f'<line x1="{x-16:.1f}" y1="{y-16:.1f}" x2="{x+16:.1f}" y2="{y+16:.1f}" stroke="{SILVER_DIM}" stroke-width="1.4"/>')
    else:
        # tiny gold house-sigil dot
        sx, sy = pol(R_TOWER + 3, a)
        svg.append(f'<circle cx="{sx:.1f}" cy="{sy:.1f}" r="3" fill="{GOLD}"/>')

# --- Academy island (dead centre) --------------------------------------------
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_ISLAND):.1f}" fill="#0f1430" stroke="{GOLD}" stroke-width="2"/>')
# central observatory dome (the HERO — scaled up per the concept note)
svg.append(f'<circle cx="{CX}" cy="{CY}" r="30" fill="#0c1128" stroke="{GREEN}" stroke-width="2.5"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="18" fill="none" stroke="{GREEN}" stroke-width="1.2"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="6" fill="{GOLD}"/>')
# two wings + moon-bridge
for sgn in (-1, 1):
    wx, wy = CX + sgn * 55, CY - 6
    svg.append(f'<rect x="{wx-16:.0f}" y="{wy-16:.0f}" width="32" height="32" fill="#101636" stroke="{SILVER}" stroke-width="1.4"/>')
svg.append(f'<path d="M {CX-40} {CY-6} Q {CX} {CY-30} {CX+40} {CY-6}" fill="none" stroke="{SILVER}" stroke-width="2" stroke-dasharray="4 3"/>')
# warded structure (gold glyph) + gate plaza (toward causeway)
svg.append(f'<rect x="{CX-14:.0f}" y="{CY+34:.0f}" width="28" height="22" fill="#141024" stroke="{GOLD}" stroke-width="1.6"/>')
svg.append(f'<circle cx="{CX}" cy="{CY+45}" r="6" fill="none" stroke="{GOLD}" stroke-width="1"/>')

# --- the armillary monument (front shore plaza, +Z) --------------------------
mono = pol(R_SHORE + 26, 180)
svg.append(f'<g transform="translate({mono[0]:.1f},{mono[1]:.1f})">')
svg.append(f'<circle r="13" fill="none" stroke="{GOLD}" stroke-width="1.6"/>')
svg.append(f'<ellipse rx="13" ry="5" fill="none" stroke="{GOLD}" stroke-width="1.2"/>')
svg.append(f'<ellipse rx="5" ry="13" fill="none" stroke="{GOLD}" stroke-width="1.2"/>')
svg.append(f'<circle r="3" fill="{GOLD}"/>')
svg.append('</g>')

# --- outer switchback stair (off the rim, running off-plate) -----------------
sa = 322
zx = []
for k in range(7):
    rr = R_L1 + 6 + k * 12.0
    off = 7 if k % 2 else -7
    zx.append(pol(rr, sa + off * 0.14))
d = "M " + " L ".join(f"{x:.1f} {y:.1f}" for x, y in zx)
svg.append(f'<path d="{d}" fill="none" stroke="{SILVER}" stroke-width="2"/>')

# ---------------------------------------------------------------------------
# LABELS
# ---------------------------------------------------------------------------
def label(text, x, y, anchor="start", fill=SILVER, size=19, italic=False, weight="normal"):
    text = text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    st = ' font-style="italic"' if italic else ''
    svg.append(f'<text x="{x:.0f}" y="{y:.0f}" fill="{fill}" font-size="{size}" text-anchor="{anchor}" font-weight="{weight}"{st}>{text}</text>')

def leader(x1, y1, x2, y2):
    svg.append(f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{SILVER_DIM}" stroke-width="0.8"/>')
    svg.append(f'<circle cx="{x1:.1f}" cy="{y1:.1f}" r="2" fill="{SILVER}"/>')

# title block
svg.append(f'<text x="60" y="80" fill="{SILVER}" font-size="40" letter-spacing="6">STARFALL</text>')
svg.append(f'<text x="62" y="108" fill="{SILVER_DIM}" font-size="16" letter-spacing="3">THE STARFALL PLATE — EXTERIOR SURVEY · greybox reference</text>')
svg.append(f'<line x1="62" y1="120" x2="470" y2="120" stroke="{GOLD}" stroke-width="1"/>')

# compass (star-rose)
svg.append(f'<g transform="translate({W-120},140)">')
svg.append(f'<circle r="42" fill="none" stroke="{SILVER_DIM}" stroke-width="1"/>')
for ang, t in [(0,"−Z"),(90,"+X"),(180,"+Z"),(270,"−X")]:
    a = math.radians(ang-90)
    svg.append(f'<line x1="0" y1="0" x2="{42*math.cos(a):.1f}" y2="{42*math.sin(a):.1f}" stroke="{SILVER}" stroke-width="1"/>')
    svg.append(f'<text x="{54*math.cos(a):.1f}" y="{54*math.sin(a)+5:.1f}" fill="{SILVER_DIM}" font-size="13" text-anchor="middle">{t}</text>')
svg.append(f'<circle r="4" fill="{GOLD}"/>')
svg.append(f'<text x="0" y="72" fill="{SILVER_DIM}" font-size="12" text-anchor="middle">+Z = front / causeway</text>')
svg.append('</g>')

# ring / district labels with leaders (place text in the margins)
lab = [
    # (world_r, angle, text, subtext, side)
    (R_TOWER, 20, "THE NINE TOWERS", "rim observatories · one dead House", "right"),
    (comb_r, 58, "THE CRYSTAL COMBS", "frozen grey flame", "right"),
    ((R_L2+R_L3)/2, 74, "UPPER TERRACES", "Noctari houses · y +34 → +23", "right"),
    ((R_L3+R_L4)/2, 112, "CANAL QUARTER", "lower terraces · 3 canals · y +23 → +12", "right"),
    (R_SHORE, 150, "THE SHORE", "black basalt strand · y 0", "left"),
    (R_LAKE-6, 205, "THE MIRROR", "the star-lake — a hole showing sky", "left"),
    (R_ISLAND-1, 250, "THE ACADEMY", "island · observatory dome · wards", "left"),
    (R_SHORE+4, 180, "ARMILLARY MONUMENT", "the golden orrery (hero prop)", "left"),
]
for r_m, a, t, sub, side in lab:
    px, py = pol(r_m, a)
    if side == "right":
        lx, ly = W - 360, py
        leader(px, py, lx - 8, ly - 6)
        label(t, lx, ly, "start", SILVER, 19, weight="bold")
        label(sub, lx, ly + 20, "start", SILVER_DIM, 14, italic=True)
    else:
        lx, ly = 360, py
        leader(px, py, lx + 8, ly - 6)
        label(t, lx, ly, "end", SILVER, 19, weight="bold")
        label(sub, lx, ly + 20, "end", SILVER_DIM, 14, italic=True)

# Grand Processional + causeway callouts (bottom)
gp = pol((R_SHORE+R_L1)/2, 180)
leader(gp[0], gp[1], gp[0]+150, H-120)
label("THE GRAND PROCESSIONAL", gp[0]+158, H-124, "start", GOLD, 18, weight="bold")
label("rim → shore ramp descent (walkable)", gp[0]+158, H-104, "start", SILVER_DIM, 14, italic=True)
cw = pol((R_ISLAND+R_LAKE)/2, 180)
leader(cw[0], cw[1], cw[0]-40, H-80)
label("THE CAUSEWAY — railless, y 0", cw[0]-48, H-76, "end", SILVER, 16)

# height legend (bottom-left)
svg.append(f'<g transform="translate(60,{H-190})">')
label("TERRACE HEIGHTS (walk down to the Mirror)", 0, 0, "start", SILVER, 15, weight="bold")
rows = [("Rim walk / Nine Towers", "y +45"), ("Upper terrace 2", "y +34"),
        ("Upper terrace 3", "y +23"), ("Canal quarter", "y +12"),
        ("Shore & causeway", "y 0"), ("The Mirror (lake surface)", "y −1")]
for i,(n,h) in enumerate(rows):
    yy = 26 + i*22
    label(n, 0, yy, "start", SILVER_DIM, 14)
    label(h, 300, yy, "end", GOLD, 14)
svg.append('</g>')

# scale bar
svg.append(f'<g transform="translate({W-260},{H-70})">')
svg.append(f'<line x1="0" y1="0" x2="{200*PXM:.0f}" y2="0" stroke="{SILVER}" stroke-width="2"/>')
for k in range(3):
    svg.append(f'<line x1="{k*100*PXM:.0f}" y1="-5" x2="{k*100*PXM:.0f}" y2="5" stroke="{SILVER}" stroke-width="2"/>')
label("0", 0, 22, "middle", SILVER_DIM, 12)
label("100 m", 100*PXM, 22, "middle", SILVER_DIM, 12)
label("200 m", 200*PXM, 22, "middle", SILVER_DIM, 12)
label("City diameter ≈ 900 m", 0, 40, "start", SILVER_DIM, 12, italic=True)
svg.append('</g>')

svg.append('</svg>')

os.makedirs(OUT, exist_ok=True)
path = os.path.join(OUT, "Starfall_Blueprint.svg")
with open(path, "w") as f:
    f.write("\n".join(svg))
print("wrote", path)
