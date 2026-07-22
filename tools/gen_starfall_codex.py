#!/usr/bin/env python3
"""Starfall City Codex — the human-readable book of the city, generated from the
single source of truth docs/city/starfall_city.json.

Every structure, its purpose, dimensions, rooms and occupants; every NPC's home;
the districts, the Nine Houses, and the two-maps theme. Change the JSON, re-run
this, and the doc agrees with the map (tools/gen_starfall_cityplan.py) and the
world (godot/threed/StarfallCity3D.gd) — one geometry, three outputs.

Re-runnable:  python tools/gen_starfall_codex.py
Output: docs/Starfall_City_Codex.md
"""
import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "docs", "city", "starfall_city.json")
OUT = os.path.join(ROOT, "docs", "Starfall_City_Codex.md")

with open(SRC, encoding="utf-8") as f:
    C = json.load(f)

L = []
def w(s=""):
    L.append(s)

m = C["meta"]
w(f"# {m['name']} — City Codex")
w()
w(f"> _Generated from `docs/city/starfall_city.json` by `tools/gen_starfall_codex.py`. "
  f"Do not hand-edit — edit the JSON and re-run. Companion map: `art/blueprints/Starfall_CityPlan.svg`._")
w()
w(f"**{m['subtitle']}**  ")
w(f"*{m['era']}* · population target **{m['population_target']:,}** · {m['culture']}")
w()
w(f"**The theme (read this first).** {m['theme']}")
w()
w(f"**Coordinates.** {m['coordinate_system']}")
w()
w(f"**Status.** {m['status']}")
w()

# --- districts ---------------------------------------------------------------
w("## Districts")
w()
w("| ID | District | Kind | Radius (m) | Top y | ")
w("|---|---|---|---|---|")
for d in C["districts"]:
    r = d.get("r", ["", ""])
    w(f"| {d['id']} | {d['name']} | {d['kind']} | {r[0]}–{r[1]} | {d.get('y_top','')} |")
w()
for d in C["districts"]:
    w(f"- **{d['name']}** ({d['id']}) — {d['desc']}")
w()

# --- the nine houses ---------------------------------------------------------
w("## The Nine Houses of the Rim")
w()
w("Each rim observatory tower is a House — an astronomical dynasty that owns the wedge of city below it. "
  "One is dead. The exemplar wedge fully specified below is **House Vael'Suran**; the other eight are "
  "stubbed (name, domain, wedge) and rolled out next.")
w()
w("| ID | House | Epithet | Domain | Tower a° | Wedge a° | Status |")
w("|---|---|---|---|---|---|---|")
for h in C["houses"]:
    wa = h["wedge_a"]
    det = " ★" if h.get("detailed") else ""
    w(f"| {h['id']} | {h['name']}{det} | {h['epithet']} | {h['domain'][:60]}… | {h['tower_a_deg']} | {wa[0]}–{wa[1]} | {h['status']} |")
w()
w("★ = fully specified this pass.")
w()
for h in C["houses"]:
    w(f"### {h['name']} — *{h['epithet']}* ({h['id']})")
    w(f"- **Domain:** {h['domain']}")
    w(f"- **Sigil:** {h['sigil']}")
    w(f"- **Wedge:** a° {h['wedge_a'][0]}–{h['wedge_a'][1]}, tower at a° {h['tower_a_deg']} · **{h['status']}**")
    if h.get("note"):
        w(f"- **Note:** {h['note']}")
    w()

# --- structures of the detailed wedge ---------------------------------------
det_house = next(h for h in C["houses"] if h.get("detailed"))
w(f"## {det_house['name']} — the exemplar wedge, structure by structure")
w()
w(f"Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or "
  f"works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.")
w()

# index npcs for lookup
NPC = {n["id"]: n for n in C["npcs"]}

# group structures by district in a sensible order
order = ["D-RIM", "D-UPPER", "D-MID", "D-CANAL", "D-SHORE", "D-UNDER"]
dname = {d["id"]: d["name"] for d in C["districts"]}
structs = [s for s in C["structures"] if s.get("house") == det_house["id"]]
for did in order:
    ds = [s for s in structs if s.get("district") == did]
    if not ds:
        continue
    w(f"### {dname.get(did, did)}")
    w()
    for s in ds:
        pos = s.get("position", {})
        fp = s.get("footprint", {})
        coord = f"r {pos.get('r','?')} m, a° {pos.get('a_deg','?')}"
        if pos.get("world_xz"):
            coord += f" (world x,z = {pos['world_xz'][0]}, {pos['world_xz'][1]})"
        if fp.get("shape") == "cylinder":
            dims = f"⌀{fp.get('diameter','?')} m"
        elif fp.get("length"):
            dims = f"{fp.get('length','?')}×{fp.get('width','?')} m"
        else:
            dims = f"{fp.get('w','?')}×{fp.get('d','?')} m"
        hite = f"h {s.get('height_m','?')} m" + (f", {s['storeys']} storeys" if s.get("storeys") else "")
        w(f"#### {s['id']} · {s['name']}")
        w(f"*{s.get('type','')}* — **{coord}**, footprint **{dims}**, {hite}, base y {s.get('y_base','?')}. "
          f"Residents: **{s.get('resident_count', 0)}**.")
        w()
        w(s.get("purpose", ""))
        w()
        if s.get("rooms"):
            w("| Room | Size (m) | Purpose |")
            w("|---|---|---|")
            for rm in s["rooms"]:
                sz = f"{rm.get('w','?')}×{rm.get('d','?')}×{rm.get('h','?')}"
                w(f"| {rm['name']} | {sz} | {rm.get('purpose','')} |")
            w()
        occ = s.get("occupants", [])
        if occ:
            names = []
            for oid in occ:
                n = NPC.get(oid)
                names.append(f"{n['name']}" if n else oid)
            w(f"**Occupants:** " + "; ".join(names) + ".")
            w()
        if s.get("notes"):
            w(f"> {s['notes']}")
            w()

# --- npc roster --------------------------------------------------------------
w(f"## Who lives here — the {det_house['name']} roster")
w()
w("Every NPC has a home. Named principals carry canon codes where they are canonical characters.")
w()
w("| NPC | Race | Role | Home | Works |")
w("|---|---|---|---|---|")
sid_name = {s["id"]: s["name"] for s in C["structures"]}
for n in C["npcs"]:
    home = sid_name.get(n.get("home",""), n.get("home",""))
    work = sid_name.get(n.get("work",""), n.get("work","") or "—")
    cnt = f" (×{n['count']})" if n.get("count") else ""
    canon = f" — *{n['canon']}*" if n.get("canon") else ""
    w(f"| {n['name']}{cnt}{canon} | {n['race']} | {n['role']} | {home} | {work} |")
w()

# --- tally -------------------------------------------------------------------
t = C.get("wedge0_population_tally", {})
if t:
    w("## Population — this wedge")
    w()
    w("| Band | Souls |")
    w("|---|---|")
    for k in ["rim_house", "upper_terraces", "middle_terraces", "canal_quarter", "shore", "under_terraces"]:
        if k in t:
            w(f"| {k.replace('_',' ').title()} | {t[k]} |")
    w(f"| **Total** | **{t.get('total','?')}** |")
    w()
    w(f"> {t.get('note','')}")
    w()

w("---")
w()
w("*Next: roll the same treatment across the other eight Houses (H1–H8), then the Academy island "
  "(D-ACADEMY) and the Mirror/causeway. The generator and schema already carry them — they only need "
  "their structures and NPCs authored.*")

with open(OUT, "w", encoding="utf-8") as f:
    f.write("\n".join(L) + "\n")
print("wrote", OUT, f"({len(C['structures'])} structures, {len(C['npcs'])} npc records)")
