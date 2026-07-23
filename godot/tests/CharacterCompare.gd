extends Node
## Side-by-side placeholder-character bake-off, so "which NPC placeholder?" is a look, not a debate.
##
## Three rows, all normalised to a 1.75 m adult per docs/Scale_Reference.md, standing on a paved plate
## next to a real FTK building and a 2.2 m doorway gate — the scale references that matter. Renders to
## art/greybox_renders/chars_*.png and quits.
##   godot --path godot res://tests/CharacterCompare.tscn

const OUT_REL := "res://../art/greybox_renders/"
const TARGET_H := 1.75                     # metres, an adult — the number every row is scaled to
const MINI := "res://assets/characters/mini/"
const BLOCKY := "res://assets/characters/blocky/"
const KAYKIT := "res://assets/characters/kaykit/"
const FTK := "res://assets/ftk/"

var _cam: Camera3D


func _ready() -> void:
	get_window().size = Vector2i(1600, 900)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_DISABLED
	_stage()
	_lights()
	_cam = Camera3D.new()
	_cam.fov = 45
	add_child(_cam)
	await get_tree().process_frame
	for i in range(30):
		await get_tree().process_frame
	await _shoot("chars_wide", Vector3(0, 3.0, 16.5), Vector3(0, 1.35, 0))
	await _shoot("chars_close", Vector3(-4.2, 1.9, 5.2), Vector3(-4.2, 1.05, 0.6))
	get_tree().quit(0)


func _shoot(name: String, pos: Vector3, look: Vector3) -> void:
	_cam.current = true
	_cam.global_position = pos
	_cam.look_at(look, Vector3.UP)
	for i in range(8):
		await get_tree().process_frame
	var img := get_viewport().get_texture().get_image()
	img.save_png(ProjectSettings.globalize_path(OUT_REL) + "%s.png" % name)
	print("saved %s.png" % name)


## Scale a loaded model so its visual height is TARGET_H, whatever the pack's native units are.
func _normalise(node: Node3D) -> float:
	var aabb := _aabb(node)
	if aabb.size.y <= 0.0:
		return 1.0
	return TARGET_H / aabb.size.y


func _aabb(node: Node) -> AABB:
	var box := AABB()
	var first := true
	for child in node.find_children("*", "MeshInstance3D", true, false):
		var mi := child as MeshInstance3D
		var b: AABB = mi.get_aabb()
		b = mi.global_transform * b if mi.is_inside_tree() else mi.transform * b
		if first:
			box = b
			first = false
		else:
			box = box.merge(b)
	return box


func _place(path: String, x: float, z: float, anim: String) -> void:
	var packed := load(path) as PackedScene
	if packed == null:
		push_warning("missing model: " + path)
		return
	var inst := packed.instantiate() as Node3D
	add_child(inst)
	inst.global_position = Vector3(x, 0, z)
	var s := _normalise(inst)
	inst.scale = Vector3(s, s, s)
	# re-seat on the ground after scaling (models are not all origin-at-feet)
	var box := _aabb(inst)
	inst.global_position = Vector3(x, -box.position.y, z)
	# models author +Z forward and the camera looks down -Z, so leave yaw at 0 to face the lens
	var players := inst.find_children("*", "AnimationPlayer", true, false)
	if players.size() > 0:
		var ap := players[0] as AnimationPlayer
		if ap.has_animation(anim):
			ap.play(anim)
		elif ap.has_animation("idle"):
			ap.play("idle")


func _label(text: String, x: float, z: float) -> void:
	var l := Label3D.new()
	l.text = text
	l.font_size = 96
	l.pixel_size = 0.0032
	l.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	l.modulate = Color(1, 0.95, 0.8)
	l.no_depth_test = true
	add_child(l)
	l.global_position = Vector3(x, 2.75, z)


func _stage() -> void:
	# paved plate
	var plate := MeshInstance3D.new()
	var pm := BoxMesh.new()
	pm.size = Vector3(24, 0.4, 14)
	plate.mesh = pm
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.42, 0.42, 0.46)
	mat.roughness = 0.95
	plate.mesh.surface_set_material(0, mat)
	add_child(plate)
	plate.global_position = Vector3(0, -0.2, 0)

	# ---- row 1: the CURRENT primitive NPC (what's in the game today)
	for i in range(2):
		var cm := CharacterModel3D.new()
		add_child(cm)
		cm.global_position = Vector3(-9.2 + i * 1.3, 0, -1.0)
	_label("CURRENT\n(primitives)", -8.6, -1.0)

	# ---- row 2: KayKit Adventurers — the fantasy-register option (skinned, 76 anims, CC0)
	var kay := ["Rogue_Hooded", "Mage", "Knight", "Barbarian"]
	for i in range(kay.size()):
		_place(KAYKIT + kay[i] + ".glb", -6.2 + i * 1.35, 0.6, "Idle")
	_label("KAYKIT ADVENTURERS\nfantasy · skinned · 76 anims", -4.2, 0.6)

	# ---- row 3: Kenney Mini (skinned, 32 anims) — modern register
	var mini := ["character-male-a", "character-female-b", "character-male-c"]
	for i in range(mini.size()):
		_place(MINI + mini[i] + ".glb", 0.6 + i * 1.3, 0.6, "idle")
	_label("KENNEY MINI\nmodern · 32 anims", 1.9, 0.6)

	# ---- row 4: Kenney Blocky (rigid parts, 27 anims) — modern register
	var blocky := ["character-a", "character-d", "character-h"]
	for i in range(blocky.size()):
		_place(BLOCKY + blocky[i] + ".glb", 4.9 + i * 1.3, 0.6, "idle")
	_label("KENNEY BLOCKY\nmodern · 27 anims", 6.2, 0.6)

	# ---- scale reference: the ACTUAL FTK door module at the CELL=3 the city builds it at, so the
	# "can we even walk through the doors?" question is answered by looking, next to a 1.75 m human.
	var b := load(FTK + "wall-door.glb") as PackedScene
	if b != null:
		var bi := b.instantiate() as Node3D
		add_child(bi)
		bi.scale = Vector3(3, 3, 3)         # CELL = 3.0, as StarfallCity3D uses
		bi.global_position = Vector3(9.0, 0, -3.5)
		_label("FTK wall-door\nat CELL=3", 9.0, -3.5)
	# a 1.75 m human standing in that doorway is the gauge
	_place(MINI + "character-male-e.glb", 9.0, -3.2, "idle")
	_gate(-7.0, 2.6)


## A 2.2 m x 1.4 m doorway frame — the Scale_Reference "can a person walk through this?" gauge.
func _gate(x: float, z: float) -> void:
	var mat := StandardMaterial3D.new()
	mat.albedo_color = Color(0.9, 0.75, 0.3)
	mat.emission_enabled = true
	mat.emission = Color(0.5, 0.4, 0.1)
	for piece in [[Vector3(0.08, 2.2, 0.08), Vector3(-0.7, 1.1, 0)],
				  [Vector3(0.08, 2.2, 0.08), Vector3(0.7, 1.1, 0)],
				  [Vector3(1.48, 0.08, 0.08), Vector3(0, 2.2, 0)]]:
		var mi := MeshInstance3D.new()
		var bm := BoxMesh.new()
		bm.size = piece[0]
		mi.mesh = bm
		mi.material_override = mat
		add_child(mi)
		mi.global_position = Vector3(x, 0, z) + piece[1]
	_label("2.2 m doorway", x, z)


func _lights() -> void:
	# neutral daylight — this is an asset read, not a mood shot; the night tint would hide the models
	var sun := DirectionalLight3D.new()
	sun.rotation_degrees = Vector3(-42, -35, 0)
	sun.light_energy = 1.15
	add_child(sun)
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.20, 0.22, 0.28)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.55, 0.58, 0.68)
	env.ambient_light_energy = 0.85
	var we := WorldEnvironment.new()
	we.environment = env
	add_child(we)
