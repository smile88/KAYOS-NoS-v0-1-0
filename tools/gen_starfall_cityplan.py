#!/usr/bin/env python3
"""Starfall City Plan — the gridded topographical survey, generated from the single
source of truth docs/city/starfall_city.json.

The "Starfall Plate" register (silver-white linework on indigo-black, antique gold
for the important marks), now with a metric survey grid overlaid and every
fully-specified ("detailed") House wedge plotted — each structure a labelled
footprint, the Under-Terraces drawn beneath as the "Other Map" the official plate
omits. Geometry LOCKED to godot/threed/StarfallCity3D.gd (the JSON mirrors those
radii), so map, codex and walkable world agree. Population totals are computed.

Re-runnable:  python tools/gen_starfall_cityplan.py
Output: art/blueprints/Starfall_CityPlan.svg
"""
import json
import math
import os
import random

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "docs", "city", "starfall_city.json")
OUT = os.path.join(ROOT, "art", "blueprints")

with open(SRC, encoding="utf-8") as f:
    C = json.load(f)
G = C["geometry_locked"]

# --- palette -----------------------------------------------------------------
BG = "#0a0e20"; INK = "#0d1226"; SILVER = "#c7d3ec"; SILVER_DIM = "#6f7ba0"
GOLD = "#caa24a"; GREEN = "#5f8f7a"; DEAD = "#1a1f38"
RUST = "#b06a3a"; RUST_DIM = "#7a4a2c"      # the Under-Terraces / Other-Map palette
DISTRICT_FILL = {
    "D-RIM": "#3a3320", "D-UPPER": "#20264a", "D-MID": "#1b2040",
    "D-CANAL": "#1d2c50", "D-SHORE": "#181d38", "D-UNDER": "#2a180e",
}
DISTRICT_EDGE = {
    "D-RIM": GOLD, "D-UPPER": SILVER, "D-MID": SILVER_DIM,
    "D-CANAL": "#4f77c0", "D-SHORE": SILVER, "D-UNDER": RUST,
}

# --- geometry: world metres -> screen px -------------------------------------
CX, CY = 800, 810
PXM = 1.46
R_ISLAND=G["R_ISLAND"]; R_LAKE=G["R_LAKE"]; R_SHORE=G["R_SHORE"]
R_L4=G["R_L4"]; R_L3=G["R_L3"]; R_L2=G["R_L2"]; R_L1=G["R_L1"]; R_TOWER=G["R_TOWER"]
W, H = 2040, 1620

def rp(m): return m * PXM
def pol(r_m, screen_deg):
    a = math.radians(screen_deg - 90)
    return CX + rp(r_m) * math.cos(a), CY + rp(r_m) * math.sin(a)
def wpol(r_m, a_deg):
    """world polar (a_deg: 0=+Z front, +toward +X) -> screen point."""
    return pol(r_m, 180 - a_deg)

svg = []
svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" '
           f'font-family="Georgia, \'Times New Roman\', serif">')
svg.append(f'<rect width="{W}" height="{H}" fill="{BG}"/>')

# faint cloud-sea stipple beyond the rim
random.seed(11)
svg.append('<g opacity="0.45">')
for _ in range(1300):
    a = random.uniform(0, 360); r = random.uniform(R_L1 + 6, R_L1 + 70)
    x, y = pol(r, a)
    if 0 < x < CX*2 and 0 < y < H:
        svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.4,1.4):.1f}" fill="{SILVER_DIM}"/>')
svg.append('</g>')

# --- terrace bands (context) --------------------------------------------------
def band(r_out, fill):
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_out):.1f}" fill="{fill}"/>')
band(R_L1, "#161b34"); band(R_L2, "#181d38"); band(R_L3, "#1a1f3c")
band(R_L4, "#12162c"); band(R_SHORE, "#0c1020")

# star-lake (a hole showing sky)
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_LAKE):.1f}" fill="#05060f"/>')
random.seed(7)
for _ in range(750):
    a = random.uniform(0, 360); r = random.uniform(0, R_LAKE - 0.4)
    x, y = pol(r, a); b = random.randint(150, 255)
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.3,1.3):.1f}" '
               f'fill="rgb({b},{b},255)" opacity="{random.uniform(0.4,1):.2f}"/>')

# --- METRIC SURVEY GRID (the "on a grid" ask) --------------------------------
svg.append('<g opacity="0.30">')
r = 50
while r <= R_L1 + 60:
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r):.1f}" fill="none" stroke="{SILVER_DIM}" '
               f'stroke-width="0.7" stroke-dasharray="2 4"/>')
    r += 50
for sd in range(0, 360, 15):
    x2, y2 = pol(R_L1 + 55, sd)
    svg.append(f'<line x1="{CX}" y1="{CY}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{SILVER_DIM}" '
               f'stroke-width="0.6" stroke-dasharray="2 5"/>')
svg.append('</g>')
for rr in (100, 200, 300, 400):
    x, y = pol(rr, 0)
    svg.append(f'<text x="{x+4:.0f}" y="{y-3:.0f}" fill="{SILVER_DIM}" font-size="12">{rr} m</text>')

# --- ring outlines + terrace edges -------------------------------------------
def ring(r_m, stroke=SILVER, wd=1.4, op=1.0):
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_m):.1f}" fill="none" stroke="{stroke}" '
               f'stroke-width="{wd}" opacity="{op}"/>')
ring(R_L1, SILVER, 2.2); ring(R_L2); ring(R_L3); ring(R_L4)
ring(R_SHORE, SILVER, 1.8); ring(R_LAKE, GOLD, 1.2, 0.8)

# --- highlight the detailed wedges -------------------------------------------
detailed = [h for h in C["houses"] if h.get("detailed")]
for det in detailed:
    a0, a1 = det["wedge_a"]
    pts = [f"{CX},{CY}"]; aa = a0
    while aa <= a1 + 0.01:
        x, y = wpol(R_L1, aa); pts.append(f"{x:.1f},{y:.1f}"); aa += 2
    svg.append(f'<polygon points="{" ".join(pts)}" fill="{GOLD}" opacity="0.055"/>')
    for ab in (a0, a1):
        x1, y1 = wpol(R_SHORE, ab); x2, y2 = wpol(R_L1 + 20, ab)
        svg.append(f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{GOLD}" '
                   f'stroke-width="1.2" stroke-dasharray="6 4" opacity="0.6"/>')

# --- the 9 towers (context; detailed ones gold) ------------------------------
HTOWER = {h["id"]: h["tower_a_deg"] for h in C["houses"]}
for h in C["houses"]:
    a = h["tower_a_deg"]; x, y = wpol(R_TOWER, a)
    dead = h["status"] == "dead"; is_det = h.get("detailed")
    fill = DEAD if dead else INK
    edge = GOLD if is_det else (SILVER_DIM if dead else SILVER)
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="14" fill="{fill}" stroke="{edge}" stroke-width="{2.2 if is_det else 1.5}"/>')
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="6.5" fill="none" stroke="{edge}" stroke-width="1"/>')
    if dead:
        svg.append(f'<line x1="{x-15:.1f}" y1="{y-15:.1f}" x2="{x+15:.1f}" y2="{y+15:.1f}" stroke="{SILVER_DIM}" stroke-width="1.3"/>')
    lx, ly = wpol(R_TOWER + 34, a)
    svg.append(f'<text x="{lx:.0f}" y="{ly:.0f}" fill="{edge}" font-size="12" text-anchor="middle">{h["name"].replace("House ","H. ")}</text>')

# --- causeway + academy + armillary (context) --------------------------------
t0 = wpol(R_ISLAND, 0); t1 = wpol(R_SHORE, 0)
svg.append(f'<line x1="{t0[0]:.1f}" y1="{t0[1]:.1f}" x2="{t1[0]:.1f}" y2="{t1[1]:.1f}" stroke="{SILVER}" stroke-width="6"/>')
svg.append(f'<line x1="{t0[0]:.1f}" y1="{t0[1]:.1f}" x2="{t1[0]:.1f}" y2="{t1[1]:.1f}" stroke="{GOLD}" stroke-width="1.4"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_ISLAND):.1f}" fill="#0f1430" stroke="{GOLD}" stroke-width="2"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="28" fill="#0c1128" stroke="{GREEN}" stroke-width="2.4"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="6" fill="{GOLD}"/>')
svg.append(f'<text x="{CX}" y="{CY+rp(R_ISLAND)+18:.0f}" fill="{SILVER_DIM}" font-size="13" text-anchor="middle">THE ACADEMY (island)</text>')

# --- PLOT THE WEDGE STRUCTURES ------------------------------------------------
def radial_rect(cx, cy, w_m, d_m, dashed=False, fill="#222", edge=SILVER, op=1.0):
    ang = math.atan2(cy - CY, cx - CX)
    ur = (math.cos(ang), math.sin(ang)); ut = (-math.sin(ang), math.cos(ang))
    hr = rp(d_m) / 2; ht = rp(w_m) / 2
    corners = []
    for sr, st in ((1,1),(1,-1),(-1,-1),(-1,1)):
        px = cx + sr*hr*ur[0] + st*ht*ut[0]; py = cy + sr*hr*ur[1] + st*ht*ut[1]
        corners.append(f"{px:.1f},{py:.1f}")
    dash = ' stroke-dasharray="4 3"' if dashed else ''
    svg.append(f'<polygon points="{" ".join(corners)}" fill="{fill}" stroke="{edge}" '
               f'stroke-width="1.1"{dash} opacity="{op}"/>')

detailed_ids = [h["id"] for h in detailed]
house_order = {h["id"]: i for i, h in enumerate(detailed)}
ORDER = ["D-RIM", "D-UPPER", "D-MID", "D-CANAL", "D-SHORE", "D-UNDER"]
structs = [s for s in C["structures"] if s.get("house") in detailed_ids]
structs.sort(key=lambda s: (house_order.get(s.get("house"), 9),
                            ORDER.index(s.get("district", "D-MID")), -s["position"].get("r", 0)))
legend = []
for i, s in enumerate(structs, 1):
    did = s.get("district", "D-MID"); pos = s["position"]; fp = s.get("footprint", {})
    a = pos.get("a_deg", HTOWER.get(s.get("house"), 20)); r = pos.get("r", 300)
    cx, cy = wpol(r, a); under = did == "D-UNDER"
    fill = DISTRICT_FILL.get(did, "#222"); edge = DISTRICT_EDGE.get(did, SILVER)
    if fp.get("shape") == "cylinder":
        svg.append(f'<circle cx="{cx:.1f}" cy="{cy:.1f}" r="{rp(fp.get("diameter",10)/2):.1f}" '
                   f'fill="{fill}" stroke="{edge}" stroke-width="1.3"/>')
    elif fp.get("length"):
        radial_rect(cx, cy, fp.get("width", 6), fp.get("length", 40), under, fill, edge, 0.9)
    else:
        radial_rect(cx, cy, fp.get("w", 10), fp.get("d", 10), under, fill, edge, 0.95)
    tagcol = RUST if under else SILVER
    svg.append(f'<circle cx="{cx:.1f}" cy="{cy:.1f}" r="8.5" fill="{BG}" stroke="{tagcol}" stroke-width="1"/>')
    svg.append(f'<text x="{cx:.1f}" y="{cy+4:.1f}" fill="{tagcol}" font-size="11" text-anchor="middle">{i}</text>')
    legend.append((i, s, under))

# --- MARGIN: title, compass --------------------------------------------------
def txt(t, x, y, anchor="start", fill=SILVER, size=18, italic=False, weight="normal", ls=0):
    t = t.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
    st = ' font-style="italic"' if italic else ''
    lsp = f' letter-spacing="{ls}"' if ls else ''
    svg.append(f'<text x="{x:.0f}" y="{y:.0f}" fill="{fill}" font-size="{size}" text-anchor="{anchor}" font-weight="{weight}"{st}{lsp}>{t}</text>')

txt("STARFALL", 56, 74, size=44, ls=7)
txt("THE STARFALL PLATE — CITY SURVEY · every structure, on the grid", 58, 104, fill=SILVER_DIM, size=16, ls=2)
svg.append(f'<line x1="58" y1="118" x2="720" y2="118" stroke="{GOLD}" stroke-width="1"/>')
plotted = ", ".join(h["name"] for h in detailed)
txt(f"wedges fully plotted: {plotted}", 58, 142, fill=GOLD, size=16, italic=True)

svg.append(f'<g transform="translate({CX*2-120},150)">')
svg.append(f'<circle r="40" fill="none" stroke="{SILVER_DIM}" stroke-width="1"/>')
for ang, tlab in [(0,"-Z"),(90,"+X"),(180,"+Z"),(270,"-X")]:
    a = math.radians(ang-90)
    svg.append(f'<line x1="0" y1="0" x2="{40*math.cos(a):.1f}" y2="{40*math.sin(a):.1f}" stroke="{SILVER}" stroke-width="1"/>')
    svg.append(f'<text x="{52*math.cos(a):.1f}" y="{52*math.sin(a)+5:.1f}" fill="{SILVER_DIM}" font-size="12" text-anchor="middle">{tlab}</text>')
svg.append(f'<circle r="4" fill="{GOLD}"/>')
svg.append(f'<text x="0" y="68" fill="{SILVER_DIM}" font-size="11" text-anchor="middle">+Z = front / causeway · a° from +Z toward +X</text>')
svg.append('</g>')

# --- legend panel (right margin), grouped by house then district -------------
LX = CX*2 + 40
svg.append(f'<line x1="{LX-20}" y1="60" x2="{LX-20}" y2="{H-60}" stroke="{SILVER_DIM}" stroke-width="0.8" opacity="0.5"/>')
DNAME = {d["id"]: d["name"] for d in C["districts"]}
HOUSE = {h["id"]: h for h in C["houses"]}
y = 84
cur_h = None; cur_d = None
for i, s, under in legend:
    hid = s.get("house")
    if hid != cur_h:
        cur_h = hid; cur_d = None
        h = HOUSE[hid]; y += 6
        txt(h["name"].upper(), LX, y, size=19, ls=1)
        y += 18
        txt(f"wedge a° {h['wedge_a'][0]}–{h['wedge_a'][1]} · {h['epithet']}", LX, y, fill=SILVER_DIM, size=12, italic=True)
        y += 18
    if s.get("district") != cur_d:
        cur_d = s.get("district"); y += 4
        txt(DNAME.get(cur_d, cur_d).upper(), LX, y, fill=DISTRICT_EDGE.get(cur_d, SILVER), size=12, weight="bold")
        y += 17
    col = RUST if under else SILVER
    resid = s.get("resident_count", 0)
    txt(f"{i}", LX, y, fill=col, size=12, weight="bold")
    txt(f"{s['name']}", LX+20, y, fill=col, size=12)
    txt(f"{resid}" if resid else "—", CX*2+430, y, anchor="end", fill=SILVER_DIM, size=11)
    y += 16

# the two-maps note
y += 12
svg.append(f'<rect x="{LX-6}" y="{y-16}" width="470" height="94" fill="{RUST_DIM}" opacity="0.12"/>')
txt("THE OTHER MAP", LX, y, fill=RUST, size=14, weight="bold", ls=1)
for k, line in enumerate([
    "The dashed rust footprints are the Under-Terraces —",
    "barge locks, conduit galleries, cisterns, bunk-halls.",
    "They sit beneath the pretty rings and appear on no",
    "official plate. That omission is the story of Part One."]):
    txt(line, LX, y + 22 + k*16, fill=RUST_DIM, size=12, italic=True)

# --- scale bar + computed totals ---------------------------------------------
svg.append(f'<g transform="translate(58,{H-70})">')
svg.append(f'<line x1="0" y1="0" x2="{200*PXM:.0f}" y2="0" stroke="{SILVER}" stroke-width="2"/>')
for k in range(3):
    svg.append(f'<line x1="{k*100*PXM:.0f}" y1="-5" x2="{k*100*PXM:.0f}" y2="5" stroke="{SILVER}" stroke-width="2"/>')
txt("0", 0, 22, "middle", SILVER_DIM, 12); txt("100 m", 100*PXM, 22, "middle", SILVER_DIM, 12)
txt("200 m", 200*PXM, 22, "middle", SILVER_DIM, 12)
txt(f"City ⌀ ≈ 900 m · grid rings every 50 m · pop. target {C['meta']['population_target']:,}", 0, 42, "start", SILVER_DIM, 12, italic=True)
svg.append('</g>')

total = sum(s.get("resident_count", 0) for s in structs)
under_total = sum(s.get("resident_count", 0) for s in structs if s.get("district") == "D-UNDER")
txt(f"{len(detailed)} of 9 wedges plotted · ≈ {total:,} souls placed here, {under_total} of them below in the Under-Terraces.",
    58, H-92, fill=SILVER_DIM, size=13, italic=True)

svg.append('</svg>')

os.makedirs(OUT, exist_ok=True)
path = os.path.join(OUT, "Starfall_CityPlan.svg")
with open(path, "w", encoding="utf-8") as f:
    f.write("\n".join(svg))
print("wrote", path, f"({len(structs)} structures across {len(detailed)} wedges)")
