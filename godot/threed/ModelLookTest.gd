extends Node3D
## Look-dev sandbox: 3D-model props + 3D-model characters, lit like the game, to judge the
## "make everything a low-poly 3D model (Daggerfall↔Morrowind)" direction against the current
## billboards. Renders a few stills. Throwaway — delete once the direction is decided.

const ART := "res://art/3d/"


func _wood() -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_texture = load(ART + "shelf_wood.png")
	m.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	m.uv1_scale = Vector3(2, 2, 1)
	m.roughness = 0.9
	return m


func _flat(c: Color, rough := 0.9) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = c
	m.roughness = rough
	return m


func _box(size: Vector3, pos: Vector3, mat: Material, parent: Node3D = null) -> MeshInstance3D:
	var mesh := BoxMesh.new()
	mesh.size = size
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = pos
	(parent if parent else self).add_child(mi)
	return mi


func _ready() -> void:
	_build_env()
	_build_room()
	_build_props()
	_build_characters()
	_run()


func _build_env() -> void:
	var we := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.04, 0.05, 0.10)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.28, 0.3, 0.42)
	env.ambient_light_energy = 0.9
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.glow_enabled = true
	env.glow_intensity = 0.35
	env.glow_hdr_threshold = 1.1
	we.environment = env
	add_child(we)

	var moon := DirectionalLight3D.new()
	moon.transform = Transform3D(Basis.from_euler(Vector3(deg_to_rad(-45), deg_to_rad(35), 0)), Vector3(0, 14, 0))
	moon.light_color = Color(0.6, 0.68, 0.9)
	moon.light_energy = 0.5
	moon.shadow_enabled = true
	add_child(moon)

	# A warm archive lamp so it reads like the scriptorium.
	var lamp := OmniLight3D.new()
	lamp.position = Vector3(-1.6, 1.6, -0.5)
	lamp.light_color = Color(1.0, 0.85, 0.58)
	lamp.light_energy = 2.2
	lamp.omni_range = 8.0
	add_child(lamp)


func _build_room() -> void:
	var floor_mat := StandardMaterial3D.new()
	floor_mat.albedo_texture = load("res://art/placeholders/EN-019_scriptorium_floor.png")
	floor_mat.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	floor_mat.uv1_scale = Vector3(4, 4, 1)
	floor_mat.roughness = 0.95
	_box(Vector3(14, 0.4, 12), Vector3(0, -0.2, 0), floor_mat)
	var wall := _flat(Color(0.30, 0.30, 0.36))
	_box(Vector3(14, 4, 0.4), Vector3(0, 2, -5.4), wall)
	_box(Vector3(0.4, 4, 12), Vector3(-7, 2, 0), wall)
	_box(Vector3(0.4, 4, 12), Vector3(7, 2, 0), wall)


func _build_props() -> void:
	_desk(Vector3(-2.4, 0, -2.2))
	_cabinet(Vector3(3.6, 0, -3.4))
	_chest(Vector3(2.2, 0, -1.4))
	_scroll_rack(Vector3(-4.4, 0, -3.2))
	_bookshelf(Vector3(0.2, 0, -4.6))


func _desk(p: Vector3) -> void:
	var w := _wood()
	_box(Vector3(1.6, 0.09, 0.8), p + Vector3(0, 0.78, 0), w)          # top
	for dx in [-0.72, 0.72]:
		for dz in [-0.32, 0.32]:
			_box(Vector3(0.09, 0.78, 0.09), p + Vector3(dx, 0.39, dz), w)  # legs
	# a couple of props on the desk
	_box(Vector3(0.28, 0.05, 0.36), p + Vector3(-0.4, 0.85, 0), _flat(Color(0.9, 0.88, 0.78)))  # paper
	_box(Vector3(0.1, 0.14, 0.1), p + Vector3(0.4, 0.9, -0.1), _flat(Color(0.2, 0.2, 0.24)))     # inkpot


func _cabinet(p: Vector3) -> void:
	var body := _flat(Color(0.20, 0.16, 0.34))     # indigo lacquer
	_box(Vector3(1.0, 1.7, 0.55), p + Vector3(0, 0.85, 0), body)
	var door := _flat(Color(0.26, 0.21, 0.42))
	_box(Vector3(0.44, 1.5, 0.04), p + Vector3(-0.24, 0.9, 0.29), door)
	_box(Vector3(0.44, 1.5, 0.04), p + Vector3(0.24, 0.9, 0.29), door)
	var brass := _flat(Color(0.7, 0.6, 0.3), 0.5)
	_box(Vector3(0.05, 0.12, 0.05), p + Vector3(-0.03, 0.9, 0.32), brass)
	_box(Vector3(0.05, 0.12, 0.05), p + Vector3(0.03, 0.9, 0.32), brass)


func _chest(p: Vector3) -> void:
	var w := _wood()
	_box(Vector3(1.0, 0.5, 0.6), p + Vector3(0, 0.25, 0), w)
	_box(Vector3(1.02, 0.18, 0.62), p + Vector3(0, 0.58, 0), w)        # lid
	var iron := _flat(Color(0.18, 0.18, 0.2), 0.6)
	for dx in [-0.35, 0.0, 0.35]:
		_box(Vector3(0.06, 0.72, 0.63), p + Vector3(dx, 0.36, 0), iron)  # bands


func _scroll_rack(p: Vector3) -> void:
	var w := _wood()
	for dx in [-0.5, 0.5]:
		_box(Vector3(0.08, 1.8, 0.5), p + Vector3(dx, 0.9, 0), w)       # posts
	for y in [0.5, 1.0, 1.5]:
		_box(Vector3(1.0, 0.06, 0.5), p + Vector3(0, y, 0), w)          # shelves
		var sc := _flat(Color(0.86, 0.82, 0.7))
		for i in range(4):
			var roll := CylinderMesh.new()
			roll.top_radius = 0.05; roll.bottom_radius = 0.05; roll.height = 0.44
			var mi := MeshInstance3D.new()
			mi.mesh = roll; mi.material_override = sc
			mi.rotation_degrees = Vector3(90, 0, 0)
			mi.position = p + Vector3(-0.33 + i * 0.22, y + 0.09, 0)
			add_child(mi)


func _bookshelf(p: Vector3) -> void:
	var w := _wood()
	_box(Vector3(2.2, 3.0, 0.5), p + Vector3(0, 1.5, -0.05), w)         # carcass
	var colors := [Color(0.5, 0.2, 0.2), Color(0.2, 0.3, 0.45), Color(0.3, 0.4, 0.25), Color(0.45, 0.4, 0.2)]
	for row in range(4):
		_box(Vector3(2.1, 0.06, 0.44), p + Vector3(0, 0.5 + row * 0.62, 0.05), w)   # shelf
		for i in range(9):
			var b := _flat(colors[(i + row) % colors.size()])
			_box(Vector3(0.11, 0.4, 0.3), p + Vector3(-0.95 + i * 0.22, 0.75 + row * 0.62, 0.08), b)


var _chars: Array[CharacterModel3D] = []


func _make_char(robe: Color, pos: Vector3) -> CharacterModel3D:
	var c := CharacterModel3D.new()
	c.robe_color = robe
	c.position = pos
	add_child(c)
	_chars.append(c)
	return c


func _build_characters() -> void:
	_make_char(Color(0.36, 0.40, 0.52), Vector3(0.0, 0, 0.6))     # Talindir, grey-blue
	_make_char(Color(0.44, 0.30, 0.22), Vector3(-1.8, 0, 1.6))    # citizen, warm brown
	_make_char(Color(0.28, 0.36, 0.28), Vector3(1.9, 0, 1.1))     # citizen, muted green


func _run() -> void:
	var cam := Camera3D.new()
	add_child(cam)
	cam.current = true

	# Pose the figures: one facing a front-right diagonal, one mid-stride walking, one turned away.
	_chars[0].face_dir(Vector3(0.6, 0, 1.0)); _chars[0].pose(0.0)
	_chars[1].face_dir(Vector3(1.0, 0, -0.2)); _chars[1].pose(1.3)
	_chars[2].face_dir(Vector3(-0.5, 0, -1.0)); _chars[2].pose(0.0)
	await get_tree().process_frame

	cam.position = Vector3(5.5, 4.6, 7.5); cam.look_at(Vector3(0, 1.0, -1.2), Vector3.UP)
	await get_tree().create_timer(0.4).timeout
	_shot(cam, "models_a_establishing.png")

	cam.position = Vector3(1.7, 1.7, 3.3); cam.look_at(Vector3(0.0, 1.35, 0.6), Vector3.UP)
	await get_tree().create_timer(0.3).timeout
	_shot(cam, "models_b_diagonal.png")

	# First-person eye height, close on a figure — the shot a billboard could never sell.
	cam.position = Vector3(0.3, 1.62, 2.4); cam.look_at(Vector3(-1.8, 1.35, 1.6), Vector3.UP)
	await get_tree().create_timer(0.3).timeout
	_shot(cam, "models_c_firstperson.png")

	get_tree().quit()


func _shot(cam: Camera3D, fname: String) -> void:
	var img: Image = get_viewport().get_texture().get_image()
	img.save_png("user://" + fname)
	print("saved ", fname)
