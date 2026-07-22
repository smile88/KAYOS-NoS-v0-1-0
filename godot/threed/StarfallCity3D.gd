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
## Walkable for real: terraces are solid collision linked by GRAND STAIRCASES at four spokes — visible
## stepped boxes over a hidden smooth ramp collider (Godot CharacterBody3D can't climb steps), so they look
## like stairs AND work. The Player3D that drives this scene runs with gravity_enabled + jump. Everything is
## placeholder primitives + tiling temp textures; real modelled art replaces it the same way in the Cold Open.

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

## Where the player drops in: on the rim, front (+Z), in the gap between two towers, looking inward.
const SPAWN := Vector3(0, Y_RIM + 0.6, 415.0)

# the four processional spokes (radians; a=0 is +Z front / the Grand Processional)
const SPOKES := [0.0, PI / 2.0, PI, -PI / 2.0]

## MultiMesh pools for the repeated, NON-collidable decoration (building windows/doors/roofs, crystal
## combs, canal water). Each pool draws thousands of identical bits in ONE draw call instead of one
## MeshInstance3D per bit — the perf budget lives or dies on this. Collidable geometry (terraces, stairs,
## building bodies, towers, island) is untouched: it stays real nodes so the player still walks on it.
var _pools := {}
var _unit_box: BoxMesh
# shared materials for the pooled building dressing (built once in _build_from_plan)
var _win_warm_mat: StandardMaterial3D
var _win_cool_mat: StandardMaterial3D
var _door_mat: StandardMaterial3D
var _roof_mat: StandardMaterial3D


func _ready() -> void:
	_unit_box = BoxMesh.new()
	_unit_box.size = Vector3.ONE          # every pooled piece is this cube, sized per-instance by scale
	_build_sky()
	_build_lake()
	_build_terraces()
	_build_stairs()
	_build_parapet()
	_build_crystal_combs()
	_build_towers()
	_build_canals()          # the star-water canals (the generic habitation is now data-driven)
	_build_from_plan()       # the REAL named buildings, placed from docs/city → res://data/starfall_city.json
	_build_shore_plaza()
	_build_causeway()
	_build_island()
	_build_open_house()
	_build_interactables()
	_flush_pools()


# --- data-driven city (the plan made walkable) -------------------------------
## The single assembled city plan (tools/build_city.py writes it from docs/city/*). Each above-ground
## structure becomes a real, examinable building at its surveyed coordinates, so walking the city matches
## docs/Starfall_City_Codex.md. The locked shell (terraces, stairs, towers, lake, causeway, island) stays
## procedural; the Under-Terraces and the Academy interiors are a later pass (no cavity/island interiors yet).
const PLAN_PATH := "res://data/starfall_city.json"


func _build_from_plan() -> void:
	if not FileAccess.file_exists(PLAN_PATH):
		push_warning("Starfall: plan not found at %s — run `python tools/build_city.py`." % PLAN_PATH)
		return
	var data: Variant = JSON.parse_string(FileAccess.get_file_as_string(PLAN_PATH))
	if typeof(data) != TYPE_DICTIONARY or not (data as Dictionary).has("structures"):
		push_warning("Starfall: plan JSON malformed.")
		return
	# shared pooled-decoration materials for the plan buildings (windows/door/roof)
	_win_warm_mat = _mat(_tex(ART + "city_windows.png"), 3.0, 0.42)
	_win_warm_mat.albedo_color = Color(0.35, 0.3, 0.28)
	_win_cool_mat = _mat(_tex(ART + "city_windows.png"), 3.0, 0.28)
	_win_cool_mat.albedo_color = Color(0.3, 0.32, 0.44)
	_door_mat = _flat_dark()
	_roof_mat = _mat(_tex(ART + "basalt.png"), 2.0)

	var placed := 0
	for s in (data as Dictionary)["structures"]:
		if _place_plan_structure(s as Dictionary):
			placed += 1
	print("Starfall: placed %d plan buildings from %s" % [placed, PLAN_PATH])


## True if this structure got a building. Skips what the shell already builds, the hand-built Open House,
## the cylinder towers, the subterranean Under-Terraces, the Academy island, and non-box pieces (canals).
func _place_plan_structure(s: Dictionary) -> bool:
	var district: String = s.get("district", "")
	if district in ["D-UNDER", "D-ACADEMY", "D-MIRROR"]:
		return false
	if s.get("id", "") == "VS-U01":
		return false
	var fp: Dictionary = s.get("footprint", {})
	if fp.get("shape", "") == "cylinder" or not (fp.has("w") and fp.has("d")):
		return false
	var posd: Dictionary = s.get("position", {})
	var a := deg_to_rad(float(posd.get("a_deg", 0.0)))
	var r := float(posd.get("r", 300.0))
	var pos := Vector3(sin(a) * r, float(s.get("y_base", 0.0)), cos(a) * r)
	_plan_building(s, pos, float(fp["w"]), float(fp["d"]), float(s.get("height_m", 8.0)), a + PI, district)
	return true


func _plan_building(s: Dictionary, pos: Vector3, w: float, d: float, h: float, face_a: float, district: String) -> void:
	var warm := district == "D-CANAL"
	var body := _mat(_tex(ART + "terrace_stone.png"), 3.0)
	body.albedo_color = Color(0.5, 0.45, 0.48) if warm else Color(0.6, 0.58, 0.7)
	var mi := _floor_box(Vector3(w, h, d), pos + Vector3(0, h * 0.5, 0), body, "B_" + str(s.get("id", "")))
	mi.rotation.y = face_a
	var center := pos + Vector3(0, h * 0.5, 0)
	var face := Basis(Vector3.UP, face_a)
	var win_pool := "win_warm" if warm else "win_cool"
	var win_mat: Material = _win_warm_mat if warm else _win_cool_mat
	var storeys := maxi(1, int(h / 3.5))
	for st in range(1, storeys):
		var ly := -h * 0.5 + st * 3.5
		_deco(win_pool, Vector3(w * 0.82, 1.6, 0.1), center + face * Vector3(0, ly, d * 0.5 + 0.06), face_a, win_mat)
	_deco("door", Vector3(1.4, 2.2, 0.35), center + face * Vector3(0, -h * 0.5 + 1.1, d * 0.5 + 0.02), face_a, _door_mat)
	_deco("roof", Vector3(w * 1.04, 0.8, d * 1.04), center + face * Vector3(0, h * 0.5 + 0.4, 0), face_a, _roof_mat)
	# an examinable at the door, carrying the plan's identity (name, type, purpose)
	var it := Interactable3D.new()
	it.name = "IX_" + str(s.get("id", ""))
	it.display_name = str(s.get("name", ""))
	it.examine_text = "%s — %s.\n\n%s" % [str(s.get("name", "")), str(s.get("type", "")), str(s.get("purpose", ""))]
	it.position = pos + face * Vector3(0, 1.4, d * 0.5 + 1.0)
	add_child(it)


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


## Like _child_box, but SOLID — a wall/floor/ceiling piece parented into a (possibly rotated) shell that
## the player collides with. The collider inherits the shell's transform, so a whole room can be built in
## local coordinates and then placed + yawed as one.
static func _solid_child(parent: Node3D, size: Vector3, pos: Vector3, mat: Material, name := "Part") -> MeshInstance3D:
	var mi := _child_box(parent, size, pos, mat, name)
	var body := StaticBody3D.new()
	var cs := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = size
	cs.shape = shape
	body.add_child(cs)
	mi.add_child(body)
	return mi


## A textured box parented to `parent` (NOT the zone) — for sub-pieces (a building's windows, a door).
static func _child_box(parent: Node3D, size: Vector3, pos: Vector3, mat: Material, name := "Part") -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.name = name
	mi.mesh = mesh
	mi.position = pos
	if mat:
		mi.material_override = mat
	parent.add_child(mi)
	return mi


## A solid annulus of collision boxes = one terrace ring: flat top at `top_y`, dropping to `bottom_y`, so
## the taller outer rings' inner faces become the retaining walls of the terraces below them.
func _ring(inner_r: float, outer_r: float, top_y: float, bottom_y: float, mat: Material, facet := 40.0, name := "Ring") -> void:
	var mid := (inner_r + outer_r) * 0.5
	var depth := outer_r - inner_r
	var height := top_y - bottom_y
	var n := maxi(32, int(TAU * mid / facet))
	var width := 2.0 * mid * tan(PI / n) * 1.12
	var cy := top_y - height * 0.5
	for i in range(n):
		var a := i * TAU / n
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


## A GRAND STAIRCASE from `low` (bottom, on the lower terrace) to `high` (top, on the upper terrace):
## visible stepped boxes (no collision) forming the wedge, plus one hidden smooth ramp collider the player
## actually walks on. This is the only reliable way to make climbable stairs on a CharacterBody3D.
func _stair(low: Vector3, high: Vector3, width: float, n_steps: int, mat: Material, name := "Stair") -> void:
	var delta := high - low
	var run := Vector2(delta.x, delta.z).length()
	var rise := delta.y
	var horiz := Vector3(delta.x, 0, delta.z).normalized()
	var yaw := atan2(delta.x, delta.z)
	var base_y := low.y - 1.5
	for i in range(n_steps):
		var top_y := low.y + rise * float(i + 1) / n_steps
		var seg_len := run / n_steps
		var cxz := Vector3(low.x, 0, low.z) + horiz * (run * (float(i) + 0.5) / n_steps)
		var h := top_y - base_y
		var box := _box(Vector3(width, h, seg_len + 0.05), Vector3(cxz.x, base_y + h * 0.5, cxz.z), mat, name)
		box.rotation.y = yaw
	# hidden ramp collider — its top sits ~at the step nosings so feet appear on the steps
	var mid := (low + high) * 0.5 + Vector3(0, -0.35, 0)
	var length := sqrt(run * run + rise * rise)
	var body := StaticBody3D.new()
	body.name = name + "Collider"
	var cs := CollisionShape3D.new()
	var shape := BoxShape3D.new()
	shape.size = Vector3(width, 1.0, length)
	cs.shape = shape
	body.add_child(cs)
	body.position = mid
	body.basis = Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, -atan2(rise, run))
	add_child(body)


## A solid textured cylinder (tower drums, dome bases, plinths) — from Zone3D, re-declared? No: inherited.


# --- sky & lake --------------------------------------------------------------

func _build_sky() -> void:
	var sphere := SphereMesh.new()
	sphere.radius = 900.0
	sphere.height = 1800.0
	var mi := MeshInstance3D.new()
	mi.name = "SkyDome"
	mi.mesh = sphere
	var m := StandardMaterial3D.new()
	m.albedo_texture = _tex(ART + "star_dome.png")
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
	var m := StandardMaterial3D.new()
	m.albedo_texture = _tex(ART + "star_dome.png")
	m.uv1_scale = Vector3(6, 6, 1)
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mi.material_override = m
	add_child(mi)


# --- terraces & stairs -------------------------------------------------------

func _build_terraces() -> void:
	var basalt := _mat(_tex(ART + "basalt.png"), 8.0)
	var terr := _mat(_tex(ART + "terrace_stone.png"), 8.0)
	var terr2 := _mat(_tex(ART + "terrace_stone.png"), 8.0)
	terr2.albedo_color = Color(0.86, 0.86, 0.96)
	_ring(R_L2, R_L1, Y_RIM, -1.0, basalt, 42.0, "RimRing")
	_ring(R_L3, R_L2, Y_L2, -1.0, terr2, 40.0, "Terrace2")
	_ring(R_L4, R_L3, Y_L3, -1.0, terr2, 38.0, "Terrace3")
	_ring(R_SHORE, R_L4, Y_L4, -1.0, terr, 36.0, "CanalRing")
	_ring(R_LAKE, R_SHORE, Y_SHORE, -1.0, basalt, 30.0, "ShoreRing")


func _build_stairs() -> void:
	var stone := _mat(_tex(ART + "stone.png"), 6.0)
	var marble := _mat(_tex(ART + "marble_floor.png"), 6.0)
	# (low radius, low y, high radius, high y) — stair climbs OUTWARD (up a terrace)
	var links := [
		[220.0, Y_SHORE, 245.0, Y_L4],
		[280.0, Y_L4, 305.0, Y_L3],
		[335.0, Y_L3, 360.0, Y_L2],
		[390.0, Y_L2, 415.0, Y_RIM],
	]
	for a in SPOKES:
		var d := _dir(a)
		var processional: bool = is_equal_approx(a, 0.0)
		var w := 26.0 if processional else 13.0
		var mat: Material = marble if processional else stone
		for link in links:
			var low := Vector3(d.x * link[0], link[1], d.z * link[0])
			var high := Vector3(d.x * link[2], link[3], d.z * link[2])
			_stair(low, high, w, 15, mat, "Stair")


func _build_parapet() -> void:
	var stone := _mat(_tex(ART + "basalt.png"), 3.0)
	_ring(R_L1 - 2.0, R_L1, Y_RIM + 3.0, Y_RIM, stone, 24.0, "Parapet")


func _build_crystal_combs() -> void:
	var mat := _mat(_tex(ART + "comb_crystal.png"), 2.0, 0.14)
	mat.albedo_color = Color(0.6, 0.68, 0.85)
	var r := R_L2 + 3.0
	var n := 120
	for i in range(n):
		var a := i * TAU / n
		if _near_spoke(a):
			continue
		var d := _dir(a)
		# pooled decoration: yaw a, tilt 12° off vertical — matches the old per-blade Euler(12°, a, 0)
		_deco("comb", Vector3(1.2, 9.0, 4.0), Vector3(d.x * r, Y_L2 + 4.5, d.z * r), a, mat, deg_to_rad(12))


# --- the nine towers ---------------------------------------------------------

func _build_towers() -> void:
	var drum_mat := _mat(_tex(ART + "stone.png"), 6.0)
	var dead_mat := _mat(_tex(ART + "basalt.png"), 6.0)
	dead_mat.albedo_color = Color(0.4, 0.4, 0.46)
	for i in range(9):
		var a := (i + 0.5) * TAU / 9.0   # half-step offset so the +Z processional falls in a GAP
		var d := _dir(a)
		var base := Vector3(d.x * R_TOWER, Y_RIM, d.z * R_TOWER)
		var dead := (i == DEAD_TOWER)
		var drum := _col_cyl(11.0, 40.0, base + Vector3(0, 20.0, 0), dead_mat if dead else drum_mat, "TowerDrum%d" % i)
		if not dead:
			var band := _mat(_tex(ART + "city_windows.png"), 8.0, 0.5)
			band.albedo_color = Color(0.3, 0.32, 0.42)
			var b := CylinderMesh.new()
			b.top_radius = 11.3
			b.bottom_radius = 11.3
			b.height = 30.0
			var bi := MeshInstance3D.new()
			bi.mesh = b
			bi.position = base + Vector3(0, 22.0, 0)
			bi.material_override = band
			drum.add_child(bi)
		var dome := SphereMesh.new()
		dome.radius = 13.0
		dome.height = 16.0
		dome.is_hemisphere = true
		var di := MeshInstance3D.new()
		di.mesh = dome
		di.position = base + Vector3(0, 40.0, 0)
		var dmat := _mat(_tex(ART + "basalt.png"), 4.0)
		if dead:
			dmat.albedo_color = Color(0.28, 0.28, 0.34)
		di.material_override = dmat
		add_child(di)
		if dead:
			var shard := _box(Vector3(1.4, 24.0, 1.4), base + Vector3(0, 50.0, 0), dmat, "DeadShard")
			shard.rotation = Vector3(0, 0, deg_to_rad(28))
		else:
			var glow := StandardMaterial3D.new()
			glow.emission_enabled = true
			glow.emission = Color(1.0, 0.86, 0.55)
			glow.emission_energy_multiplier = 3.0
			glow.albedo_color = Color(1.0, 0.9, 0.6)
			var fin := SphereMesh.new()
			fin.radius = 2.4
			fin.height = 4.8
			var fi := MeshInstance3D.new()
			fi.mesh = fin
			fi.position = base + Vector3(0, 52.0, 0)
			fi.material_override = glow
			add_child(fi)
			var l := OmniLight3D.new()
			l.position = fi.position
			l.light_color = Color(1.0, 0.85, 0.6)
			l.light_energy = 3.0
			l.omni_range = 80.0
			add_child(l)


# --- habitation --------------------------------------------------------------

func _flat_dark() -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = Color(0.08, 0.08, 0.12)
	m.roughness = 1.0
	return m


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


func _near_spoke(a: float) -> bool:
	for s in SPOKES:
		var da := absf(wrapf(a - s, -PI, PI))
		if da < 0.16:
			return true
	return false


## THE OPEN HOUSE — the first enterable building (interiors are otherwise a later pass, GDD-per §6 of the
## 3D pivot). It sits in the clear plaza flanking the Grand Processional on the top habitation terrace,
## door facing the stair, so the descending player finds a real doorway they can walk through into a
## room: four solid walls with a 2.6 m door gap (a lintel over it), a solid ceiling you can't jump out
## of, a warm interior light, and an examinable lectern. Built in a rotated shell so the whole room is
## authored in local coordinates and then placed + yawed as one piece.
func _build_open_house() -> void:
	const W := 14.0
	const D := 12.0
	const WALL_H := 6.0
	const T := 0.5
	const DOOR_W := 2.6
	const DOOR_H := 2.6

	var shell := Node3D.new()
	shell.name = "OpenHouse"
	shell.position = Vector3(30.0, Y_L2, 372.0)   # L2 terrace, beside the processional (in the spoke gap)
	shell.rotation.y = -PI / 2.0                   # door (+Z local) faces world -X, toward the stair
	add_child(shell)

	var wall := _mat(_tex(ART + "terrace_stone.png"), 3.0)
	wall.albedo_color = Color(0.56, 0.53, 0.62)
	var dark := _flat_dark()

	# back + two sides
	_solid_child(shell, Vector3(W, WALL_H, T), Vector3(0, WALL_H * 0.5, -D * 0.5), wall, "WallBack")
	_solid_child(shell, Vector3(T, WALL_H, D), Vector3(-W * 0.5, WALL_H * 0.5, 0), wall, "WallLeft")
	_solid_child(shell, Vector3(T, WALL_H, D), Vector3(W * 0.5, WALL_H * 0.5, 0), wall, "WallRight")
	# front wall, split around a central doorway, with a lintel above the opening
	var seg := (W - DOOR_W) * 0.5
	var off := (DOOR_W + seg) * 0.5
	_solid_child(shell, Vector3(seg, WALL_H, T), Vector3(-off, WALL_H * 0.5, D * 0.5), wall, "WallFrontL")
	_solid_child(shell, Vector3(seg, WALL_H, T), Vector3(off, WALL_H * 0.5, D * 0.5), wall, "WallFrontR")
	_solid_child(shell, Vector3(DOOR_W, WALL_H - DOOR_H, T),
		Vector3(0, DOOR_H + (WALL_H - DOOR_H) * 0.5, D * 0.5), wall, "Lintel")
	# ceiling (so first-person / jump can't pop you onto the roof) + a dark inner floor slab
	_solid_child(shell, Vector3(W, T, D), Vector3(0, WALL_H, 0), _mat(_tex(ART + "basalt.png"), 2.0), "Ceiling")
	_solid_child(shell, Vector3(W - T, 0.3, D - T), Vector3(0, 0.15, 0), dark, "InnerFloor")

	# a reading lectern against the back wall — solid, and examinable
	_solid_child(shell, Vector3(2.4, 1.1, 1.0), Vector3(0, 0.85, -D * 0.5 + 1.6), wall, "Lectern")
	var lect := Interactable3D.new()
	lect.name = "AstronomersLectern"
	lect.display_name = "The Astronomer's Lectern"
	lect.examine_text = "A slanted reading-stand of black wood, a star-chart still pinned to it under a paperweight of raw comb-crystal. The chart is of this very caldera's sky, drawn from this very terrace, and someone has been correcting it in a fine hand for what looks like years — the last correction is dated tonight. Whoever kept it did not finish. They will not, now."
	lect.position = Vector3(0, 1.4, -D * 0.5 + 1.6)
	shell.add_child(lect)

	# warm interior light so the room reads as lived-in, not a black box
	var lamp := OmniLight3D.new()
	lamp.name = "HearthLight"
	lamp.position = Vector3(0, WALL_H - 1.2, 0)
	lamp.light_color = Color(1.0, 0.86, 0.62)
	lamp.light_energy = 1.6
	lamp.omni_range = 16.0
	shell.add_child(lamp)


# --- shore, causeway, island -------------------------------------------------

func _build_shore_plaza() -> void:
	# The front plaza where the Processional meets the water: the golden armillary monument (scaled up to a
	# true landmark ~24 m tall) on the +Z axis, flanked by tall star-lamps.
	var mono := Interactable3D.new()
	mono.name = "ArmillaryMonument"
	mono.display_name = "The Armillary of the First Measure"
	mono.examine_text = "A colossal golden orrery on a stepped plinth, three rings the size of ship's wheels hooping a caged star, the whole of it taller than the gatehouses. The Solari raised it where the Processional meets the water, so that anyone descending from the rim would pass the whole heavens in miniature before crossing to the Academy. The rings still turn, very slowly. Nobody remembers winding them."
	mono.prop_model = "armillary"
	mono.scale = Vector3(7, 7, 7)   # the armillary prop is ~3.4 m; scale it to a ~24 m landmark
	mono.position = Vector3(0, Y_SHORE, R_SHORE - 10.0)
	add_child(mono)
	for sx in [-16.0, 16.0]:
		var orb := SphereMesh.new()
		orb.radius = 1.0
		orb.height = 2.0
		var oi := MeshInstance3D.new()
		oi.mesh = orb
		oi.position = Vector3(sx, Y_SHORE + 11.0, R_SHORE - 10.0)
		var gm := StandardMaterial3D.new()
		gm.emission_enabled = true
		gm.emission = Color(0.8, 0.85, 1.0)
		gm.emission_energy_multiplier = 3.0
		gm.albedo_color = Color(0.85, 0.9, 1.0)
		oi.material_override = gm
		add_child(oi)
		_box(Vector3(0.7, 11.0, 0.7), Vector3(sx, Y_SHORE + 5.5, R_SHORE - 10.0), _mat(_tex(ART + "stone.png"), 3.0), "LampPost")
		var l := OmniLight3D.new()
		l.position = oi.position
		l.light_color = Color(0.75, 0.82, 1.0)
		l.light_energy = 2.0
		l.omni_range = 40.0
		add_child(l)


func _build_causeway() -> void:
	# A single railless stone road from the shore straight across the Mirror to the island gate (+Z).
	var marble := _mat(_tex(ART + "marble_floor.png"), 20.0)
	var length := R_SHORE - R_ISLAND
	var mid := (R_SHORE + R_ISLAND) * 0.5
	_floor_box(Vector3(8.0, 0.6, length), Vector3(0, Y_SHORE - 0.3, mid), marble, "Causeway")
	# short stair up onto the slightly-raised island
	_stair(Vector3(0, Y_SHORE, R_ISLAND + 6.0), Vector3(0, Y_ISLAND, R_ISLAND - 2.0), 8.0, 4, marble, "CausewayStep")


func _build_island() -> void:
	# The Academy island at dead centre: a raised marble disc carrying the HERO observatory (~110 m to the
	# apex — ~67 m above the rim, seen from everywhere), two wings joined by a moon-bridge, the warded vault,
	# and a gate-plaza fountain facing the causeway. A balcony ring girdles the observatory drum (the Cold
	# Open balcony is one such ledge — this is what it would look like from outside, and at what scale).
	var basalt := _mat(_tex(ART + "basalt.png"), 10.0)
	var marble := _mat(_tex(ART + "marble_floor.png"), 20.0)
	var stone := _mat(_tex(ART + "stone.png"), 10.0)
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

	# --- the hero observatory (drum -> balcony -> window drum -> verdigris dome -> spire) ---
	var drum := _col_cyl(22.0, 60.0, Vector3(0, Y_ISLAND + 30.0, 0), stone, "ObservatoryDrum")
	# balcony ring girdling the drum (the Cold Open balcony, at scale)
	var balc := CylinderMesh.new()
	balc.top_radius = 26.0
	balc.bottom_radius = 26.0
	balc.height = 1.4
	var balci := MeshInstance3D.new()
	balci.mesh = balc
	balci.position = Vector3(0, Y_ISLAND + 40.0, 0)
	balci.material_override = marble
	drum.add_child(balci)
	# lit window drum above the balcony
	var band := _mat(_tex(ART + "city_windows.png"), 12.0, 0.45)
	band.albedo_color = Color(0.3, 0.32, 0.42)
	var bmesh := CylinderMesh.new()
	bmesh.top_radius = 20.0
	bmesh.bottom_radius = 22.0
	bmesh.height = 22.0
	var bi := MeshInstance3D.new()
	bi.mesh = bmesh
	bi.position = Vector3(0, Y_ISLAND + 51.0, 0)
	bi.material_override = band
	drum.add_child(bi)
	# green verdigris dome
	var dome := SphereMesh.new()
	dome.radius = 24.0
	dome.height = 30.0
	dome.is_hemisphere = true
	var domi := MeshInstance3D.new()
	domi.name = "GreenDome"
	domi.mesh = dome
	domi.position = Vector3(0, Y_ISLAND + 62.0, 0)
	domi.material_override = _mat(_tex(ART + "dome_verdigris.png"), 5.0)
	add_child(domi)
	# spire finial crowning the dome — the silhouette that dominates the skyline
	_col_cyl(2.4, 34.0, Vector3(0, Y_ISLAND + 92.0, 0), stone, "Spire", 0.2)
	var apexm := StandardMaterial3D.new()
	apexm.emission_enabled = true
	apexm.emission = Color(0.8, 0.86, 1.0)
	apexm.emission_energy_multiplier = 5.0
	apexm.albedo_color = Color(0.85, 0.9, 1.0)
	var apex := SphereMesh.new()
	apex.radius = 3.4
	apex.height = 6.8
	var ai := MeshInstance3D.new()
	ai.mesh = apex
	ai.position = Vector3(0, Y_ISLAND + 110.0, 0)
	ai.material_override = apexm
	add_child(ai)
	var al := OmniLight3D.new()
	al.position = ai.position
	al.light_color = Color(0.75, 0.82, 1.0)
	al.light_energy = 4.0
	al.omni_range = 200.0
	add_child(al)

	# --- two wings + moon-bridge (flanking the dome on ±X) ---
	for sx in [-1.0, 1.0]:
		var wpos := Vector3(sx * 40.0, Y_ISLAND, 0)
		var wing := _col_cyl(9.0, 44.0, wpos + Vector3(0, 22.0, 0), stone, "Wing")
		var wband := _mat(_tex(ART + "city_windows.png"), 8.0, 0.35)
		wband.albedo_color = Color(0.3, 0.32, 0.42)
		var wm := CylinderMesh.new()
		wm.top_radius = 9.2
		wm.bottom_radius = 9.2
		wm.height = 28.0
		var wmi := MeshInstance3D.new()
		wmi.mesh = wm
		wmi.position = wpos + Vector3(0, 24.0, 0)
		wmi.material_override = wband
		wing.add_child(wmi)
	# arched moon-bridge between the two wing tops
	_box(Vector3(80.0, 2.0, 6.0), Vector3(0, Y_ISLAND + 40.0, 0), marble, "MoonBridge")

	# --- the warded vault (back of the island, -Z) ---
	var vaultmat := _mat(_tex(ART + "basalt.png"), 6.0)
	vaultmat.albedo_color = Color(0.5, 0.5, 0.58)
	_col_cyl(13.0, 18.0, Vector3(0, Y_ISLAND + 9.0, -40.0), vaultmat, "WardedVault")
	var glyph := PlaneMesh.new()
	glyph.size = Vector2(20.0, 20.0)
	var gi := MeshInstance3D.new()
	gi.mesh = glyph
	gi.position = Vector3(0, Y_ISLAND + 0.2, -22.0)
	gi.material_override = _mat(_tex(ART + "ward_glyph.png"), 1.0, 0.4)
	add_child(gi)

	# --- gate-plaza fountain facing the causeway (+Z) ---
	var fnt := Interactable3D.new()
	fnt.name = "GateFountain"
	fnt.display_name = "The Gate Fountain"
	fnt.examine_text = "Star-water, black and still, in a broad stone ring at the head of the causeway. Students crossing to their examinations trail a hand in it for luck. The water gives nothing back but a doubled sky."
	fnt.prop_model = "fountain"
	fnt.scale = Vector3(4, 4, 4)
	fnt.position = Vector3(0, Y_ISLAND + 0.2, 40.0)
	add_child(fnt)


func _build_interactables() -> void:
	# District plaques so walking the city is legible, in the Cold Open's examine register (GDD §8.4).
	var d0 := _dir(0.0)
	var dead := _dir((DEAD_TOWER + 0.5) * TAU / 9.0)
	var items := [
		{"name": "The Grand Processional", "pos": Vector3(d0.x * 402.0, Y_L2, d0.z * 402.0),
		 "text": "The wide gold-paved stair, twenty-six paces broad, that drops from the rim to the water in four great flights, cut so an entire Luminarae procession can descend it abreast. Two thousand years of feet have hollowed the centre of every step. Tonight it is empty, and your own are the only ones on it."},
		{"name": "The Rim Parapet", "pos": Vector3(d0.x * (R_L1 - 4.0), Y_RIM, d0.z * (R_L1 - 4.0)),
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
