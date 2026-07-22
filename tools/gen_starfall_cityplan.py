#!/usr/bin/env python3
"""Starfall City Plan — the gridded topographical survey of the WHOLE city,
generated from the per-wedge source of truth (build_city.load_city()).

The "Starfall Plate" register (silver-white linework on indigo-black, antique gold
for the important marks), with a metric survey grid, all nine House wedges + the
Academy island plotted structure-by-structure as district-coloured footprints, the
nine wedges delineated, and the Under-Terraces drawn beneath as the dashed "Other
Map" the official plate omits. Per-structure detail lives in the Codex; this is the
city at a glance. Geometry LOCKED to godot/threed/StarfallCity3D.gd.

Re-runnable:  python tools/gen_starfall_cityplan.py
Output: art/blueprints/Starfall_CityPlan.svg
"""
import math
import os
import random

import build_city

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "art", "blueprints")

C = build_city.load_city()
G = C["geometry_locked"]

# --- palette -----------------------------------------------------------------
BG = "#0a0e20"; INK = "#0d1226"; SILVER = "#c7d3ec"; SILVER_DIM = "#6f7ba0"
GOLD = "#caa24a"; GREEN = "#5f8f7a"; DEAD = "#1a1f38"
RUST = "#b06a3a"; RUST_DIM = "#7a4a2c"
DISTRICT_FILL = {
    "D-RIM": "#3a3320", "D-UPPER": "#20264a", "D-MID": "#1b2040", "D-CANAL": "#1d2c50",
    "D-SHORE": "#181d38", "D-UNDER": "#2a180e", "D-ACADEMY": "#123028",
}
DISTRICT_EDGE = {
    "D-RIM": GOLD, "D-UPPER": SILVER, "D-MID": SILVER_DIM, "D-CANAL": "#4f77c0",
    "D-SHORE": SILVER, "D-UNDER": RUST, "D-ACADEMY": GREEN,
}
DISTRICT_KEY = [
    ("D-RIM", "Rim / House seats"), ("D-UPPER", "Upper terraces (sightlines)"),
    ("D-MID", "Middle terraces (guilds)"), ("D-CANAL", "Canal quarter"),
    ("D-SHORE", "Shore & gates"), ("D-ACADEMY", "The Academy (island)"),
    ("D-UNDER", "Under-Terraces (the Other Map)"),
]

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
    return pol(r_m, 180 - a_deg)

svg = []
svg.append(f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}" '
           f'font-family="Georgia, \'Times New Roman\', serif">')
svg.append(f'<rect width="{W}" height="{H}" fill="{BG}"/>')

random.seed(11)
svg.append('<g opacity="0.42">')
for _ in range(1200):
    a = random.uniform(0, 360); r = random.uniform(R_L1 + 6, R_L1 + 66)
    x, y = pol(r, a)
    if 0 < x < CX*2 and 0 < y < H:
        svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.4,1.3):.1f}" fill="{SILVER_DIM}"/>')
svg.append('</g>')

def band(r_out, fill):
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_out):.1f}" fill="{fill}"/>')
band(R_L1, "#141930"); band(R_L2, "#161b34"); band(R_L3, "#181d38")
band(R_L4, "#10142a"); band(R_SHORE, "#0b0f1e")

svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_LAKE):.1f}" fill="#05060f"/>')
random.seed(7)
for _ in range(720):
    a = random.uniform(0, 360); r = random.uniform(0, R_LAKE - 0.4)
    x, y = pol(r, a); b = random.randint(150, 255)
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="{random.uniform(0.3,1.2):.1f}" '
               f'fill="rgb({b},{b},255)" opacity="{random.uniform(0.4,1):.2f}"/>')

# --- metric survey grid ------------------------------------------------------
svg.append('<g opacity="0.26">')
r = 50
while r <= R_L1 + 60:
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r):.1f}" fill="none" stroke="{SILVER_DIM}" '
               f'stroke-width="0.7" stroke-dasharray="2 4"/>')
    r += 50
for sd in range(0, 360, 15):
    x2, y2 = pol(R_L1 + 55, sd)
    svg.append(f'<line x1="{CX}" y1="{CY}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{SILVER_DIM}" '
               f'stroke-width="0.55" stroke-dasharray="2 5"/>')
svg.append('</g>')
for rr in (100, 200, 300, 400):
    x, y = pol(rr, 0)
    svg.append(f'<text x="{x+4:.0f}" y="{y-3:.0f}" fill="{SILVER_DIM}" font-size="12">{rr} m</text>')

def ring(r_m, stroke=SILVER, wd=1.4, op=1.0):
    svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(r_m):.1f}" fill="none" stroke="{stroke}" '
               f'stroke-width="{wd}" opacity="{op}"/>')
ring(R_L1, SILVER, 2.2); ring(R_L2); ring(R_L3); ring(R_L4)
ring(R_SHORE, SILVER, 1.8); ring(R_LAKE, GOLD, 1.2, 0.8)

# --- wedge boundary radials (delineate the nine Houses) ----------------------
for bnd in range(0, 360, 40):
    x1, y1 = wpol(R_SHORE, bnd); x2, y2 = wpol(R_L1 + 16, bnd)
    svg.append(f'<line x1="{x1:.1f}" y1="{y1:.1f}" x2="{x2:.1f}" y2="{y2:.1f}" stroke="{GOLD}" '
               f'stroke-width="0.9" stroke-dasharray="5 5" opacity="0.4"/>')

# --- plot every structure as a district-coloured footprint -------------------
def radial_rect(cx, cy, w_m, d_m, dashed, fill, edge, op):
    ang = math.atan2(cy - CY, cx - CX)
    ur = (math.cos(ang), math.sin(ang)); ut = (-math.sin(ang), math.cos(ang))
    hr = rp(d_m) / 2; ht = rp(w_m) / 2
    pts = []
    for sr, st in ((1,1),(1,-1),(-1,-1),(-1,1)):
        pts.append(f"{cx+sr*hr*ur[0]+st*ht*ut[0]:.1f},{cy+sr*hr*ur[1]+st*ht*ut[1]:.1f}")
    dash = ' stroke-dasharray="3 2"' if dashed else ''
    svg.append(f'<polygon points="{" ".join(pts)}" fill="{fill}" stroke="{edge}" stroke-width="0.9"{dash} opacity="{op}"/>')

HTOWER = {h["id"]: h["tower_a_deg"] for h in C["houses"]}
# draw under-terraces first (beneath), then above-ground on top
for pss in ("under", "over"):
    for s in C["structures"]:
        did = s.get("district", "D-MID"); under = did == "D-UNDER"
        if (pss == "under") != under:
            continue
        pos = s["position"]; fp = s.get("footprint", {})
        a = pos.get("a_deg", HTOWER.get(s.get("house"), 20)); r = pos.get("r", 300)
        cx, cy = wpol(r, a)
        fill = DISTRICT_FILL.get(did, "#222"); edge = DISTRICT_EDGE.get(did, SILVER)
        if fp.get("shape") == "cylinder":
            svg.append(f'<circle cx="{cx:.1f}" cy="{cy:.1f}" r="{rp(fp.get("diameter",10)/2):.1f}" '
                       f'fill="{fill}" stroke="{edge}" stroke-width="1.1"/>')
        elif fp.get("length"):
            radial_rect(cx, cy, fp.get("width", 6), fp.get("length", 40), under, fill, edge, 0.85)
        else:
            radial_rect(cx, cy, fp.get("w", 10), fp.get("d", 10), under, fill, edge, 0.9)

# --- towers + House labels ---------------------------------------------------
for h in C["houses"]:
    a = h["tower_a_deg"]; x, y = wpol(R_TOWER, a)
    dead = h["status"] == "dead"
    edge = SILVER_DIM if dead else GOLD
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="13" fill="{DEAD if dead else INK}" stroke="{edge}" stroke-width="2"/>')
    svg.append(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="6" fill="none" stroke="{edge}" stroke-width="1"/>')
    if dead:
        svg.append(f'<line x1="{x-14:.1f}" y1="{y-14:.1f}" x2="{x+14:.1f}" y2="{y+14:.1f}" stroke="{SILVER_DIM}" stroke-width="1.3"/>')
    lx, ly = wpol(R_TOWER + 32, a)
    svg.append(f'<text x="{lx:.0f}" y="{ly:.0f}" fill="{edge}" font-size="12" text-anchor="middle">{h["name"].replace("House ","H. ")}</text>')

# --- causeway + academy dome + label -----------------------------------------
t0 = wpol(R_ISLAND, 0); t1 = wpol(R_SHORE, 0)
svg.append(f'<line x1="{t0[0]:.1f}" y1="{t0[1]:.1f}" x2="{t1[0]:.1f}" y2="{t1[1]:.1f}" stroke="{SILVER}" stroke-width="6"/>')
svg.append(f'<line x1="{t0[0]:.1f}" y1="{t0[1]:.1f}" x2="{t1[0]:.1f}" y2="{t1[1]:.1f}" stroke="{GOLD}" stroke-width="1.4"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(R_ISLAND):.1f}" fill="none" stroke="{GOLD}" stroke-width="2"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="{rp(22):.1f}" fill="none" stroke="{GREEN}" stroke-width="2.2"/>')
svg.append(f'<circle cx="{CX}" cy="{CY}" r="6" fill="{GOLD}"/>')

# --- title + compass ---------------------------------------------------------
def txt(t, x, y, anchor="start", fill=SILVER, size=18, italic=False, weight="normal", ls=0):
    t = t.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
    st = ' font-style="italic"' if italic else ''
    lsp = f' letter-spacing="{ls}"' if ls else ''
    svg.append(f'<text x="{x:.0f}" y="{y:.0f}" fill="{fill}" font-size="{size}" text-anchor="{anchor}" font-weight="{weight}"{st}{lsp}>{t}</text>')

txt("STARFALL", 56, 74, size=44, ls=7)
txt("THE STARFALL PLATE — FULL CITY SURVEY · nine Houses + the Academy", 58, 104, fill=SILVER_DIM, size=16, ls=2)
svg.append(f'<line x1="58" y1="118" x2="760" y2="118" stroke="{GOLD}" stroke-width="1"/>')
txt("every structure plotted · per-structure detail in the City Codex", 58, 142, fill=GOLD, size=15, italic=True)

svg.append(f'<g transform="translate({CX*2-118},150)">')
svg.append(f'<circle r="40" fill="none" stroke="{SILVER_DIM}" stroke-width="1"/>')
for ang, tlab in [(0,"-Z"),(90,"+X"),(180,"+Z"),(270,"-X")]:
    a = math.radians(ang-90)
    svg.append(f'<line x1="0" y1="0" x2="{40*math.cos(a):.1f}" y2="{40*math.sin(a):.1f}" stroke="{SILVER}" stroke-width="1"/>')
    svg.append(f'<text x="{52*math.cos(a):.1f}" y="{52*math.sin(a)+5:.1f}" fill="{SILVER_DIM}" font-size="12" text-anchor="middle">{tlab}</text>')
svg.append(f'<circle r="4" fill="{GOLD}"/>')
svg.append(f'<text x="0" y="66" fill="{SILVER_DIM}" font-size="11" text-anchor="middle">+Z = front / causeway</text>')
svg.append('</g>')

# --- right panel: district key + House summary -------------------------------
LX = CX*2 + 40
svg.append(f'<line x1="{LX-20}" y1="60" x2="{LX-20}" y2="{H-60}" stroke="{SILVER_DIM}" stroke-width="0.8" opacity="0.5"/>')

y = 92
txt("DISTRICTS", LX, y, size=18, ls=2); y += 26
for did, label in DISTRICT_KEY:
    swf = DISTRICT_FILL[did]; swe = DISTRICT_EDGE[did]
    dash = ' stroke-dasharray="3 2"' if did == "D-UNDER" else ''
    svg.append(f'<rect x="{LX}" y="{y-12}" width="22" height="14" fill="{swf}" stroke="{swe}" stroke-width="1"{dash}/>')
    txt(label, LX+32, y, fill=SILVER_DIM, size=13); y += 22

y += 16
txt("THE NINE HOUSES + THE ACADEMY", LX, y, size=17, ls=1); y += 8
svg.append(f'<line x1="{LX}" y1="{y}" x2="{LX+430}" y2="{y}" stroke="{SILVER_DIM}" stroke-width="0.6"/>'); y += 22
txt("House", LX, y, fill=SILVER_DIM, size=12)
txt("bldgs", LX+300, y, anchor="end", fill=SILVER_DIM, size=12)
txt("souls", LX+430, y, anchor="end", fill=SILVER_DIM, size=12); y += 20

def souls(structs): return sum(s.get("resident_count", 0) for s in structs)
grand = 0
for h in C["houses"]:
    hs = [s for s in C["structures"] if s.get("house") == h["id"]]
    sc = souls(hs); grand += sc
    dead = h["status"] == "dead"
    col = SILVER_DIM if dead else SILVER
    nm = h["name"] + ("  ✦" if dead else "")
    txt(nm, LX, y, fill=col, size=13)
    txt(f"{len(hs)}", LX+300, y, anchor="end", fill=SILVER_DIM, size=12)
    txt(f"{sc}", LX+430, y, anchor="end", fill=col, size=13); y += 19
acad = [s for s in C["structures"] if s.get("house") == "ACADEMY"]
if acad:
    sc = souls(acad); grand += sc
    txt("The Academy (island)", LX, y, fill=GREEN, size=13)
    txt(f"{len(acad)}", LX+300, y, anchor="end", fill=SILVER_DIM, size=12)
    txt(f"{sc}", LX+430, y, anchor="end", fill=GREEN, size=13); y += 19
svg.append(f'<line x1="{LX}" y1="{y-4}" x2="{LX+430}" y2="{y-4}" stroke="{SILVER_DIM}" stroke-width="0.6"/>'); y += 16
txt("CITY TOTAL", LX, y, fill=SILVER, size=14, weight="bold")
txt(f"{len(C['structures'])}", LX+300, y, anchor="end", fill=SILVER, size=13)
txt(f"{grand:,}", LX+430, y, anchor="end", fill=GOLD, size=15, weight="bold"); y += 30

# two-maps note
svg.append(f'<rect x="{LX-6}" y="{y-16}" width="450" height="96" fill="{RUST_DIM}" opacity="0.12"/>')
txt("THE OTHER MAP", LX, y, fill=RUST, size=14, weight="bold", ls=1)
under_total = souls([s for s in C["structures"] if s.get("district") == "D-UNDER"])
for k, line in enumerate([
    f"{under_total:,} of these souls live in the Under-Terraces —",
    "the dashed footprints beneath the rings: barge locks,",
    "conduit galleries, cisterns, bunk-halls. On no official",
    "plate. That omission is the story of Part One."]):
    txt(line, LX, y + 22 + k*16, fill=RUST_DIM, size=12, italic=True)

# --- scale bar + totals line -------------------------------------------------
svg.append(f'<g transform="translate(58,{H-70})">')
svg.append(f'<line x1="0" y1="0" x2="{200*PXM:.0f}" y2="0" stroke="{SILVER}" stroke-width="2"/>')
for k in range(3):
    svg.append(f'<line x1="{k*100*PXM:.0f}" y1="-5" x2="{k*100*PXM:.0f}" y2="5" stroke="{SILVER}" stroke-width="2"/>')
txt("0", 0, 22, "middle", SILVER_DIM, 12); txt("100 m", 100*PXM, 22, "middle", SILVER_DIM, 12)
txt("200 m", 200*PXM, 22, "middle", SILVER_DIM, 12)
txt("City ⌀ ≈ 900 m · grid rings every 50 m", 0, 42, "start", SILVER_DIM, 12, italic=True)
svg.append('</g>')
txt(f"9 Houses + the Academy · {len(C['structures'])} structures · ≈ {grand:,} souls, every one housed "
    f"(target {C['meta']['population_target']:,}).", 58, H-92, fill=SILVER_DIM, size=13, italic=True)

svg.append('</svg>')

os.makedirs(OUT, exist_ok=True)
path = os.path.join(OUT, "Starfall_CityPlan.svg")
with open(path, "w", encoding="utf-8") as f:
    f.write("\n".join(svg))
print("wrote", path, f"({len(C['structures'])} structures, ~{grand:,} souls)")
