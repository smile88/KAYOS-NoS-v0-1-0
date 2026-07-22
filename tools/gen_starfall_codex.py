#!/usr/bin/env python3
"""Starfall City Codex — the human-readable book of the city, generated from the
single source of truth docs/city/starfall_city.json.

Every structure, its purpose, dimensions, rooms and occupants; every NPC's home;
the districts, the Nine Houses, and the two-maps theme. Change the JSON, re-run
this, and the doc agrees with the map (tools/gen_starfall_cityplan.py) and the
world (godot/threed/StarfallCity3D.gd) — one geometry, three outputs.

Handles any number of fully-specified ("detailed") House wedges; population
tallies are COMPUTED from each structure's resident_count, so they never drift.

Re-runnable:  python tools/gen_starfall_codex.py
Output: docs/Starfall_City_Codex.md
"""
import os

import build_city

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "docs", "Starfall_City_Codex.md")

C = build_city.load_city()

L = []
def w(s=""):
    L.append(s)

NPC = {n["id"]: n for n in C["npcs"]}
S_HOUSE = {s["id"]: s.get("house") for s in C["structures"]}
SID_NAME = {s["id"]: s["name"] for s in C["structures"]}
ORDER = ["D-RIM", "D-UPPER", "D-MID", "D-CANAL", "D-SHORE", "D-UNDER"]
DNAME = {d["id"]: d["name"] for d in C["districts"]}
BAND = {"D-RIM": "Rim / House seat", "D-UPPER": "Upper terraces", "D-MID": "Middle terraces",
        "D-CANAL": "Canal quarter", "D-SHORE": "Shore", "D-UNDER": "Under-Terraces"}

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
w("| ID | District | Kind | Radius (m) | Top y |")
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
  "One is dead. Houses marked ★ are fully specified below; the rest are stubbed (name, domain, wedge) and "
  "rolled out next. Wedges are deliberately *not* clones — each takes its social texture from its "
  "celestial domain (see the design note at the end).")
w()
w("| ID | House | Epithet | Domain | Tower a° | Wedge a° | Status |")
w("|---|---|---|---|---|---|---|")
for h in C["houses"]:
    det = " ★" if h.get("detailed") else ""
    dom = h['domain'][:58] + ("…" if len(h['domain']) > 58 else "")
    w(f"| {h['id']} | {h['name']}{det} | {h['epithet']} | {dom} | {h['tower_a_deg']} | "
      f"{h['wedge_a'][0]}–{h['wedge_a'][1]} | {h['status']} |")
w()
for h in C["houses"]:
    w(f"### {h['name']} — *{h['epithet']}* ({h['id']})")
    w(f"- **Domain:** {h['domain']}")
    w(f"- **Sigil:** {h['sigil']}")
    w(f"- **Wedge:** a° {h['wedge_a'][0]}–{h['wedge_a'][1]}, tower at a° {h['tower_a_deg']} · **{h['status']}**"
      + ("  ·  ★ fully specified" if h.get("detailed") else ""))
    if h.get("note"):
        w(f"- **Note:** {h['note']}")
    w()

# --- each detailed wedge -----------------------------------------------------
detailed = [h for h in C["houses"] if h.get("detailed")]
city_total = 0
for house in detailed:
    structs = [s for s in C["structures"] if s.get("house") == house["id"]]
    w(f"## {house['name']} — *{house['epithet']}* — structure by structure")
    w()
    w("Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives or "
      "works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.")
    w()
    for did in ORDER:
        ds = [s for s in structs if s.get("district") == did]
        if not ds:
            continue
        w(f"### {DNAME.get(did, did)}")
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
                names = [NPC[o]["name"] if o in NPC else o for o in occ]
                w("**Occupants:** " + "; ".join(names) + ".")
                w()
            if s.get("notes"):
                w(f"> {s['notes']}")
                w()

    # roster for this house (npcs whose home structure belongs to it)
    w(f"### Who lives here — the {house['name']} roster")
    w()
    w("Every NPC has a home. Named principals carry canon codes where they are canonical characters.")
    w()
    w("| NPC | Race | Role | Home | Works |")
    w("|---|---|---|---|---|")
    roster = [n for n in C["npcs"] if S_HOUSE.get(n.get("home")) == house["id"]]
    for n in roster:
        home = SID_NAME.get(n.get("home", ""), n.get("home", ""))
        work = SID_NAME.get(n.get("work", ""), n.get("work", "") or "—")
        cnt = f" (×{n['count']})" if n.get("count") else ""
        canon = f" — *{n['canon']}*" if n.get("canon") else ""
        w(f"| {n['name']}{cnt}{canon} | {n['race']} | {n['role']} | {home} | {work} |")
    w()

    # computed tally
    bands = {}
    for s in structs:
        bands[s.get("district")] = bands.get(s.get("district"), 0) + s.get("resident_count", 0)
    tot = sum(bands.values())
    city_total += tot
    under = bands.get("D-UNDER", 0)
    w(f"### Population — {house['name']} (computed)")
    w()
    w("| Band | Souls |")
    w("|---|---|")
    for did in ORDER:
        if did in bands:
            w(f"| {BAND.get(did, did)} | {bands[did]} |")
    w(f"| **Total** | **{tot}** |")
    w()
    w(f"> ≈ {tot} souls in this wedge; **{under} of them in the Under-Terraces**, on no official map. "
      f"Target ≈ {C['design_notes']['per_wedge_target']}/wedge for a {m['population_target']:,}-soul city.")
    w()

# --- close -------------------------------------------------------------------
remaining = [h["name"] for h in C["houses"] if not h.get("detailed") and h["status"] != "dead"]
w("---")
w()
w(f"**City so far:** {len(detailed)} of 9 wedges fully specified — **≈ {city_total:,} souls placed, "
  f"every one with a home.** Remaining: {', '.join(remaining)}, the dead House, and the Academy island. "
  f"The schema and generators already carry them — they only need their structures and NPCs authored.")
w()
dn = C.get("design_notes", {})
if dn.get("distinct_wedges"):
    w(f"> **Design note.** {dn['distinct_wedges']}")

with open(OUT, "w", encoding="utf-8") as f:
    f.write("\n".join(L) + "\n")
print("wrote", OUT, f"({len(C['structures'])} structures, {len(C['npcs'])} npc records, "
      f"{len(detailed)} detailed wedges)")
