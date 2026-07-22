#!/usr/bin/env python3
"""Assemble the Starfall city from its base + per-wedge fragments.

The single source of truth is split so many people (or agents) can author wedges
in parallel without touching the same file:

  docs/city/starfall_city.json      — the BASE: meta, grid, geometry, districts,
                                       the nine House stubs, design notes.
  docs/city/wedges/<Hid>.json        — one fragment per fully-authored wedge:
                                       { "house_id", "head_npc", "structures":[...],
                                         "npcs":[...] }.

load_city() merges them into one dict identical in shape to the old monolithic
file, so the generators (gen_starfall_codex.py, gen_starfall_cityplan.py) just do
`import build_city; C = build_city.load_city()`. A house is marked "detailed"
exactly when a fragment exists for it.

Run directly to validate every fragment and print a summary.
"""
import glob
import json
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "docs", "city", "starfall_city.json")
WEDGES = os.path.join(ROOT, "docs", "city", "wedges")

REQUIRED_STRUCT = ("id", "name", "house", "district", "position")
REQUIRED_NPC = ("id", "name", "home")


def load_city(strict=False):
    with open(BASE, encoding="utf-8") as f:
        city = json.load(f)
    city.setdefault("structures", [])
    city.setdefault("npcs", [])
    house_by_id = {h["id"]: h for h in city["houses"]}
    seen_struct, seen_npc = set(), set()

    for fp in sorted(glob.glob(os.path.join(WEDGES, "*.json"))):
        with open(fp, encoding="utf-8") as f:
            frag = json.load(f)
        hid = frag.get("house_id")
        h = house_by_id.get(hid)
        if h is not None:
            h["detailed"] = True
            if frag.get("head_npc"):
                h["head_npc"] = frag["head_npc"]
        elif frag.get("institution"):
            # a non-House institution (the Academy island) — recorded, not a rim wedge
            city.setdefault("institutions", []).append(
                {"id": hid, "head_npc": frag.get("head_npc"), "note": frag.get("note", "")})
        else:
            _warn(strict, f"{os.path.basename(fp)}: unknown house_id {hid!r} (add it to houses, "
                          f"or set \"institution\": true)")
        for s in frag.get("structures", []):
            if s["id"] in seen_struct:
                _warn(strict, f"duplicate structure id {s['id']!r} (in {os.path.basename(fp)})")
            seen_struct.add(s["id"])
            if s.get("house") != hid:
                _warn(strict, f"{os.path.basename(fp)}: structure {s['id']} has house {s.get('house')!r} != {hid}")
            for k in REQUIRED_STRUCT:
                if k not in s:
                    _warn(strict, f"structure {s.get('id','?')} missing {k!r}")
            city["structures"].append(s)
        for n in frag.get("npcs", []):
            if n["id"] in seen_npc:
                _warn(strict, f"duplicate npc id {n['id']!r} (in {os.path.basename(fp)})")
            seen_npc.add(n["id"])
            for k in REQUIRED_NPC:
                if k not in n:
                    _warn(strict, f"npc {n.get('id','?')} missing {k!r}")
            city["npcs"].append(n)
    return city


def _warn(strict, msg):
    if strict:
        raise ValueError(msg)
    print("  [WARN]", msg)


if __name__ == "__main__":
    c = load_city()
    detailed = [h for h in c["houses"] if h.get("detailed")]
    total = sum(s.get("resident_count", 0) for s in c["structures"])
    # cross-check: every occupant id resolves, every npc home resolves
    npc_ids = {n["id"] for n in c["npcs"]}
    struct_ids = {s["id"] for s in c["structures"]}
    dangling_occ = sorted({o for s in c["structures"] for o in s.get("occupants", []) if o not in npc_ids})
    dangling_home = sorted({n["id"] for n in c["npcs"]
                            if n.get("home") not in struct_ids and not str(n.get("home", "")).startswith("D-")})
    print(f"assembled: {len(detailed)} detailed wedges, {len(c['structures'])} structures, "
          f"{len(c['npcs'])} npc records, ~{total:,} souls placed")
    if dangling_occ:
        print("  [WARN] occupants with no npc record:", ", ".join(dangling_occ[:12]),
              "…" if len(dangling_occ) > 12 else "")
    if dangling_home:
        print("  [WARN] npcs whose home is not a structure:", ", ".join(dangling_home[:12]),
              "…" if len(dangling_home) > 12 else "")
    if not dangling_occ and not dangling_home:
        print("  cross-refs OK (all occupants & homes resolve)")
