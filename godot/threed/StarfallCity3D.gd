@tool
extends Zone3D
class_name StarfallCity3D
## The whole exterior of Starfall as a walkable HD-2D greybox — built TO SCALE (see docs/Scale_Reference.md
## and art/blueprints/Starfall_Blueprint.svg; all three share one geometry). Starfall is a ~900 m volcanic
## caldera above the clouds: concentric terraces stepping DOWN ~46 m to a central star-lake ("the Mirror"),
## nine ~85 m rim observatory towers (one a dead House), a crystal-comb ring, dense habitation quarters,
## a railless causeway, and the Academy island at dead centre crowned by a ~110 m hero observatory that
## dominates the skyline. +Z is "front": the causeway, the Grand Processional and the player spawn are all
## on the +Z side, so the camera looks inward over the Mirror.
##
## MARKERS, NOT BUILDINGS: this script only builds the macro land shape now — the terraces, the
## Under-Terraces cavity, the lake, the causeway, the entrance cut. (No caldera wall/peak geometry yet —
## a primitive-cone attempt at one looked wrong and got pulled rather than shipped half-right; the sky
## dome + cloud sea from `_build_sky()` are what's actually there.) Only three things still get a visual
## marker (see `_marker()`): the nine House towers, the Great Observatory's centre point (also the
## city's own centre), and the armillary monument — everything else (every plan building, every
## scattered prop, the gate, the Academy's wings/vault/moon-bridge/fountain) is entirely hand-placed now,
## no positional guidance drawn. Examine text for all of it still comes from the one JSON source of
## truth (`docs/city/*.json` → `PLAN_PATH`) even without a marker — that's writing, not clutter.
##
## Walkable for real, minus connectors: terraces are solid collision (retaining-wall boxes), but there
## are deliberately NO auto-generated stairs/ramps between levels anymore — hand-place those too. The
## one exception is the entrance cut (below): a flat walkway carved from the rim down to L4, where the
## player spawns, because that gap is structural (it's *absence* of terrace, not a connector on top of one).

# --- LOCKED geometry (metres) — matches Scale_Reference.md & the blueprint --------------------------
const R_ISLAND := 75.0
const R_LAKE := 210.0
const R_SHORE := 225.0
const R_L4 := 285.0    # canal quarter (lowest, densest terrace)
const R_L3 := 340.0
const R_L2 := 395.0
const R_L1 := 450.0    # rim walk / the Nine Towers
const R_TOWER := 422.0

const Y_SHORE := 0.0
const Y_L4 := 12.0
const Y_L3 := 23.0
const Y_L2 := 34.0
const Y_RIM := 45.0
const Y_LAKE := -1.0
const Y_ISLAND := 2.0

const DEAD_TOWER := 6   # which of the nine is the extinguished House

## The Under-Terraces (docs/Starfall_City_Codex.md: `D-UNDER, service/hidden, 200–300, -8`) — the
## "omitted city" beneath the shore/canal quarter. The ShoreRing/CanalRing terrace boxes above already
## stop at bottom_y = -1.0 (see `_build_terraces`), so this cavity's ceiling is already there; this just
## adds the floor at the codex depth and two retaining walls closing its inner/outer edges.
const Y_UNDER := -8.0
const R_UNDER_IN := 200.0
const R_UNDER_OUT := 300.0

## The entrance cut: a flat walkway carved through the RIM/L2/L3 terraces (down to L4, per direction —
## "the fourth layer down... right before the water/observatory layer") on the +Z spoke, where the
## player spawns. Width matches the existing "Grand Processional" examine text verbatim ("twenty-six
## paces broad" ≈ 20 m) — not a new number, the lore already specified this route.
const ENTRANCE_WIDTH := 20.0
const ENTRANCE_HALF_WIDTH := ENTRANCE_WIDTH * 0.5

## Where the player drops in: at the outer end of the entrance walkway, on the rim's own footprint but
## at the walkway's L4 height (there is no RIM terrace surface left at this angle — it's the cut).
const SPAWN := Vector3(0, Y_L4 + 0.6, R_L1 - 10.0)

## MultiMesh pools for the repeated, NON-collidable decoration (building windows/doors/roofs, crystal
## combs, canal water). Each pool draws thousands of identical bits in ONE draw call instead of one
## MeshInstance3D per bit — the perf budget lives or dies on this. Collidable geometry (terraces, stairs,
## building bodies, towers, island) is untouched: it stays real nodes so the player still walks on it.
var _pools := {}
var _unit_box: BoxMesh

# --- Kenney Fantasy Town Kit modules (real textured architecture) -------------
const FTK := "res://assets/ftk/"
const CELL := 3.0                     # metres per Kenney module cell (native module = 1 unit, scaled up)
var _modcache := {}                   # module name -> {mesh, mat} (extracted from the imported .glb, shared)
var _mpools := {}                     # module name -> {mesh, mat, xf:Array[Transform3D]} -> one MultiMesh each
# shared materials for the pooled building dressing (built once in _build_from_plan)
var _win_warm_mat: StandardMaterial3D
var _win_cool_mat: StandardMaterial3D
var _door_mat: StandardMaterial3D
var _roof_mat: StandardMaterial3D
var _trim_mat: StandardMaterial3D    # dressed silver stone: plinths, cornices, pilasters, spires
var _glow_mat: StandardMaterial3D    # emissive rooftop finials


@export var is_baked := false

func _ready() -> void:
	if is_baked:
		return
	if Engine.is_editor_hint():
		_clear_generated_children()
		# _pools/_mpools accumulate transforms across a build pass; without resetting them a
		# second in-editor rebuild would double up every pooled instance even after the old
		# MultiMeshInstance3D nodes are cleared. _modcache is a pure resource cache — safe to keep.
		_pools = {}
		_mpools = {}
	_unit_box = BoxMesh.new()
	_unit_box.size = Vector3.ONE          # every pooled piece is this cube, sized per-instance by scale
	_build_sky()
	_build_lake()
	_build_terraces()        # RIM/L2/L3 now carry a gap at the entrance angle — see _build_entrance
	_build_under_terraces()  # new: the codex's D-UNDER cavity, physically built for the first time
	_build_entrance()        # the flat cut + walls + walkway, down to L4 — no gate marker anymore
	_build_parapet()
	_build_towers()          # still marked (+ the same collision footprint as before)
	_build_canals()          # terrain-like (channels cut into the land), left generated
	_build_from_plan()       # examinable text only now, no visual marker — see the func doc
	_build_shore_plaza()     # the armillary monument marker (shrunk) — moved to L4 per the entrance framing
	_build_causeway()        # terrain-like (the one crossing), left generated; its tiny stair is gone
	_pave_ways()             # road tiles on the causeway + shore plaza — ground finish, left generated
	_build_island()          # island base/plaza stays generated; only the observatory keeps a marker
	_build_open_house()      # examinable text only now, no visual marker
	_build_interactables()
	_spawn_act1_npcs()       # interactive Main Quest & Side Quest NPCs
	_flush_mpools()          # bake every kit module (now just road tiles) into per-type MultiMeshes
	_flush_pools()           # bake pooled decoration (now just canal water) into per-type MultiMeshes


# --- placeholder markers ------------------------------------------------------
## A colour-coded, labelled flat disc standing in for a real model that hasn't been hand-placed in the
## editor yet. `radius` should roughly match the real thing's footprint (or, for the observatory/
## monument, just be small — they're centre-points now, not footprints) so scale/position reads
## correctly. The label floats above on a billboarded Label3D so it's readable from any angle.
##
## Trimmed to only what's still marked (per direction): the nine House towers, the Great Observatory's
## centre point (which doubles as the city's own centre marker), and the armillary monument. Every
## other building/prop/the gate/wings/vault/moon-bridge/fountain lost its visual marker — placed by
## hand, no guidance wanted — though examine text (where any existed) stays, since that's writing, not
## clutter that needed clearing.
const MARKER_COLORS := {
	"tower": Color(0.95, 0.78, 0.25),
	"monument": Color(0.95, 0.30, 0.75),
}


func _marker(pos: Vector3, radius: float, label: String, category: String) -> void:
	var color: Color = MARKER_COLORS.get(category, Color(0.8, 0.8, 0.8))
	var disc := CylinderMesh.new()
	disc.top_radius = maxf(radius, 0.3)
	disc.bottom_radius = disc.top_radius
	disc.height = 0.12
	disc.radial_segments = 20
	var mi := MeshInstance3D.new()
	mi.name = "Marker_" + label.replace(" ", "_").replace("'", "").replace(",", "")
	mi.mesh = disc
	mi.position = pos + Vector3(0, 0.08, 0)
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(color.r, color.g, color.b, 0.55)
	mat.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mat.cull_mode = BaseMaterial3D.CULL_DISABLED
	mi.material_override = mat
	add_child(mi)

	var lbl := Label3D.new()
	lbl.text = label
	lbl.position = Vector3(0, maxf(disc.top_radius * 0.4, 1.8), 0)
	lbl.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	lbl.font_size = 34
	lbl.outline_size = 10
	lbl.modulate = color
	lbl.no_depth_test = false
	mi.add_child(lbl)


# --- data-driven city (the plan made walkable) -------------------------------
## The single assembled city plan (tools/build_city.py writes it from docs/city/*). Each above-ground
## structure gets a labelled marker at its surveyed coordinates — position/footprint are still the one
## JSON source of truth (docs/Starfall_City_Codex.md); only the visual (marker vs. real building) changed.
## The locked shell (terraces, entrance cut, Under-Terraces cavity, lake, causeway, island base) stays
## procedural.
const PLAN_PATH := "res://data/starfall_city.json"


func _build_from_plan() -> void:
	if not FileAccess.file_exists(PLAN_PATH):
		push_warning("Starfall: plan not found at %s — run `python tools/build_city.py`." % PLAN_PATH)
		return
	var data: Variant = JSON.parse_string(FileAccess.get_file_as_string(PLAN_PATH))
	if typeof(data) != TYPE_DICTIONARY or not (data as Dictionary).has("structures"):
		push_warning("Starfall: plan JSON malformed.")
		return
	var placed := 0
	for s in (data as Dictionary)["structures"]:
		if _place_plan_structure(s as Dictionary):
			placed += 1
	print("Starfall: placed %d plan buildings from %s" % [placed, PLAN_PATH])


# --- module plumbing: extract mesh+material from the .glb kit and MultiMesh them ---

## The shared Mesh + colormap Material inside a kit module's imported scene (cached).
func _module_data(name: String) -> Dictionary:
	if not _modcache.has(name):
		var ps := load(FTK + name + ".glb") as PackedScene
		var d := {"mesh": null, "mat": null}
		if ps:
			var inst: Node = ps.instantiate()
			var mi := _find_mesh_instance(inst)
			if mi:
				d["mesh"] = mi.mesh
				d["mat"] = mi.mesh.surface_get_material(0)
				if d["mat"] == null:
					d["mat"] = mi.get_active_material(0)
			inst.queue_free()
		_modcache[name] = d
	return _modcache[name]


## Queue one kit-module instance (by name) at a world transform, into that module's MultiMesh pool.
func _mod(name: String, xf: Transform3D) -> void:
	var md := _module_data(name)
	if md["mesh"] == null:
		return
	if not _mpools.has(name):
		_mpools[name] = {"mesh": md["mesh"], "mat": md["mat"], "xf": []}
	_mpools[name]["xf"].append(xf)


## Darken + cool the bright Kenney colormap toward the Noctari palette (indigo-silver night). The albedo
## texture is kept; a multiply tint on a duplicated material recolours a whole module type at once.
func _noctari_tint(name: String, mat: Material) -> Material:
	if mat == null or not (mat is BaseMaterial3D):
		return mat
	var m: BaseMaterial3D = mat.duplicate()
	var tint: Color
	if "roof" in name:
		tint = Color(0.30, 0.42, 0.44)          # dark verdigris / lead
	elif "tree" in name or "hedge" in name:
		tint = Color(0.24, 0.36, 0.40)           # near-black night foliage
	elif "wood" in name or "stall" in name or "cart" in name:
		tint = Color(0.40, 0.40, 0.52)           # muted timber
	else:
		tint = Color(0.46, 0.52, 0.72)           # cool blue-grey stone
	m.albedo_color = tint
	m.roughness = 0.95
	m.metallic = 0.0
	return m


func _flush_mpools() -> void:
	for name in _mpools:
		var p: Dictionary = _mpools[name]
		var xfs: Array = p["xf"]
		if xfs.is_empty():
			continue
		var mm := MultiMesh.new()
		mm.transform_format = MultiMesh.TRANSFORM_3D
		mm.mesh = p["mesh"]
		mm.instance_count = xfs.size()
		for i in range(xfs.size()):
			mm.set_instance_transform(i, xfs[i])
		var mmi := MultiMeshInstance3D.new()
		mmi.name = "FTK_" + name
		mmi.multimesh = mm
		mmi.material_override = _noctari_tint(name, p["mat"])
		add_child(mmi)


## No visual marker for individual buildings anymore — placed by hand, no positional guidance wanted.
## Still keeps the examinable (text, not a structure) at the JSON-surveyed position for every district
## except the Academy's own pieces (handled in _build_island) and the lake.
func _place_plan_structure(s: Dictionary) -> bool:
	var district: String = s.get("district", "")
	if district in ["D-ACADEMY", "D-MIRROR"]:
		return false
	if s.get("id", "") == "VS-U01":
		return false
	var posd: Dictionary = s.get("position", {})
	var a := deg_to_rad(float(posd.get("a_deg", 0.0)))
	var r := float(posd.get("r", 300.0))
	var pos := Vector3(sin(a) * r, float(s.get("y_base", 0.0)), cos(a) * r)
	var label := str(s.get("name", s.get("id", "?")))
	
	var type_str := str(s.get("type", "")).to_lower()
	var model_path := ""
	if "great house" in type_str:
		model_path = "res://assets/environment_models/misc_background/official_establishment/official_establishment_gen1.glb"
	elif "villa" in type_str or "bunk-hall" in type_str or "tenement" in type_str or "dwelling" in type_str or "terrace" in type_str or "lodging" in type_str or "post" in type_str:
		model_path = "res://assets/environment_models/misc_background/cliffside_multistorey_building/cliffside_multistorey_building_gen1.glb"
	elif "inn" in type_str or "taphouse" in type_str or "canteen" in type_str or "caravanserai" in type_str:
		model_path = "res://assets/environment_models/common_buildings/tea_house/tea_house_gen1.glb"
	elif "market" in type_str or "shop" in type_str:
		model_path = "res://assets/environment_models/common_buildings/magic_emporium/magic_emporium_gen1.glb"
	elif "workshop" in type_str or "manufactory" in type_str or "foundry" in type_str or "forge" in type_str or "press" in type_str:
		model_path = "res://assets/environment_models/misc_background/crystal_forge/crystal_forge_gen1.glb"
	elif "shrine" in type_str or "moon-pool" in type_str or "rotunda" in type_str:
		model_path = "res://assets/environment_models/misc_background/rotunda/rotunda_gen1.glb"
	elif "theatre" in type_str or "hall" in type_str:
		model_path = "res://assets/environment_models/misc_background/outdoor_theatre/outdoor_theatre_gen1.glb"
	elif "bath" in type_str or "wash-house" in type_str or "reservoir" in type_str:
		model_path = "res://assets/environment_models/misc_background/pool_house/pool_house_gen1.glb"
	elif "conduit" in type_str or "waterworks" in type_str or "power source" in type_str:
		model_path = "res://assets/environment_models/misc_background/crystal_power_source/crystal_power_source_gen1.glb"
	elif "gate" in type_str or "threshold" in type_str or "customs" in type_str:
		model_path = "res://assets/environment_models/misc_background/city_gateway/city_gateway_gen1.glb"
	elif "belfry" in type_str or "bell tower" in type_str:
		model_path = "res://assets/environment_models/misc_background/bell_tower/bell_tower_gen1.glb"
	elif "observatory" in type_str:
		model_path = "res://assets/environment_models/misc_background/generic_tower/generic_tower_gen1.glb"
	
	if model_path != "":
		var scene: PackedScene = load(model_path) as PackedScene
		if scene:
			var bldg: Node3D = scene.instantiate()
			bldg.name = "Bldg_" + label.replace(" ", "_").replace("'", "")
			bldg.position = pos
			bldg.rotation.y = a + PI # Face inward to the lake
			var sc := 0.9 + (randi() % 20) * 0.01 # deterministic-ish scale variation
			bldg.scale = Vector3(sc, sc, sc) * BASE_GLB_SCALE
			add_child(bldg)
			_snap_to_ground(bldg)

	var it := Interactable3D.new()
	it.name = "IX_" + str(s.get("id", ""))
	it.display_name = label
	it.examine_text = "%s — %s.\n\n%s" % [label, str(s.get("type", "")), str(s.get("purpose", ""))]
	it.position = pos + Vector3(0, 1.4, 0)
	add_child(it)
	return true


## World transform for a module at local cell-centre (lx,fy,lz), yawed `side` (which face), scaled to CELL.
func _mod_xf(pos: Vector3, fb: Basis, lx: float, fy: float, lz: float, side: float) -> Transform3D:
	var world_pos := pos + fb * Vector3(lx, fy, lz)
	var basis := fb * Basis(Vector3.UP, side).scaled(Vector3(CELL, CELL, CELL))
	return Transform3D(basis, world_pos)


## Pave the causeway and the shore plaza with kit road tiles — the "one stone road" across the Mirror
## (canon) and the plaza at its foot. Straight, flat, central: exactly where square road tiles fit.
func _pave_ways() -> void:
	var idn := Basis()
	# the causeway (x = 0, from island to shore), three tiles wide
	var z := R_ISLAND + 3.0
	while z < R_SHORE - 1.0:
		for xi in [-1.0, 0.0, 1.0]:
			_mod("road", _mod_xf(Vector3(xi * CELL, 0.12, z), idn, 0.0, 0.0, 0.0, 0.0))
		z += CELL
	# the shore plaza at the processional foot (+Z front), a 5-wide apron
	for xi in range(-2, 3):
		for zi in range(0, 5):
			_mod("road", _mod_xf(Vector3(xi * CELL, 0.12, R_SHORE - 2.0 - zi * CELL), idn, 0.0, 0.0, 0.0, 0.0))


# --- MultiMesh decoration pools ----------------------------------------------

## Queue one unit-cube instance, scaled to `size`, yawed by `yaw` (+ optional tilt about X), at world
## `pos`, into the named pool. `mat` is set once per pool on first use.
func _deco(pool: String, size: Vector3, pos: Vector3, yaw: float, mat: Material, tilt := 0.0) -> void:
	if not _pools.has(pool):
		_pools[pool] = {"mat": mat, "xf": []}
	var basis := Basis(Vector3.UP, yaw)
	if tilt != 0.0:
		basis = basis * Basis(Vector3.RIGHT, tilt)
	basis = basis.scaled(size)
	_pools[pool]["xf"].append(Transform3D(basis, pos))


## Queue an instance whose orientation is already a full basis (for pieces tilted off two axes).
func _deco_basis(pool: String, basis: Basis, pos: Vector3, mat: Material) -> void:
	if not _pools.has(pool):
		_pools[pool] = {"mat": mat, "xf": []}
	_pools[pool]["xf"].append(Transform3D(basis, pos))


## Bake each pool into a single MultiMeshInstance3D.
func _flush_pools() -> void:
	for pool in _pools:
		var data: Dictionary = _pools[pool]
		var xfs: Array = data["xf"]
		if xfs.is_empty():
			continue
		var mm := MultiMesh.new()
		mm.transform_format = MultiMesh.TRANSFORM_3D
		mm.mesh = _unit_box
		mm.instance_count = xfs.size()
		for i in range(xfs.size()):
			mm.set_instance_transform(i, xfs[i])
		var mmi := MultiMeshInstance3D.new()
		mmi.name = "MM_" + pool
		mmi.multimesh = mm
		mmi.material_override = data["mat"]
		add_child(mmi)


# --- helpers -----------------------------------------------------------------

static func _dir(a: float) -> Vector3:
	return Vector3(sin(a), 0.0, cos(a))


## A solid annulus of collision boxes = one terrace ring: flat top at `top_y`, dropping to `bottom_y`, so
## the taller outer rings' inner faces become the retaining walls of the terraces below them.
## `gap_half_width` (metres, at this ring's own mid-radius) cuts a wedge out of the ring centred on
## a=0 (+Z, the entrance) — the flanking segments' real side faces become the cut's walls for free.
func _ring(inner_r: float, outer_r: float, top_y: float, bottom_y: float, mat: Material, facet := 40.0, name := "Ring", gap_half_width := 0.0) -> void:
	var mid := (inner_r + outer_r) * 0.5
	var depth := outer_r - inner_r
	var height := top_y - bottom_y
	var n := maxi(32, int(TAU * mid / facet))
	var width := 2.0 * mid * tan(PI / n) * 1.12
	var cy := top_y - height * 0.5
	var gap_half_angle := atan2(gap_half_width, mid) if gap_half_width > 0.0 else 0.0
	for i in range(n):
		var a := i * TAU / n
		if gap_half_angle > 0.0 and absf(wrapf(a, -PI, PI)) < gap_half_angle:
			continue
		var d := _dir(a)
		var box := _box(Vector3(width, height, depth), Vector3(d.x * mid, cy, d.z * mid), mat, name + str(i))
		box.rotation.y = a
		var body := StaticBody3D.new()
		var cs := CollisionShape3D.new()
		var shape := BoxShape3D.new()
		shape.size = Vector3(width, height, depth)
		cs.shape = shape
		body.add_child(cs)
		box.add_child(body)


# --- sky & lake --------------------------------------------------------------

func _build_sky() -> void:
	var sphere := SphereMesh.new()
	sphere.radius = 900.0
	sphere.height = 1800.0
	var mi := MeshInstance3D.new()
	mi.name = "SkyDome"
	mi.mesh = sphere
	var m := StandardMaterial3D.new()
	m.albedo_texture = _tex(ART + "solari_festival_sky.png")
	m.cull_mode = BaseMaterial3D.CULL_FRONT
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mi.material_override = m
	add_child(mi)

	var clouds := PlaneMesh.new()
	clouds.size = Vector2(2400, 2400)
	var ci := MeshInstance3D.new()
	ci.name = "CloudSea"
	ci.mesh = clouds
	ci.position = Vector3(0, -120, 0)
	var cm := StandardMaterial3D.new()
	cm.albedo_color = Color(0.30, 0.32, 0.44)
	cm.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	ci.material_override = cm
	add_child(ci)


func _build_lake() -> void:
	# The Mirror: the caldera lake drawn as sky, not water — a star-field disc with NO floor under it.
	# It is a real drop: step off the shore and you fall through the star-field, and the Player3D
	# (fall_limit set on this scene) fishes you back onto the last solid ground. The railless causeway
	# is the one intended crossing — that danger is the point (see the Causeway examine text).
	var disc := CylinderMesh.new()
	disc.top_radius = R_LAKE
	disc.bottom_radius = R_LAKE
	disc.height = 0.1
	var mi := MeshInstance3D.new()
	mi.name = "Mirror"
	mi.mesh = disc
	mi.position = Vector3(0, Y_LAKE, 0)
	var sm := ShaderMaterial.new()
	var sh: Shader = load("res://art/3d/shaders/star_lake_mirror.gdshader") as Shader
	if sh:
		sm.shader = sh
		mi.material_override = sm
	else:
		var m := StandardMaterial3D.new()
		m.albedo_texture = _tex(ART + "star_dome.png")
		m.uv1_scale = Vector3(6, 6, 1)
		m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
		mi.material_override = m
	add_child(mi)


# --- terraces & stairs -------------------------------------------------------

func _build_terraces() -> void:
	var basalt := _mat(_tex(ART + "basalt.png"), 8.0)
	var slate := _mat(_tex(ART + "noctari_slate.png"), 8.0)
	var twi := _mat(_tex(ART + "twilight_stone.png"), 8.0)
	var cobble := _mat(_tex(ART + "cobblestone.png"), 8.0)
	# RIM/L2/L3 carry the entrance gap (the cut goes down to L4 — see _build_entrance); L4/Shore stay
	# full rings, since the entrance walkway arrives flush with L4's own surface.
	_ring(R_L2, R_L1, Y_RIM, -1.0, slate, 42.0, "RimRing", ENTRANCE_HALF_WIDTH)
	_ring(R_L3, R_L2, Y_L2, -1.0, twi, 40.0, "Terrace2", ENTRANCE_HALF_WIDTH)
	_ring(R_L4, R_L3, Y_L3, -1.0, twi, 38.0, "Terrace3", ENTRANCE_HALF_WIDTH)
	_ring(R_SHORE, R_L4, Y_L4, -1.0, cobble, 36.0, "CanalRing")
	_ring(R_LAKE, R_SHORE, Y_SHORE, -1.0, basalt, 30.0, "ShoreRing")


## The codex's D-UNDER district, built for real for the first time: docs/Starfall_City_Codex.md gives
## exact numbers ("service/hidden, 200–300, -8") — a floor at y=-8 spanning r 200–300, closed off by two
## retaining walls. Its CEILING is already there: ShoreRing/CanalRing above both stop at bottom_y=-1.0,
## so this cavity sits directly under the existing terraces with no extra geometry needed up top.
func _build_under_terraces() -> void:
	var rough := _mat(_tex(ART + "basalt.png"), 6.0)
	rough.albedo_color = Color(0.30, 0.28, 0.26)   # warmer, rougher than the polished terraces above
	_ring(R_UNDER_IN, R_UNDER_OUT, Y_UNDER, Y_UNDER - 2.0, rough, 30.0, "UnderFloor")
	_ring(R_UNDER_IN - 1.4, R_UNDER_IN, -1.0, Y_UNDER, rough, 20.0, "UnderWallIn")
	_ring(R_UNDER_OUT, R_UNDER_OUT + 1.4, -1.0, Y_UNDER, rough, 20.0, "UnderWallOut")


## The one deliberately-built connector: a flat walkway cut from the rim down to L4 on the +Z spoke,
## where the player spawns. Straight along a=0 (world +Z) so it needs no rotation at all — RIM/L2/L3
## already leave this exact wedge empty (ENTRANCE_HALF_WIDTH, see _build_terraces/_build_parapet).
##
## The ring's own segments DON'T reliably meet the walkway's straight edges: RIM's segments are huge
## chords (~47 m wide at this radius — see _ring's facet math) since the ring is coarse out there, so
## excluding "the one segment nearest the gap" leaves an oversized, irregularly-shaped void, not a clean
## 20 m cut — that's the "drop off" on either side. Fix: two explicit straight walls, flush with the
## walkway's own edges, tall enough to cover every terrace height the cut passes through (L3's up through
## the rim's), so they read as one continuous canyon/tunnel wall regardless of what the coarse ring
## segments behind them are doing.
func _build_entrance() -> void:
	var stone := _mat(_tex(ART + "twilight_stone.png"), 8.0)
	var mid_z := (R_L4 + R_L1) * 0.5
	var span := R_L1 - R_L4
	_floor_box(Vector3(ENTRANCE_WIDTH, 1.0, span), Vector3(0, Y_L4 - 0.5, mid_z), stone, "EntranceWalkway")

	var wall_top := Y_RIM + 5.0   # clears the parapet's own top so no ring geometry pokes above it
	var wall_thick := 3.0
	var wall_h := wall_top - Y_L4
	for side: float in [-1.0, 1.0]:
		var wall_x: float = side * (ENTRANCE_HALF_WIDTH + wall_thick * 0.5)
		_floor_box(Vector3(wall_thick, wall_h, span), Vector3(wall_x, Y_L4 + wall_h * 0.5, mid_z), stone,
			"EntranceWall%s" % ("L" if side < 0 else "R"))


func _build_parapet() -> void:
	var stone := _mat(_tex(ART + "noctari_slate.png"), 3.0)
	_ring(R_L1 - 2.0, R_L1, Y_RIM + 3.0, Y_RIM, stone, 24.0, "Parapet", ENTRANCE_HALF_WIDTH)


# --- the nine towers ---------------------------------------------------------

## House names by tower loop index, for the marker labels — DEAD_TOWER's own value doubling as its
## House number confirms index == House number (H*) for all nine. Real models already sit in
## art/environment_models/rim_towers/<slug>/ (H1 Nyx'Talar has none yet) — drag them in over these.
const TOWER_HOUSES := [
	"H0 Vael'Suran", "H1 Nyx'Talar", "H2 Oravelle", "H3 Sabreth", "H4 Ilmyra",
	"H5 Corvane", "H6 Dead House", "H7 Duskmere", "H8 Serenthil",
]

const TOWER_MODELS := [
	"res://assets/environment_models/rim_towers/H0_vael_suran/H0_vael_suran_gen1.glb",
	"res://assets/environment_models/cold_open/tower_of_celestial_harmony/tower_of_celestial_harmony_tall_gen1.glb",
	"res://assets/environment_models/rim_towers/H2_oravelle/H2_oravelle_gen1.glb",
	"res://assets/environment_models/rim_towers/H3_sabreth/H3_sabreth_gen1.glb",
	"res://assets/environment_models/rim_towers/H4_ilmyra/H4_ilmyra_gen1.glb",
	"res://assets/environment_models/rim_towers/H5_corvane/H5_corvane_gen1.glb",
	"res://assets/environment_models/rim_towers/H6_dead_house/H6_dead_house_gen1.glb",
	"res://assets/environment_models/rim_towers/H7_duskmere/H7_duskmere_gen1.glb",
	"res://assets/environment_models/rim_towers/H8_serenthil/H8_serenthil_gen1.glb",
]


const BASE_GLB_SCALE := 30.0

func _build_towers() -> void:
	for i in range(9):
		var a := (i + 0.5) * TAU / 9.0   # half-step offset so the +Z processional falls in a GAP
		var d := _dir(a)
		var base := Vector3(d.x * R_TOWER, Y_RIM, d.z * R_TOWER)
		# Invisible collision cylinder at the tower's real footprint (same as before this pass), so
		# walking the rim already feels right before a real model is dropped in over the marker.
		_invisible_collider_cyl(11.0, 40.0, base + Vector3(0, 20.0, 0), "TowerCollider%d" % i)
		
		var tower_scene: PackedScene = load(TOWER_MODELS[i]) as PackedScene
		if tower_scene:
			var tower: Node3D = tower_scene.instantiate()
			tower.name = "Tower_" + TOWER_HOUSES[i].replace(" ", "_").replace("'", "")
			tower.position = base
			tower.rotation.y = a + PI # point inward
			tower.scale = Vector3.ONE * BASE_GLB_SCALE
			
			# Wedge Signatures
			if i == 0: # Vael'Suran (Scholar/Water): Cyan
				var light := OmniLight3D.new()
				light.light_color = Color(0.2, 0.8, 1.0)
				light.light_energy = 5.0
				light.omni_range = 40.0
				light.position = Vector3(0, 15.0, 0)
				tower.add_child(light)
			elif i == 8: # Serenthil (Industrial/Fire): Amber
				var light := OmniLight3D.new()
				light.light_color = Color(1.0, 0.6, 0.1)
				light.light_energy = 5.0
				light.omni_range = 40.0
				light.position = Vector3(0, 15.0, 0)
				tower.add_child(light)
				
			add_child(tower)
			_snap_to_ground(tower)
		else:
			_marker(base, 11.0, TOWER_HOUSES[i], "tower")


# --- habitation --------------------------------------------------------------

func _build_canals() -> void:
	# Three curved star-water canals threading the canal quarter, each crossed by a stone footbridge.
	var water := _mat(_tex(ART + "canal_water.png"), 6.0, 0.08)
	var stone := _mat(_tex(ART + "stone.png"), 2.0)
	for base_a in [0.7, 2.8, 4.7]:
		for k in range(11):
			var a: float = base_a + (k - 5) * 0.02
			var rr := R_SHORE + 4.0 + k * (R_L4 - R_SHORE - 8.0) / 10.0
			var d := _dir(a)
			_deco("canal", Vector3(6.0, 0.3, 8.0), Vector3(d.x * rr, Y_L4 + 0.2, d.z * rr), a, water)
		var md := _dir(base_a)
		var mr := (R_SHORE + R_L4) * 0.5
		var bridge := _box(Vector3(9.0, 1.0, 5.0), Vector3(md.x * mr, Y_L4 + 1.6, md.z * mr), stone, "Footbridge")
		bridge.rotation.y = base_a


## THE OPEN HOUSE — was a fully enterable room (four walls, ceiling, lectern, hearth light); now a
## marker like everything else, but the lectern's examine text is real writing, not structure, so it
## stays as a standalone examinable at the marker until the real room gets rebuilt around it.
func _build_open_house() -> void:
	var pos := Vector3(30.0, Y_L2, 372.0)   # L2 terrace, beside the processional (in the spoke gap)
	var lect := Interactable3D.new()
	lect.name = "AstronomersLectern"
	lect.display_name = "The Astronomer's Lectern"
	lect.examine_text = "A slanted reading-stand of black wood, a star-chart still pinned to it under a paperweight of raw comb-crystal. The chart is of this very caldera's sky, drawn from this very terrace, and someone has been correcting it in a fine hand for what looks like years — the last correction is dated tonight. Whoever kept it did not finish. They will not, now."
	lect.position = pos + Vector3(0, 1.4, 0)
	add_child(lect)


# --- shore, causeway, island -------------------------------------------------

func _build_shore_plaza() -> void:
	# The armillary monument — moved up from the shore to L4, on the same a=0 axis as the entrance
	# walkway but past where it ends (walkway spans R_L4..R_L1; this sits at R_L4-20, inside L4's own
	# ring), so it's "in line with, but not obstructing" the entrance: the first thing visible in the
	# distance once the player reaches L4, near that level's far edge, per direction.
	var mono_pos := Vector3(0, Y_L4, R_L4 - 20.0)
	var mono_scene := load("res://assets/environment_models/misc_background/celestial_monument/celestial_monument_gen1.glb") as PackedScene
	if mono_scene:
		var monument: Node3D = mono_scene.instantiate()
		monument.name = "ArmillaryMonumentVisual"
		monument.position = mono_pos
		monument.scale = Vector3.ONE * BASE_GLB_SCALE
		add_child(monument)
		_snap_to_ground(monument)
	else:
		_marker(mono_pos, 3.0, "The Armillary of the First Measure", "monument")   # a centre-point, not a footprint

	var mono := Interactable3D.new()
	mono.name = "ArmillaryMonument"
	mono.display_name = "The Armillary of the First Measure"
	mono.examine_text = "A colossal golden orrery on a stepped plinth, three rings the size of ship's wheels hooping a caged star, the whole of it taller than the gatehouses. The Solari raised it where the descent from the rim first opens onto the terraces, so that anyone entering the city would pass the whole heavens in miniature before going further in. The rings still turn, very slowly. Nobody remembers winding them."
	mono.position = mono_pos + Vector3(0, 1.4, 0)
	add_child(mono)


func _build_causeway() -> void:
	# A single railless stone road from the shore straight across the Mirror to the island gate (+Z).
	# The tiny stair up onto the island's 2 m lip is gone (all stairs/ramps are hand-placed now) —
	# there's a small step at the island threshold until one's placed there.
	var marble := _mat(_tex(ART + "solari_marble.png"), 20.0)
	var length := R_SHORE - R_ISLAND
	var mid := (R_SHORE + R_ISLAND) * 0.5
	_floor_box(Vector3(8.0, 0.6, length), Vector3(0, Y_SHORE - 0.3, mid), marble, "Causeway")


func _build_island() -> void:
	# The Academy island at dead centre: the base disc + plaza are the island's actual ground, so they
	# stay generated like any other terrace. Everything that stands ON the island — the hero observatory,
	# the two wings + moon-bridge, the warded vault, the fountain — lost its own marker (hand-placed now),
	# except the observatory's exact centre, which doubles as the marker for the very centre of the city.
	# Collision cylinders for each keep the exact same footprints as before this pass (invisible), so the
	# island still blocks/feels roughly right to walk around before anything real is placed on it.
	var basalt := _mat(_tex(ART + "basalt.png"), 10.0)
	var marble := _mat(_tex(ART + "solari_marble.png"), 20.0)
	_col_cyl(R_ISLAND, 4.0, Vector3(0, Y_ISLAND - 2.0, 0), basalt, "IslandBase")
	var plaza := CylinderMesh.new()
	plaza.top_radius = R_ISLAND
	plaza.bottom_radius = R_ISLAND
	plaza.height = 0.2
	var pmi := MeshInstance3D.new()
	pmi.name = "Plaza"
	pmi.mesh = plaza
	pmi.position = Vector3(0, Y_ISLAND + 0.1, 0)
	pmi.material_override = marble
	add_child(pmi)

	# --- the hero observatory (~110 m per CLAUDE.md) ---
	_invisible_collider_cyl(22.0, 60.0, Vector3(0, Y_ISLAND + 30.0, 0), "ObservatoryCollider")
	_invisible_collider_cyl(2.4, 34.0, Vector3(0, Y_ISLAND + 92.0, 0), "SpireCollider")
	
	var obs_scene := load("res://assets/environment_models/academy/great_observatory/great_observatory_gen1.glb") as PackedScene
	if obs_scene:
		var obs: Node3D = obs_scene.instantiate()
		obs.name = "GreatObservatory"
		obs.position = Vector3(0, Y_ISLAND, 0)
		obs.scale = Vector3.ONE * BASE_GLB_SCALE
		add_child(obs)
		_snap_to_ground(obs)
	else:
		_marker(Vector3(0, Y_ISLAND, 0), 3.0, "The Great Observatory (City Centre)", "monument")

	# --- two wings + moon-bridge (flanking the dome on ±X) ---
	for sx in [-1.0, 1.0]:
		var wpos := Vector3(sx * 40.0, Y_ISLAND, 0)
		_invisible_collider_cyl(9.0, 44.0, wpos + Vector3(0, 22.0, 0), "WingCollider")
	
	var wings_scene := load("res://assets/environment_models/academy/theory_wings_moonbridge/theory_wings_moonbridge_gen1.glb") as PackedScene
	if wings_scene:
		var wings: Node3D = wings_scene.instantiate()
		wings.name = "TheoryWingsAndMoonBridge"
		wings.position = Vector3(0, Y_ISLAND, 0)
		wings.scale = Vector3.ONE * BASE_GLB_SCALE
		add_child(wings)
		_snap_to_ground(wings)

	# --- the warded vault (back of the island, -Z) ---
	var vault_pos := Vector3(0, Y_ISLAND, -40.0)
	_invisible_collider_cyl(13.0, 18.0, vault_pos + Vector3(0, 9.0, 0), "VaultCollider")
	
	var vault_scene := load("res://assets/environment_models/misc_background/noctari_bank_vault/noctari_bank_vault_gen1.glb") as PackedScene
	if vault_scene:
		var vault: Node3D = vault_scene.instantiate()
		vault.name = "WardedVault"
		vault.position = vault_pos
		vault.scale = Vector3.ONE * BASE_GLB_SCALE
		add_child(vault)
		_snap_to_ground(vault)

	# --- gate-plaza fountain facing the causeway (+Z) — examinable only, no marker ---
	var fnt := Interactable3D.new()
	fnt.name = "GateFountain"
	fnt.display_name = "The Gate Fountain"
	fnt.examine_text = "Star-water, black and still, in a broad stone ring at the head of the causeway. Students crossing to their examinations trail a hand in it for luck. The water gives nothing back but a doubled sky."
	fnt.position = Vector3(0, Y_ISLAND + 1.6, 40.0)
	add_child(fnt)


## An invisible collision-only cylinder — the footprint a marker's real model will eventually fill,
## kept solid in the meantime so walking the island already feels roughly right.
func _invisible_collider_cyl(radius: float, height: float, pos: Vector3, name: String) -> void:
	var body := StaticBody3D.new()
	body.name = name
	body.position = pos
	var cs := CollisionShape3D.new()
	var shape := CylinderShape3D.new()
	shape.radius = radius
	shape.height = height
	cs.shape = shape
	body.add_child(cs)
	add_child(body)


func _snap_to_ground(node: Node3D) -> void:
	var min_y := 99999.0
	var meshes := _find_all_mesh_instances(node)
	if meshes.is_empty():
		return
	
	for mi in meshes:
		var aabb := mi.get_aabb()
		# Transform the AABB by the MeshInstance3D's local transform relative to the root node
		# Since they might be nested, we should calculate the lowest point in the local space of 'node'
		for i in range(8):
			var pt := aabb.get_endpoint(i)
			# Convert point from 'mi' local space to 'node' local space
			var local_pt := node.global_transform.affine_inverse() * mi.global_transform * pt
			if local_pt.y < min_y:
				min_y = local_pt.y
				
	if min_y < 0.0 and min_y != 99999.0:
		node.position.y -= min_y * node.scale.y


func _find_all_mesh_instances(node: Node) -> Array[MeshInstance3D]:
	var result: Array[MeshInstance3D] = []
	if node is MeshInstance3D:
		result.append(node)
	for child in node.get_children():
		result.append_array(_find_all_mesh_instances(child))
	return result


func _build_interactables() -> void:
	# District plaques so walking the city is legible, in the Cold Open's examine register (GDD §8.4).
	var d0 := _dir(0.0)
	var d_near_entrance := _dir(0.15)   # just off-axis, clear of the entrance gap in the Parapet ring
	var dead := _dir((DEAD_TOWER + 0.5) * TAU / 9.0)
	var items := [
		# NOTE: position updated to sit on the new flat entrance walkway (Y_L4, not the old diagonal
		# staircase run) — the text still describes the removed stepped staircase ("four great
		# flights"); leaving that for a rewrite once the real entrance geometry is placed, since it's
		# prose, not something to silently rewrite.
		{"name": "The Grand Processional", "pos": Vector3(d0.x * 402.0, Y_L4, d0.z * 402.0),
		 "text": "The wide gold-paved stair, twenty-six paces broad, that drops from the rim to the water in four great flights, cut so an entire Luminarae procession can descend it abreast. Two thousand years of feet have hollowed the centre of every step. Tonight it is empty, and your own are the only ones on it."},
		{"name": "The Rim Parapet", "pos": Vector3(d_near_entrance.x * (R_L1 - 4.0), Y_RIM, d_near_entrance.z * (R_L1 - 4.0)),
		 "text": "Beyond the wall there is nothing but the cloud-sea, silver and slow, and a very long way down. Starfall does not sit on the world. It sits above it, and looks down, and always has. From here the whole caldera falls away beneath you in rings of light to the black star-lake at the bottom, and the great dome stands out of it like a needle out of a well."},
		{"name": "The Dead House", "pos": Vector3(dead.x * (R_TOWER - 16.0), Y_RIM, dead.z * (R_TOWER - 16.0)),
		 "text": "The unlit tower. Its dome is struck through with a single black shard and bears no sigil — a House ended, its name struck from the ring by a hand that did not explain itself. The other eight go on burning around the gap it leaves, and no one has ever proposed lighting it. Some absences are load-bearing."},
		{"name": "The Mirror", "pos": Vector3(d0.x * (R_LAKE + 4.0), Y_SHORE, d0.z * (R_LAKE + 4.0)),
		 "text": "The caldera lake, and it is not water — it is sky. Lean over the shore and you look DOWN into stars, a whole night sky held in a bowl of black basalt a quarter-mile across, the causeway a thread of stone laid across the heavens out to the island. The Solari built the whole city around this one impossible thing and then, over two thousand years, stopped finding it strange. You find it strange tonight."},
		{"name": "The Causeway", "pos": Vector3(6.0, Y_SHORE, R_LAKE - 30.0),
		 "text": "One stone road, eight paces wide, no rail, running a hundred and thirty paces straight out across the star-lake to the island. Children dare each other to run it. Archmages cross it slowly, in robes, once. Halfway across is the only place in Starfall from which you can see the whole ring of the city rising around you at once, terrace over terrace over terrace, turning very slowly like the rings of the monument at your back."},
	]
	for it_d in items:
		var it := Interactable3D.new()
		it.name = "IX_" + str(it_d["name"]).replace(" ", "")
		it.display_name = it_d["name"]
		it.examine_text = it_d["text"]
		it.position = it_d["pos"]
		add_child(it)


func _spawn_act1_npcs() -> void:
	var npcs_data := [
		# --- Act 1 Main Quest Cast ---
		{
			"tres": "res://data/characters/corel.tres",
			"node_name": "NPC_Corel",
			"pos": Vector3(-15.0, Y_ISLAND, -35.0),
			"face": Vector3(0.0, 0.0, 1.0)
		},
		{
			"tres": "res://data/characters/vara.tres",
			"node_name": "NPC_Vara",
			"pos": Vector3(87.4, Y_L4, 239.5),
			"face": Vector3(-0.35, 0.0, -0.93)
		},
		{
			"tres": "res://data/characters/durak.tres",
			"node_name": "NPC_Durak",
			"pos": Vector3(97.3, Y_UNDER, 230.3),
			"face": Vector3(-0.4, 0.0, -0.9)
		},
		{
			"tres": "res://data/characters/coil.tres",
			"node_name": "NPC_Coil",
			"pos": Vector3(35.0, Y_ISLAND, 5.0),
			"face": Vector3(-1.0, 0.0, 0.0)
		},
		{
			"tres": "res://data/characters/sera.tres",
			"node_name": "NPC_Sera",
			"pos": Vector3(-89.1, Y_L4, 244.2),
			"face": Vector3(0.35, 0.0, -0.93)
		},

		# --- Act 1 Side Quest Cast (SQ-01 through SQ-15) ---
		{
			"tres": "res://data/characters/talindir_scribe.tres",
			"node_name": "NPC_Talindir_Scribe",
			"pos": Vector3(125.1, Y_L2, 342.8),
			"face": Vector3(-0.35, 0.0, -0.93)
		},
		{
			"tres": "res://data/characters/orvath_smith.tres",
			"node_name": "NPC_Orvath_Smith",
			"pos": Vector3(-142.2, Y_RIM, 389.8),
			"face": Vector3(0.34, 0.0, -0.94)
		},
		{
			"tres": "res://data/characters/lyris_envoy.tres",
			"node_name": "NPC_Lyris_Envoy",
			"pos": Vector3(364.3, Y_L2, -64.2),
			"face": Vector3(-0.98, 0.0, 0.17)
		},
		{
			"tres": "res://data/characters/sylas_apprentice.tres",
			"node_name": "NPC_Sylas_Apprentice",
			"pos": Vector3(268.5, Y_L3, 155.0),
			"face": Vector3(-0.86, 0.0, -0.50)
		},
		{
			"tres": "res://data/characters/borak_miner.tres",
			"node_name": "NPC_Borak_Miner",
			"pos": Vector3(0.0, Y_UNDER, -240.0),
			"face": Vector3(0.0, 0.0, 1.0)
		},
		{
			"tres": "res://data/characters/miriel_lady.tres",
			"node_name": "NPC_Miriel_Lady",
			"pos": Vector3(-266.8, Y_RIM, -317.9),
			"face": Vector3(0.64, 0.0, 0.76)
		},
		{
			"tres": "res://data/characters/reliquary_keeper.tres",
			"node_name": "NPC_Reliquary_Keeper",
			"pos": Vector3(-403.8, Y_RIM, -71.2),
			"face": Vector3(0.98, 0.0, 0.17)
		},
		{
			"tres": "res://data/characters/kael_dockhand.tres",
			"node_name": "NPC_Kael_Dockhand",
			"pos": Vector3(161.1, Y_L4, 191.2),
			"face": Vector3(-0.64, 0.0, -0.76)
		},
		{
			"tres": "res://data/characters/crafter_elias.tres",
			"node_name": "NPC_Crafter_Elias",
			"pos": Vector3(202.5, Y_L3, -241.3),
			"face": Vector3(-0.64, 0.0, 0.76)
		},
		{
			"tres": "res://data/characters/thrak_foreman.tres",
			"node_name": "NPC_Thrak_Foreman",
			"pos": Vector3(87.2, Y_UNDER, -244.9),
			"face": Vector3(-0.33, 0.0, 0.94)
		},
		{
			"tres": "res://data/characters/morwen_scholar.tres",
			"node_name": "NPC_Morwen_Scholar",
			"pos": Vector3(-126.5, Y_L2, -347.7),
			"face": Vector3(0.34, 0.0, 0.94)
		},
		{
			"tres": "res://data/characters/kendra_warden.tres",
			"node_name": "NPC_Kendra_Warden",
			"pos": Vector3(-272.8, Y_L3, 157.5),
			"face": Vector3(0.86, 0.0, -0.50)
		},
		{
			"tres": "res://data/characters/althor_diviner.tres",
			"node_name": "NPC_Althor_Diviner",
			"pos": Vector3(5.0, Y_L4, R_L4 - 22.0),
			"face": Vector3(0.0, 0.0, 1.0)
		},
		{
			"tres": "res://data/characters/vael_botanist.tres",
			"node_name": "NPC_Vael_Botanist",
			"pos": Vector3(202.9, Y_L3, 240.9),
			"face": Vector3(-0.64, 0.0, -0.76)
		},
		{
			"tres": "res://data/characters/gavin_bridgewarden.tres",
			"node_name": "NPC_Gavin_Bridgewarden",
			"pos": Vector3(4.0, Y_SHORE, R_SHORE - 4.0),
			"face": Vector3(0.0, 0.0, 1.0)
		}
	]

	for data in npcs_data:
		var npc := NPC3D.new()
		npc.name = str(data["node_name"])
		var cd := load(str(data["tres"])) as CharacterData
		if cd:
			npc.character_data = cd
		npc.position = data["pos"]
		add_child(npc)
		if data.has("face"):
			npc.face(data["face"])


