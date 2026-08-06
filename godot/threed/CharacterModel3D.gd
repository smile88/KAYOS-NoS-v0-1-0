@tool
extends Node3D
class_name CharacterModel3D
## A low-poly 3D character — a hooded robed figure — built from primitives, in the Daggerfall↔Morrowind
## register: chunky, flat-shaded, few polys, readable silhouette. This is the 3D alternative to the
## billboard NPC3D. Unlike a billboard it faces its MOVEMENT direction (not the camera), so there is no
## "flat card turning to look at you" and no quantised diagonal walk — it just rotates to wherever it is
## going and reads correctly from any orbit angle and in first person.
##
## A proof-of-concept for the "should characters be 3D models?" question. If we adopt it, real modelled/
## rigged characters replace these primitives the same way real art replaces the placeholder sprites.

@export var robe_color := Color(0.36, 0.40, 0.52)
@export var trim_color := Color(0.20, 0.22, 0.30)
@export var skin_color := Color(0.60, 0.50, 0.42)

var _arm_l: Node3D
var _arm_r: Node3D
var _moving := false
var _phase := 0.0
var _base_y := 0.0


func _ready() -> void:
	_build()


func _flat(color: Color, rough := 0.92) -> StandardMaterial3D:
	var m := StandardMaterial3D.new()
	m.albedo_color = color
	m.roughness = rough
	m.metallic = 0.0
	return m


func _add(mesh: Mesh, mat: Material, pos: Vector3, parent: Node3D = null) -> MeshInstance3D:
	var mi := MeshInstance3D.new()
	mi.mesh = mesh
	mi.material_override = mat
	mi.position = pos
	(parent if parent else self).add_child(mi)
	return mi


func _cyl(top: float, bottom: float, height: float) -> CylinderMesh:
	var c := CylinderMesh.new()
	c.top_radius = top
	c.bottom_radius = bottom
	c.height = height
	c.radial_segments = 10
	return c


func _sphere(r: float) -> SphereMesh:
	var s := SphereMesh.new()
	s.radius = r
	s.height = r * 2.0
	s.radial_segments = 10
	s.rings = 6
	return s


func _build() -> void:
	var robe_mat := _flat(robe_color)
	var trim_mat := _flat(trim_color)
	var skin_mat := _flat(skin_color)

	# Robe: a tapered cassock, wide at the hem, narrow at the shoulders. Base at y = 0.
	_add(_cyl(0.20, 0.40, 1.35), robe_mat, Vector3(0, 0.675, 0))
	# A darker hem band and a belt at the waist.
	_add(_cyl(0.41, 0.42, 0.10), trim_mat, Vector3(0, 0.06, 0))
	_add(_cyl(0.31, 0.31, 0.08), trim_mat, Vector3(0, 0.74, 0))
	# Shoulder mass — a little wider than the neck so the figure isn't a plain cone.
	_add(_cyl(0.26, 0.30, 0.18), robe_mat, Vector3(0, 1.28, 0))
	for sx in [-0.22, 0.22]:
		_add(_sphere(0.10), robe_mat, Vector3(sx, 1.30, 0))    # shoulder bumps

	# Head, set forward so the face emerges from the cowl; kept in shadow tone.
	_add(_sphere(0.12), _flat(skin_color.darkened(0.25)), Vector3(0, 1.50, 0.10))
	# Hood: a ROUNDED cowl that domes over and behind the head (no peak), with a short draped collar.
	var hood := _add(_sphere(0.21), robe_mat, Vector3(0, 1.51, -0.07))
	hood.scale = Vector3(1.02, 1.08, 1.05)
	_add(_cyl(0.20, 0.28, 0.16), robe_mat, Vector3(0, 1.36, -0.02))   # collar / cowl drape

	# Arms: sleeve capsules hanging from shoulder pivots, so a walk can swing them.
	_arm_l = Node3D.new(); _arm_l.position = Vector3(-0.26, 1.24, 0); add_child(_arm_l)
	_arm_r = Node3D.new(); _arm_r.position = Vector3(0.26, 1.24, 0); add_child(_arm_r)
	_add(_cyl(0.055, 0.085, 0.58), robe_mat, Vector3(0, -0.29, 0), _arm_l)
	_add(_cyl(0.055, 0.085, 0.58), robe_mat, Vector3(0, -0.29, 0), _arm_r)
	# Hands.
	_add(_sphere(0.06), skin_mat, Vector3(0, -0.58, 0), _arm_l)
	_add(_sphere(0.06), skin_mat, Vector3(0, -0.58, 0), _arm_r)

	_base_y = position.y


## Face a world-space direction on the ground (the model's front is +Z at yaw 0). No-op for zero.
func face_dir(world_dir: Vector3) -> void:
	var d := Vector3(world_dir.x, 0, world_dir.z)
	if d.length() < 0.001:
		return
	rotation.y = atan2(d.x, d.z)


func set_moving(m: bool) -> void:
	_moving = m


## Manually pose the walk at a phase (for stills). Live movement would just advance _phase in _process.
func pose(phase: float) -> void:
	_phase = phase
	_apply_pose()


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return   # stand in a fixed pose while just previewing the scene
	if _moving:
		_phase += delta * 7.0
		_apply_pose()


func _apply_pose() -> void:
	var swing := sin(_phase) * 0.5
	if _arm_l: _arm_l.rotation.x = swing
	if _arm_r: _arm_r.rotation.x = -swing
	# A small vertical bob on the whole figure, twice per stride.
	position.y = _base_y + absf(sin(_phase)) * 0.035
