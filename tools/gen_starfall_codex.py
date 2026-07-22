#!/usr/bin/env python3
"""Starfall City Codex — the human-readable book of the city, generated from the
per-wedge source of truth (docs/city/starfall_city.json + docs/city/wedges/*.json,
merged by build_city.load_city()).

Every structure, its purpose, dimensions, rooms and occupants; every NPC's home;
the districts, the Nine Houses, the Academy island, and the two-maps theme.
Population tallies are COMPUTED from each structure's resident_count, so they never
drift. Change the data, re-run this, and the doc agrees with the map and the world.

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
ORDER = ["D-RIM", "D-UPPER", "D-MID", "D-CANAL", "D-SHORE", "D-UNDER", "D-ACADEMY"]
DNAME = {d["id"]: d["name"] for d in C["districts"]}
BAND = {"D-RIM": "Rim / House seat", "D-UPPER": "Upper terraces", "D-MID": "Middle terraces",
        "D-CANAL": "Canal quarter", "D-SHORE": "Shore", "D-UNDER": "Under-Terraces",
        "D-ACADEMY": "The island"}


def render_group(title, subtitle, structs):
    """Emit one group (a House wedge, or the Academy) — structures, roster, tally.
    Returns its computed soul total."""
    w(f"## {title}")
    if subtitle:
        w(f"*{subtitle}*")
    w()
    w("Every structure below is bespoke: coordinates, footprint, purpose, rooms, and exactly who lives "
      "or works in it. Grouped by district, rim inward, then down into the Under-Terraces the Plate omits.")
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

    ids = {s["id"] for s in structs}
    roster = [n for n in C["npcs"] if n.get("home") in ids]
    w(f"### Who lives here — roster ({len(roster)} records)")
    w()
    w("| NPC | Race | Role | Home | Works |")
    w("|---|---|---|---|---|")
    for n in roster:
        home = SID_NAME.get(n.get("home", ""), n.get("home", ""))
        work = SID_NAME.get(n.get("work", ""), n.get("work", "") or "—")
        cnt = f" (×{n['count']})" if n.get("count") else ""
        canon = f" — *{n['canon']}*" if n.get("canon") else ""
        w(f"| {n['name']}{cnt}{canon} | {n['race']} | {n['role']} | {home} | {work} |")
    w()

    bands = {}
    for s in structs:
        bands[s.get("district")] = bands.get(s.get("district"), 0) + s.get("resident_count", 0)
    tot = sum(bands.values())
    under = bands.get("D-UNDER", 0)
    w("| Band | Souls |")
    w("|---|---|")
    for did in ORDER:
        if did in bands:
            w(f"| {BAND.get(did, did)} | {bands[did]} |")
    w(f"| **Total** | **{tot}** |")
    w()
    if under:
        w(f"> ≈ {tot} souls here; **{under} of them in the Under-Terraces**, on no official map.")
        w()
    return tot


# --- header ------------------------------------------------------------------
m = C["meta"]
w(f"# {m['name']} — City Codex")
w()
w(f"> _Generated from `docs/city/starfall_city.json` + `docs/city/wedges/*.json` by "
  f"`tools/gen_starfall_codex.py` (via `build_city.py`). Do not hand-edit — edit the data and re-run. "
  f"Companion map: `art/blueprints/Starfall_CityPlan.svg`._")
w()
w(f"**{m['subtitle']}**  ")
w(f"*{m['era']}* · population target **{m['population_target']:,}** · {m['culture']}")
w()
w(f"**The theme (read this first).** {m['theme']}")
w()
w(f"**Coordinates.** {m['coordinate_system']}")
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
  "One is dead. Wedges are deliberately *not* clones — each takes its social texture from its celestial "
  "domain.")
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
    w(f"- **Wedge:** a° {h['wedge_a'][0]}–{h['wedge_a'][1]}, tower at a° {h['tower_a_deg']} · **{h['status']}**")
    if h.get("note"):
        w(f"- **Note:** {h['note']}")
    w()

# --- each wedge, then the Academy --------------------------------------------
city_total = 0
by_house = {h["id"]: h for h in C["houses"]}
for h in C["houses"]:
    if not h.get("detailed"):
        continue
    structs = [s for s in C["structures"] if s.get("house") == h["id"]]
    city_total += render_group(f"{h['name']} — *{h['epithet']}*", "structure by structure", structs)

acad = [s for s in C["structures"] if s.get("house") == "ACADEMY"]
if acad:
    city_total += render_group("The Academy of Astral Harmony (island)",
                               "the central institution — where Elorin works and the Nullstone is designed", acad)

# --- close -------------------------------------------------------------------
n_wedges = sum(1 for h in C["houses"] if h.get("detailed"))
w("---")
w()
w(f"**City complete: {n_wedges} of 9 House wedges + the Academy island fully specified — "
  f"{len(C['structures'])} structures, {len(C['npcs'])} NPC records, ≈ {city_total:,} souls placed, "
  f"every one with a home.** (Target {m['population_target']:,}.)")
w()
dn = C.get("design_notes", {})
if dn.get("distinct_wedges"):
    w(f"> **Design note.** {dn['distinct_wedges']}")

with open(OUT, "w", encoding="utf-8") as f:
    f.write("\n".join(L) + "\n")
print("wrote", OUT, f"({len(C['structures'])} structures, {len(C['npcs'])} npc records, "
      f"{n_wedges} wedges + academy, ~{city_total:,} souls)")
