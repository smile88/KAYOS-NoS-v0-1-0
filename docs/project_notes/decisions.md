# Architectural Decision Records

### ADR-001: 3D City Population (2026-08-15)

**Context:**
- Replacing greybox layout cylinders with final 3D art (`.glb` assets) across Starfall City.

**Decision:**
- Instantiate all `.glb` assets dynamically in `StarfallCity3D.gd` (`_build_towers`, `_build_from_plan`) at runtime instead of manually placing 200+ models in the editor.

**Alternatives Considered:**
- Hand-placing in editor -> Rejected because it bloats the `.tscn` file to 72MB+ and makes version control a nightmare.

**Consequences:**
- Requires dynamic scaling (`BASE_GLB_SCALE = 30.0`) and dynamic ground snapping (`_snap_to_ground`) to counteract arbitrary 3D asset origins and scales.
