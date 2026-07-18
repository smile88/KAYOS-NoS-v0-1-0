extends Node3D
class_name Balcony3D
## Procedurally builds the Astra Thalas balcony as primitive meshes for the HD-2D 3D Cold Open
## (locked approach: real 3D world, billboard characters). Ports the 2D balcony's shape
## (godot/scenes/zones/AstraThalasBalcony.tscn): a marble platform overlooking the city, a balustrade
## along the far edge, the lit city and the Tower beyond and below it, a sun mosaic inlaid in the
## floor, festival star-lamps, and the stair down at one corner. Environment only — player, camera,
## director are wired by the scene / later steps.
##
## Orientation (see [[kayos-cold-open-3d-branch]] conventions): +Z is toward the default camera
## ("front"); the rail and city sit on the FAR side at -Z so the establishing shot looks out over them.

const PLATFORM_HALF_X := 9.0
const PLATFORM_HALF_Z := 5.5
const RAIL_Z := -PLATFORM_HALF_Z + 0.2   # balustrade just inside the far edge
const RAIL_H := 1.05

const ART := "res://art/3d/"
const PLACE := "res://art/placeholders/"


func _ready() -> void:
	_build_sky()
	_build_platform()
	_build_sun_mosaic()
	_build_balustrade()
	_build_city()
	_build_tower()
	_build_festival_lights()
	_build_stair()


# --- helpers -----------------------------------------------------------------

func _tex(path: String) -> Texture2D:
	return load(path) as Texture2D


func _mat(tex: Texture2D, uv_scale := 1.0, emission := 0.0) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	if tex:
		m.albedo_texture = tex
		m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
		m.uv1_scale = Vector3(uv_scale, uv_scale, 1.0)
	if emission > 0.0:
		m.emission_enabled = true
		m.emission_texture = tex
		m.emission = Color(1, 1, 1)
		m.emission_energy_multiplier = emission
	return m


func _box(size: Vector3, pos: Vector3, mat: Material, name := "Box") -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.name = name
	mi.mesh = mesh
	mi.position = pos
	if mat:
		mi.material_override = mat
	add_child(mi)
	return mi


# --- pieces ------------------------------------------------------------------

func _build_sky() -> void:
	# Big inverted sphere with the equirect star dome, unshaded — a cheap night sky you can orbit under.
	var sphere := SphereMesh.new()
	sphere.radius = 180.0
	sphere.height = 360.0
	sphere.is_hemisphere = false
	var mi := MeshInstance3D.new()
	mi.name = "SkyDome"
	mi.mesh = sphere
	var m := StandardMaterial3D.new()
	m.albedo_texture = _tex(ART + "star_dome.png")
	m.cull_mode = BaseMaterial3D.CULL_FRONT          # show the inside
	m.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	mi.material_override = m
	mi.position = Vector3(0, 0, 0)
	add_child(mi)


func _build_platform() -> void:
	var mat := _mat(_tex(ART + "marble_floor.png"), 6.0)
	# thin slab, top surface at y = 0
	_box(Vector3(PLATFORM_HALF_X * 2.0, 0.4, PLATFORM_HALF_Z * 2.0), Vector3(0, -0.2, 0), mat, "Platform")


func _build_sun_mosaic() -> void:
	# Athalas sun inlaid in the floor centre — a flat textured quad just above the marble.
	var quad := PlaneMesh.new()
	quad.size = Vector2(4.5, 4.5)
	var mi := MeshInstance3D.new()
	mi.name = "SunMosaic"
	mi.mesh = quad
	mi.position = Vector3(0, 0.02, 0.5)
	var tex := _tex(PLACE + "EN-006_sun_mosaic.png")
	var m := _mat(tex, 1.0, 0.25)
	m.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mi.material_override = m
	add_child(mi)


func _build_balustrade() -> void:
	var stone := _mat(_tex(ART + "stone.png"), 1.0)
	# top rail spanning the far edge
	_box(Vector3(PLATFORM_HALF_X * 2.0, 0.14, 0.22), Vector3(0, RAIL_H, RAIL_Z), stone, "RailTop")
	# balusters
	var n := int(PLATFORM_HALF_X * 2.0 / 0.7)
	for i in range(n + 1):
		var x := -PLATFORM_HALF_X + i * 0.7
		_box(Vector3(0.12, RAIL_H, 0.12), Vector3(x, RAIL_H * 0.5, RAIL_Z), stone, "Baluster%d" % i)


func _build_city() -> void:
	# Lit districts beyond and below the rail — boxes with an emissive windows texture so they glow
	# like a city at night. Two ragged rows receding into the dark.
	var windows := _tex(ART + "city_windows.png")
	var rng := RandomNumberGenerator.new()
	rng.seed = 20260718
	var rows := [
		{"z": -9.0,  "y_top": -1.5, "e": 0.22},
		{"z": -14.0, "y_top": -2.5, "e": 0.16},
		{"z": -20.0, "y_top": -3.5, "e": 0.10},
	]
	for row in rows:
		var z: float = row["z"]
		var x := -22.0
		while x < 22.0:
			var w := rng.randf_range(1.6, 3.2)
			var h := rng.randf_range(3.0, 7.5)
			var d := rng.randf_range(1.6, 3.0)
			var top: float = row["y_top"]
			var mat := _mat(windows, maxf(1.0, h / 2.0), row["e"])
			mat.albedo_color = Color(0.32, 0.34, 0.44)   # dark masonry; the windows do the glowing
			_box(Vector3(w, h, d), Vector3(x + w * 0.5, top - h * 0.5, z), mat, "Bldg")
			x += w + rng.randf_range(0.3, 1.2)


func _build_tower() -> void:
	# The Tower of Astra Thalas: a tall tapered spire behind the city with a lit apex.
	var cyl := CylinderMesh.new()
	cyl.top_radius = 0.6
	cyl.bottom_radius = 2.4
	cyl.height = 30.0
	var mi := MeshInstance3D.new()
	mi.name = "Tower"
	mi.mesh = cyl
	mi.position = Vector3(7.0, 30.0 * 0.5 - 4.0, -19.0)
	mi.material_override = _mat(_tex(ART + "stone.png"), 3.0)
	add_child(mi)

	# glowing apex
	var apex := SphereMesh.new()
	apex.radius = 1.1
	apex.height = 2.2
	var am := MeshInstance3D.new()
	am.mesh = apex
	am.position = mi.position + Vector3(0, 15.5, 0)
	var gm := StandardMaterial3D.new()
	gm.emission_enabled = true
	gm.emission = Color(1.0, 0.86, 0.5)
	gm.emission_energy_multiplier = 4.0
	gm.albedo_color = Color(1.0, 0.9, 0.6)
	am.material_override = gm
	add_child(am)

	var light := OmniLight3D.new()
	light.position = am.position
	light.light_color = Color(1.0, 0.86, 0.55)
	light.light_energy = 4.0
	light.omni_range = 26.0
	add_child(light)


func _build_festival_lights() -> void:
	# Warm star-lamps along the rail: small emissive orbs + point lights, the festival glow.
	for x in [-7.0, -3.5, 0.0, 3.5, 7.0]:
		var orb := SphereMesh.new()
		orb.radius = 0.16
		orb.height = 0.32
		var mi := MeshInstance3D.new()
		mi.mesh = orb
		mi.position = Vector3(x, RAIL_H + 0.5, RAIL_Z + 0.1)
		var m := StandardMaterial3D.new()
		m.emission_enabled = true
		m.emission = Color(1.0, 0.82, 0.45)
		m.emission_energy_multiplier = 3.0
		m.albedo_color = Color(1.0, 0.85, 0.5)
		mi.material_override = m
		add_child(mi)

		var l := OmniLight3D.new()
		l.position = mi.position
		l.light_color = Color(1.0, 0.8, 0.5)
		l.light_energy = 1.6
		l.omni_range = 6.0
		add_child(l)


func _build_stair() -> void:
	# Stair down to the scriptorium at the near-left corner: a short flight of steps you can see and
	# (later) step onto. Marks where the room transition happens.
	var stone := _mat(_tex(ART + "stone.png"), 1.0)
	var base := Vector3(-PLATFORM_HALF_X + 1.6, 0, PLATFORM_HALF_Z - 1.4)
	var steps := 5
	for i in range(steps):
		var y := -0.25 * (i + 1)
		var z := base.z + 0.45 * i
		_box(Vector3(2.4, 0.25, 0.5), Vector3(base.x, y + 0.125, z), stone, "Step%d" % i)
